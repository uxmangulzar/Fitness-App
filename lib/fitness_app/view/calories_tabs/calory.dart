import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/add_foodpage.dart';

import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

enum LegendShape { circle, rectangle }

class CaloriesTab extends StatefulWidget {
  const CaloriesTab({Key? key}) : super(key: key);

  @override
  CaloriesTabState createState() => CaloriesTabState();
}

class CaloriesTabState extends State<CaloriesTab> {
  DateTime currentDate = DateTime.now();
  RxString formattedDate = "".obs;
  RxBool isLoading = false.obs;
  RxString breakfastCal = "0".obs;
  RxString lunchCal = "0".obs;
  RxString dinnerCal = "0".obs;
  RxString snackCal = "0".obs;
  RxString perBreakfastCal = "0".obs;
  RxString perLunchCal = "0".obs;
  RxString perDinnerCal = "0".obs;
  RxString perSnackCal = "0".obs;
  RxString totalCal = "0".obs;

  final colorList = <Color>[
    AppColors.primaryGreen,
    AppColors.secondaryYellow,
    AppColors.primaryBlue,
    AppColors.secondaryOrange
  ];
  int key = 0;
  RxString getCal = "0".obs;
  @override
  void initState() {
    formattedDate.value = DateFormat.MMMd().add_y().format(currentDate);

    super.initState();
    cal();
    fetchBreakFastCal(formattedDate.value);
    fetchLunchCal(formattedDate.value);
    fetchDinnerCal(formattedDate.value);
    fetchSnackCal(formattedDate.value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // DateFormat('dd/MM/yyyy').format(currentDate);

    log("========d===${formattedDate.value}");
    AppSizes().init(context);
    final chart = Obx(() {
      RxMap<String, double> dataMap = <String, double>{
        "Breakfast": double.parse(breakfastCal.value.toString()),
        "Lunch": double.parse(lunchCal.value.toString()),
        "Dinner": double.parse(dinnerCal.value.toString()),
        "Snack": double.parse(snackCal.value.toString())
      }.obs;
      return PieChart(
        key: ValueKey(key),
        // ignore: invalid_use_of_protected_member
        dataMap: dataMap.value,
        animationDuration: const Duration(milliseconds: 800),
        chartRadius: math.min(MediaQuery.of(context).size.width / 2, 300),
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        centerText: "Today",
        baseChartColor: Colors.transparent,

        legendOptions: const LegendOptions(showLegends: false),
        chartValuesOptions: const ChartValuesOptions(
            showChartValues: false, showChartValuesInPercentage: true),
      );
    });

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      // appBar: AppBar(
      //   actions: [
      //     // ElevatedButton(
      //     //   onPressed: () {
      //     //     setState(() {
      //     //       key = key + 1;
      //     //     });
      //     //   },
      //     //   child: Text("Reload".toUpperCase()),
      //     // ),
      //   ],
      // ),
      body: Obx(
        () {
          totalCal.value = (int.parse(breakfastCal.value) +
                  int.parse(lunchCal.value) +
                  int.parse(dinnerCal.value) +
                  int.parse(snackCal.value))
              .toString();
          return SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: AppSizes.appVerticalMd,
                //   child: IntrinsicHeight(
                //
                //     child: Row(
                //       mainAxisSize: MainAxisSize.max,
                //       children: [
                //         ClipRRect(
                //           borderRadius: BorderRadius.circular(8),
                //
                //           child: Material(
                //             animationDuration: const Duration(milliseconds: 2500),
                //             color: Colors.transparent,
                //             child:  InkWell(
                //               onTap: (){log("tapped");},
                //               child:
                //               const Icon(
                //                 Icons.keyboard_arrow_left_rounded,
                //                 color: AppColors.kWhite,
                //                 size: 32,
                //               ),
                //             ),
                //           ),
                //         ),
                //         // InkWell(
                //         //   splashColor: AppColors.kWhite,
                //         //   highlightColor:AppColors.kWhite ,
                //         // focusColor: AppColors.kWhite,
                //         //   onTap: (){},
                //         //   child: Icon(
                //         //     Icons.keyboard_arrow_left_rounded,
                //         //     color: AppColors.kWhite,
                //         //     size: 32,
                //         //   ),
                //         // ),
                //         const VerticalDivider(
                //           color: AppColors.kGrey,
                //           thickness: 1,
                //         ),
                //         Expanded(
                //             child: Center(
                //                 child: Text(
                //           "Today",
                //           style: styledText.copyWith(fontSize: 18),
                //         ))),
                //         VerticalDivider(
                //           color: AppColors.kGrey,
                //           thickness: 1,
                //         ),
                //         ClipRRect(
                //             borderRadius: BorderRadius.circular(8),
                //           child: Material(
                //               animationDuration:const Duration(milliseconds: 2500),
                //             color: Colors.transparent,
                //             child:  InkWell(
                //               onTap: (){log("tapped");},
                //               child:
                //               const Icon(
                //                 Icons.keyboard_arrow_right_rounded,
                //                 color: AppColors.kWhite,
                //                 size: 32,
                //               ),
                //             ),
                //           ),
                //         ),
                //
                //
                //         // GestureDetector(
                //         //   onTap: (){},
                //         //   child: Icon(
                //         //     Icons.keyboard_arrow_right_rounded,
                //         //     color: AppColors.kWhite,
                //         //     size: 32,
                //         //   ),
                //         // )
                //       ],
                //     ),
                //   ),
                // ),

                isLoading.value == true
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(64.0),
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: AppSizes.appVerticalMd),
                          chart,
                          SizedBox(height: AppSizes.appVerticalMd),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryGreen,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Breakfast  ${calculatePercent(int.parse(breakfastCal.value)).toString().split(".").first.toString()} %",
                                              style: styledText,
                                            ),
                                            Text(
                                              // "${calculatePercent(totalBreakFastCalories.value).toString().split(".").first.toString()} % (${totalBreakFastCalories.value} Cal)",
                                              "${breakfastCal.value} Cal",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryGray),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: AppColors.secondaryYellow,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Lunch  ${calculatePercent(int.parse(lunchCal.value)).toString().split(".").first.toString()} %",
                                              style: styledText,
                                            ),
                                            Text(
                                              "${lunchCal.value} Cal",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryGray),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: AppSizes.screenHeight * 0.03, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Dinner  ${calculatePercent(int.parse(dinnerCal.value)).toString().split(".").first.toString()} % ",
                                              style: styledText,
                                            ),
                                            Text(
                                              "${dinnerCal.value} Cal",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryGray),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: AppColors.secondaryOrange,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Snack  ${calculatePercent(int.parse(snackCal.value)).toString().split(".").first.toString()}%",
                                              style: styledText,
                                            ),
                                            Text(
                                              "${snackCal.value} Cal",
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryGray),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppSizes.appVerticalMd,
                          ),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.bgGray,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              height: size.width * 0.06,
                              width: size.width * 0.83,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Calories",
                                    style: styledText.copyWith(
                                        color: AppColors.primaryBlue,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    totalCal.value.toString(),
                                    style: styledText.copyWith(
                                        fontSize: 20,
                                        color: AppColors.primaryBlue),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.bgGray,
                            elevation: 3,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              height: size.width * 0.06,
                              width: size.width * 0.83,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Net Calories",
                                    style: styledText.copyWith(
                                        color: AppColors.primaryBlue,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    totalCal.value.toString(),
                                    style: styledText.copyWith(
                                        fontSize: 20,
                                        color: AppColors.primaryBlue),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 40, bottom: 0),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryGreen,
          onPressed: () {
            Get.to(() => AddFood(
                  formattedDate: formattedDate.value,
                ));
            // Map<String, double> calculateNutrientGoals(double dailyCalories) {
            //   // Initialize the nutrient percentage ranges
            //   final Map<String, double> nutrientPercentages = {
            //     'Protein': 15, // Example percentage, you can adjust these as needed
            //     'Carbohydrates': 55,
            //     'Fat': 30,
            //     'Saturated Fat': 10,
            //     'Polyunsaturated Fat': 10,
            //     'Monounsaturated Fat': 20,
            //     'Cholesterol': 300, // milligrams per day
            //     'Sodium': 2300, // milligrams per day
            //   };
            //
            //   // Initialize the specific daily recommendations
            //   final Map<String, double> nutrientRecommendations = {
            //     'Fiber': 25, // grams per day
            //     'Sugar': dailyCalories * 0.1 / 4, // Less than 10% of total calories
            //     'Potassium': 4700, // milligrams per day
            //     'Vitamin A': 900, // micrograms for men
            //     'Vitamin C': 90, // milligrams for men
            //     'Calcium': 1000, // milligrams per day
            //     'Iron': 8, // milligrams for men
            //   };
            //
            //   // Calculate the nutrient goals based on percentage of total calories
            //   final Map<String, double> nutrientGoals = {};
            //
            //   nutrientPercentages.forEach((nutrient, percentage) {
            //     nutrientGoals[nutrient] = (percentage / 100) * dailyCalories;
            //   });
            //
            //   // Add the nutrient recommendations
            //   nutrientRecommendations.forEach((nutrient, recommendation) {
            //     nutrientGoals[nutrient] = recommendation;
            //   });
            //
            //   return nutrientGoals;
            // }
            //
            //
            //   double dailyCalories = 1000; // Replace with your daily calorie intake
            //
            //   Map<String, double> goals = calculateNutrientGoals(dailyCalories);
            //
            //   goals.forEach((nutrient, goal) {
            //     log("$nutrient: $goal");
            //   });

            // final foodData = {
            //   "food_name": "Salmon (Cooked)",
            //   "nutrients": {
            //     "protein": 25.4,
            //     "carbohydrates": 0,
            //     "fiber": 0,
            //     "sugar": 0,
            //     "fat": 13.4,
            //     "saturated_fat": 2.2,
            //     "polyunsaturated_fat": 3.1,
            //     "monounsaturated_fat": 5.8,
            //     "trans_fat": 0,
            //     "cholesterol": 71,
            //     "sodium": 50,
            //     "potassium": 363,
            //     "vitamin_a": 4,
            //     "vitamin_c": 0,
            //     "calcium": 8,
            //     "iron": 1
            //   }
            // };
            //
            // final calories = calculateCalories(foodData["nutrients"]);
            // log('Calories: ${double.parse(calories.toString())}');
            //
            //
            //
          },
          child: const Icon(Icons.search),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  cal() {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection("Calory")
        .doc(auth.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        getCal.value = data["calory"];
        log("===========data ${data["calory"]}");
      },
      onError: (e) => log("Error getting document: $e"),
    );
  }

  fetchBreakFastCal(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Breakfast")
        .doc(userId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          var data = doc.data() as Map<String, dynamic>;
          breakfastCal.value = data["calories"];
          log('====================== breakfastCal.value ${breakfastCal.value}');
          isLoading.value = false;
        } else {
          isLoading.value = false;
          breakfastCal.value = "0";
        }
      },
      onError: (e) {
        isLoading.value = false;
        log("Error getting document: $e");
      },
    );
  }

  fetchLunchCal(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Lunch")
        .doc(auth.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          var data = doc.data() as Map<String, dynamic>;
          lunchCal.value = data["calories"];
          isLoading.value = false;
        } else {
          lunchCal.value = "0";
          isLoading.value = false;
        }
      },
      onError: (e) {
        isLoading.value = false;
        log("Error getting document: $e");
      },
    );
  }

  fetchDinnerCal(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Dinner")
        .doc(auth.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          var data = doc.data() as Map<String, dynamic>;
          dinnerCal.value = data["calories"];
          isLoading.value = false;
        } else {
          dinnerCal.value = "0";
          isLoading.value = false;
        }
      },
      onError: (e) {
        isLoading.value = false;
        log("Error getting document: $e");
      },
    );
  }

  fetchSnackCal(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Snacks")
        .doc(auth.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          perSnackCal.value = "0";
          var data = doc.data() as Map<String, dynamic>;
          snackCal.value = data["calories"];
          perSnackCal.value = calculatePercent(int.parse(snackCal.value))
              .toString()
              .split(".")
              .first
              .toString();

          log("=============== perSnackCal.value ${perSnackCal.value}= cal ${calculatePercent(int.parse(snackCal.value))}=== snackCal.value ${snackCal.value}");
          isLoading.value = false;
        } else {
          snackCal.value = "0";

          isLoading.value = false;
        }
      },
      onError: (e) {
        isLoading.value = false;
        log("Error getting document: $e");
      },
    );
  }

  calculatePercent(int number) {
    return number != 0
        ? ((number / double.parse(totalCal.value)) * 100)
        : number;
  }
}
