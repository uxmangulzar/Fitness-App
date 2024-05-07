// ignore_for_file: dead_code

import 'package:fitness_app/fitness_app/view/admin/create_blog.dart';
import 'package:fitness_app/fitness_app/view/admin/training_titles_screen.dart';

import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';

import 'admin_recipe.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;
  Color color = Colors.white;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomWidget = [
      Column(
        children: [
          Icon(Icons.emoji_food_beverage_outlined,
              color: _currentIndex == 0 ? color : AppColors.bgGray),
          Text(
            "Recipes",
            style:
                TextStyle(color: _currentIndex == 0 ? color : AppColors.bgGray),
          )
        ],
      ),
      Column(
        children: [
          Icon(Icons.edit,
              color: _currentIndex == 1 ? color : AppColors.bgGray),
          Text(
            "Blogs",
            style:
                TextStyle(color: _currentIndex == 1 ? color : AppColors.bgGray),
          )
        ],
      ),
      Column(
        children: [
          Icon(Icons.title,
              color: _currentIndex == 2 ? color : AppColors.bgGray),
          Text(
            "Trainings",
            style:
                TextStyle(color: _currentIndex == 2 ? color : AppColors.bgGray),
          )
        ],
      ),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: const [
          // CaloriesPage(),
          AdminRecipe(),
          // AdminCategoryTest(),
          // SubcollectionStream(),
          CreateBlog(),
          TrainingTitleScreen()
          // ChatBoot()
        ],
      ),
      bottomNavigationBar: true
          ? Container(
              color: AppColors.primaryGreen,
              // height: 40,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          bottomWidget.length,
                          (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  _onItemTapped(index);
                                  if (_currentIndex == index) {
                                    color = Colors.white;
                                  } else {
                                    color = Colors.black;
                                  }
                                });
                              },
                              child:

                                  // Text(index.toString())

                                  // bottomWidget(widget: Image.asset("assets/images/monarch_logo.png",height: 20,color:color),string :"Monarch")

                                  // Column(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [Image.asset("assets/images/monarch_logo.png",height: 40,), Text("Monarch")],
                                  // ),
                                  // Text(index.toString())
                                  bottomWidget[index]))),
                ),
              ),
            )
          : BottomNavigationBar(
              backgroundColor: AppColors.lightGrey,
              selectedItemColor: AppColors.kWhite,
              unselectedItemColor: AppColors.kGrey,
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.food_bank,
                    ),
                    label: "Calories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.emoji_food_beverage_outlined),
                    label: "Recipes"),
                BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Blogs"),
                // BottomNavigationBarItem(icon: Icon(Icons.edit),label: "Train Routine"),
              ],
            ),
      // floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
  }
}
