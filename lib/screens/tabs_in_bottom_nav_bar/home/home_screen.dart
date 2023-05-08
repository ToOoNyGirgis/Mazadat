import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/home_cubit/home_cubit.dart';
import 'package:news_app/models/categories_model.dart';
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
    final homeCubit = HomeCubit(CategoriesService(), ItemService());

    homeCubit.loadHomeData();

    return BlocProvider(
      create: (context) => HomeCubit(CategoriesService(), ItemService()),
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الصفحة الرئيسية'),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kTextTabBarHeight),
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
          body: Padding(
            padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
            child: BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeSuccess) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                                fit: BoxFit.cover,
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
                  );
                } else if (state is HomeNoInternet) {
                  return Center(
                    child: Text(
                      'لا يوجد اتصال بالإنترنت',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  );
                } else if (state is HomeFailure) {
                  return Center(
                    child: Text(
                      'حدث خطأ أثناء عرض البيانات: ${state.errMessage}',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
