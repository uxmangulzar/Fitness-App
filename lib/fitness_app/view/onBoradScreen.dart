import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/fitness_app/view/home.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  TextEditingController currentWeight = TextEditingController();
  TextEditingController goal = TextEditingController();
  TextEditingController weeklyGoal = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int _currentPage = 0;
  List<String> titles = ["Welcome", "Set Your Goal", "Get Started"];
  List<String> descriptions = [
    "Your ultimate fitness companion for a healthier lifestyle.",
    "Set your fitness goals and track your progress effortlessly.",
    "Get started now and enjoy using our app."
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      backgroundColor: AppColors.bgGray,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if (_currentPage != 1)
                          SizedBox(
                            height: AppSizes.appHorizontalXL,
                          ),
                        OnboardingPage(
                          image: "assets/images/fitnessApp_logo.png",
                          title: titles[index],
                          description: descriptions[index],
                        ),
                        if (_currentPage == 1)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "weight",
                                        style:
                                            styledText.copyWith(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppSizes.screenWidth * 0.6,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.white,

                                        style: const TextStyle(
                                            color: AppColors.kWhite),
                                        controller: currentWeight,
                                        decoration: InputDecoration(
                                          hintText: "current weight in Kg",
                                          hintStyle: const TextStyle(
                                              color: AppColors.kGrey),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                        ),
                                        // onChanged: filterFoods,
                                        validator: (val) {
                                          if (val!.isEmpty || val == "") {
                                            return "required";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.appVerticalMd,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Goal",
                                        style:
                                            styledText.copyWith(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppSizes.screenWidth * 0.6,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,

                                        style: const TextStyle(
                                            color: AppColors.kWhite),
                                        controller: goal,
                                        cursorColor: Colors.white,

                                        decoration: InputDecoration(
                                          hintText: "goal weight in Kg",
                                          hintStyle: const TextStyle(
                                              color: AppColors.kGrey),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                        ),
                                        // onChanged: filterFoods,
                                        validator: (val) {
                                          if (val!.isEmpty || val == "") {
                                            return "required";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: AppSizes.appVerticalMd,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Weekly Goal",
                                        style:
                                            styledText.copyWith(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppSizes.screenWidth * 0.6,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.white,

                                        style: const TextStyle(
                                            color: AppColors.kWhite),
                                        controller: weeklyGoal,
                                        decoration: InputDecoration(
                                          hintText: "weekly goal in Kg",
                                          hintStyle: const TextStyle(
                                              color: AppColors.kGrey),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors
                                                    .kWhite), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                24), // Adjust the radius as needed
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .red), // Border color when there's an error
                                          ),
                                        ),
                                        // onChanged: filterFoods,
                                        validator: (val) {
                                          if (val!.isEmpty || val == "") {
                                            return "required";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage != 0)
                    IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutSine,
                        );
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  if (_currentPage != 2)
                    IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  if (_currentPage == 2)
                    TextButton(
                      onPressed: () {
                        if (goal.text.trim().isEmpty &&
                            goal.text == "" &&
                            weeklyGoal.text.trim().isEmpty &&
                            weeklyGoal.text.trim() == "" &&
                            goal.text.trim().isEmpty &&
                            goal.text.trim() == "") {
                          alertSnackBar("Please set goal first");
                        } else {
                          if (int.parse(weeklyGoal.text.toString()) >=
                                  int.parse(goal.text.toString()) &&
                              int.parse(weeklyGoal.text.toString()) >=
                                  int.parse(currentWeight.text.toString())) {
                            alertSnackBar(
                                "Weekly goal can not same as current Weight and Goal Weight ");
                          } else {
                            User? user = auth.currentUser;
                            // double dailyCalories = calculateDailyCalories(double.parse(currentWeight.text.trim()), double.parse(weeklyGoal.text.trim()), double.parse(goal.text.trim()));
                            // print("====> dailyCalories $dailyCalories");

                            // GetStorage().write("calories", "$dailyCalories");

                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(user!.uid)
                                .collection("Calory")
                                .doc(auth.currentUser!.uid)
                                .set({"calory": dailyCalories.toString()});
                            weeklyGoal.clear();
                            goal.clear();
                            weeklyGoal.clear();
                            Get.to(() => const HomePage());
                          }
                        }
                      },
                      child: Text(
                        "Get Started",
                        style: styledText.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateDailyCalories(
      double currentWeight, double weeklyGoal, double goalWeight) {
    // Calculate the Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation
    double bmr = (10 * currentWeight) + (6.25 * goalWeight) - (5 * weeklyGoal);

    // Calculate the daily calorie deficit (500 calories deficit per 0.5 kg per week)
    double calorieDeficit = (weeklyGoal * 500) / 7;

    // Calculate the daily calorie intake
    double dailyCalories = bmr - calorieDeficit;

    return dailyCalories;
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 300,
          height: 300,
          color: Colors.white,
        ),
        Text(title,
            style:
                styledText.copyWith(fontSize: 36, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text(description,
            textAlign: TextAlign.center,
            style: styledText.copyWith(fontSize: 24)),
      ],
    );
  }
}
