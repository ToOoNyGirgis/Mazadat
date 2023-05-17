import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/home_body_cubit/home_body_cubit.dart';
import 'package:news_app/cubits/home_cubit/home_cubit.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/services/get_item_service.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = [];

  @override
  void initState() {
    super.initState();
    CategoriesService().getCategories().then((data) {
      setState(() {
        categories = data;
      });
    }).catchError((error) {
      print(error);
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
    print(category.id);
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
          print(state.items);

          if (state.items.isNotEmpty) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Card(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                state.items[index].subCategory,
                                style: TextStyle(fontSize: 24.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 250.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(state.items[index].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              state.items[index].title,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('عذراً لا توجد بيانات'));
        } else if (state is HomeBodyFailure) {
          return Center(
              child: Text(
            'حدث خطأ أثناء عرض البيانات: ${state.errMessage}',
            style: const TextStyle(fontSize: 22),
          ));
        } else if (state is HomeBodyNoInternet) {
          return const Text('تأكد من وجود انترنت');
        } else
          return const Text('عذرا لا توجد بيانات');
      },
    );

    // homeCubit.getDataForEachTab(index);

    // return Padding(
    //   padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
    //   child: BlocBuilder<HomeCubit, HomeState>(
    //     bloc: homeCubit,
    //     builder: (context, state) {
    //       if (state is HomeBodyLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is HomeBodySuccess) {
    //         return ListView.builder(
    //           physics: const BouncingScrollPhysics(),
    //           itemCount: state.items.length,
    //           itemBuilder: (context, index) => Padding(
    //             padding: const EdgeInsets.only(top: 20),
    //             child: Column(
    //               children: [
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: SizedBox(
    //                     width: double.infinity,
    //                     child: Text(
    //                       state.items[index].subCategory,
    //                       style: TextStyle(fontSize: 24.sp),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 2.h,
    //                 ),
    //                 Container(
    //                   height: 250.0,
    //                   width: MediaQuery.of(context).size.width,
    //                   decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                       image: NetworkImage(state.items[index].image),
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 2.h,
    //                 ),
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: Text(
    //                     state.items[index].title,
    //                     style: TextStyle(fontSize: 24.sp),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       } else if (state is HomeBodyNoInternet) {
    //         return Center(
    //           child: Text(
    //             'لا يوجد اتصال بالإنترنت',
    //             style: TextStyle(fontSize: 24.sp),
    //           ),
    //         );
    //       } else if (state is HomeBodyFailure) {
    //         return Center(
    //           child: Text(
    //             'حدث خطأ أثناء عرض البيانات: ${state.errMessage}',
    //             style: TextStyle(fontSize: 24.sp),
    //           ),
    //         );
    //       } else {
    //         return const SizedBox.shrink();
    //       }
    //     },
    //   ),
    // );
  }
}
