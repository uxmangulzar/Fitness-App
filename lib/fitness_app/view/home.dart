// ignore_for_file: dead_code

import 'dart:io';
import 'package:fitness_app/fitness_app/openAi/ai_bots_starting_page.dart';
import 'package:fitness_app/fitness_app/view/blogs.dart';
import 'package:fitness_app/fitness_app/view/calories.dart';
import 'package:fitness_app/fitness_app/view/recipe.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/view/screens/training/screens/training_screen.dart';
import 'package:fitness_app/view/widgets/custom_app_bar.dart';
import 'package:fitness_app/view/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RxInt _currentIndex = 0.obs;
  Color color = AppColors.primaryGreen;
  final PageController _pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex.value = index;
      _pageController.jumpToPage(
        index,
        // duration: const Duration(milliseconds: 300), curve: Curves.easeInOut
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (Platform.isIOS) {
            exit(0);
          } else if (Platform.isAndroid) {
            SystemNavigator.pop();
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.kWhite,
          appBar: CustomAppBar(index: _currentIndex.value),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppSizes.screenWidth * 0.03),
            child: PageView(
              controller: _pageController,
              onPageChanged: (val) {
                _onItemTapped(val);
              },
              children: const [
                CaloriesPage(),
                RecipePage(),
                BlogsPage(),
                TrainingScreen(),
                AiStartingPage(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.h),
            child: CustomBottomBar(
              selectedIndex: _currentIndex,
              onPress: (index) => _onItemTapped(index),
            ),
          ),
        ));
  }
}
