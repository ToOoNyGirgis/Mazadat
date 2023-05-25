import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/cubits/home_body_cubit/home_body_cubit.dart';
import 'package:news_app/cubits/home_cubit/home_cubit.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/services/get_item_service.dart';
import 'package:news_app/services/notification_service.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = [];
  NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.setupInteractMessage(context);
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token is $value');
      }
    });
    CategoriesService().getCategories().then((data) {
      setState(() {
        categories = data;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit(CategoriesService());

    homeCubit.loadHomeData();

    return BlocProvider(
      create: (context) => HomeCubit(CategoriesService()),
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                builder: (context, state) {
                  if (state is HomeSuccess) {
                    return TabBar(
                      isScrollable: true,
                      tabs: state.category
                          .map((category) => Tab(text: category.name))
                          .toList(),
                    );
                  } else {
                    return Container(
                      height: 10,
                    );
                  }
                },
              ),
            ),
          ),
          body: TabBarView(
            children: categories
                .map((category) => TabBarViewBody(
                      category: category,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class TabBarViewBody extends StatelessWidget {
  TabBarViewBody({
    super.key,
    required this.category,
  });

  final CategoriesModel category;
  List<ItemsModel> items = [];

  @override
  Widget build(BuildContext context) {
    final homeBodyCubit = HomeBodyCubit(ItemService());
    homeBodyCubit.getDataForEachTab(category.id);
    return BlocBuilder<HomeBodyCubit, HomeBodyState>(
      bloc: homeBodyCubit,
      builder: (context, state) {
        if (state is HomeBodyLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeBodySuccess) {

          if (state.items.isNotEmpty) {
            return Padding(
              padding:  EdgeInsets.only(top: 2.h),
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        child: ListTile(
                          title: Text(state.items[index].title),
                          leading: Image.network(state.items[index].image),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.items[index].subCategory),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(state.items[index].date),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return  Center(child: Text('عذراً لا توجد بيانات',style: TextStyle(fontSize: 18.sp),));
        } else if (state is HomeBodyFailure) {
          return Center(
              child: Text(
            'حدث خطأ أثناء عرض البيانات: ${state.errMessage}',
            style: const TextStyle(fontSize: 22),
          ));
        } else if (state is HomeBodyNoInternet) {
          return Center(child:  Text('تأكد من وجود انترنت',style: TextStyle(fontSize: 18.sp),));
        } else {
          return Center(child:  Text('عذرا لا توجد بيانات',style: TextStyle(fontSize: 18.sp),));
        }
      },
    );


  }
}
