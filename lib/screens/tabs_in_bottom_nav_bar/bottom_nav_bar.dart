import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/cubits/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/favorites/favorites_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/home/home_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/more/more_screen.dart';
import 'package:sizer/sizer.dart';

import 'category/category_screen.dart';


class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);
  static String id='BottomNavBarScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavBarCubit, int>(
          builder: (context, state) {
             List<Widget> tabs = [
              const HomeScreen(),
              const FavoritesScreen(),
              CategoryScreen(),
              const MoreScreen(),
            ];
            return tabs[state];
          },
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: BlocBuilder<BottomNavBarCubit, int>(
              builder: (context, state) {
                return GNav(
                  iconSize: 22.sp,
                  padding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'الرئيسية',
                    ),
                    GButton(
                      icon: Icons.star,
                      text: 'المفضلة',
                    ),
                    GButton(
                      icon: Icons.category,
                      text: 'تصنيفات',
                    ),
                    GButton(
                      icon: Icons.more_horiz,
                      text: 'المزيد',
                    ),
                  ],
                  selectedIndex: state,
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.white.withOpacity(0.2),
                  rippleColor: Colors.white.withOpacity(0.2),
                  onTabChange: (value) =>
                      BlocProvider.of<BottomNavBarCubit>(context).selectTab(value),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}