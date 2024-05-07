import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import 'addFoodTest.dart';

enum LegendShape { circle, rectangle }

class MacrosTab extends StatefulWidget {
  const MacrosTab({Key? key}) : super(key: key);

  @override
  MacrosTabState createState() => MacrosTabState();
}

class MacrosTabState extends State<MacrosTab> {
  DateTime currentDate = DateTime.now();
  RxString formattedDate = "".obs;
  RxString carbohaydrates = "10".obs;
  RxString fat = "25".obs;
  RxString protein = "50".obs;
  RxBool isLoading = false.obs;

  final colorList = <Color>[
    AppColors.secondaryYellow,
    AppColors.primaryBlue,
    AppColors.primaryGreen
  ];
  int key = 0;
  @override
  void initState() {
    formattedDate.value = DateFormat.MMMd().add_y().format(currentDate);
    fetchMacros(formattedDate.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AppSizes().init(context);
    final chart = Obx(() {
      final dataMap = <String, double>{
        "Carbohydrates": double.parse(carbohaydrates.value),
        "Fat": double.parse(fat.value),
        "Protein": double.parse(protein.value)
      };
      return PieChart(
        key: ValueKey(key),
        dataMap: dataMap,
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
      backgroundColor: AppColors.bgGray,
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
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.1,
              ),
              // SizedBox(
              //   height: AppSizes.appVerticalMd,
              //   child: IntrinsicHeight(
              //     child: Row(
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Material(
              //             animationDuration: const Duration(milliseconds: 2500),
              //             color: Colors.transparent,
              //             child: InkWell(
              //               onTap: () {
              //                 log("tapped");
              //               },
              //               child: const Icon(
              //                 Icons.keyboard_arrow_left_rounded,
              //                 color: AppColors.kWhite,
              //                 size: 32,
              //               ),
              //             ),
              //           ),
              //         ),
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
              //         const VerticalDivider(
              //           color: AppColors.kGrey,
              //           thickness: 1,
              //         ),
              //         ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Material(
              //             animationDuration: const Duration(milliseconds: 2500),
              //             color: Colors.transparent,
              //             child: InkWell(
              //               onTap: () {
              //                 log("tapped");
              //               },
              //               child: const Icon(
              //                 Icons.keyboard_arrow_right_rounded,
              //                 color: AppColors.kWhite,
              //                 size: 32,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              isLoading.value == true
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(64.0),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        chart,
                        SizedBox(
                          height: AppSizes.appVerticalMd,
                        ),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.bgGray,
                          child: SizedBox(
                            // margin: const EdgeInsets.all(20),
                            height: size.width * 0.15,
                            width: size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryGreen,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Protein",
                                          style: styledText.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "(g)",
                                          style: styledText.copyWith(
                                              color: AppColors.tertiaryGray),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Total',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        // "${totalNutrients["carbohydrates"].toString().split(".").first} ",
                                        protein.value
                                            .toString()
                                            .split(".")
                                            .first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Goal',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        goals.values
                                            .toList()[0]
                                            .toString()
                                            .split(".")
                                            .first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.bgGray,
                          child: SizedBox(
                            // margin: const EdgeInsets.all(20),
                            height: size.width * 0.15,
                            width: size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Fat",
                                          style: styledText.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "(g)",
                                          style: styledText.copyWith(
                                              color: AppColors.tertiaryGray),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Total',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        // "${totalNutrients["carbohydrates"].toString().split(".").first} ",
                                        fat.value.toString().split(".").first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Goal',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        goals.values
                                            .toList()[4]
                                            .toString()
                                            .split(".")
                                            .first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.bgGray,
                          child: SizedBox(
                            // margin: const EdgeInsets.all(20),
                            height: size.width * 0.15,
                            width: size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryYellow,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Carbohydrates",
                                          style: styledText.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "(g)",
                                          style: styledText.copyWith(
                                              color: AppColors.tertiaryGray),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Total',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        // "${totalNutrients["carbohydrates"].toString().split(".").first} ",
                                        carbohaydrates.value
                                            .toString()
                                            .split(".")
                                            .first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Goal',
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.009,
                                      ),
                                      Text(
                                        goals.values
                                            .toList()[1]
                                            .toString()
                                            .split(".")
                                            .first,
                                        style: styledText.copyWith(
                                            color: AppColors.tertiaryBlackText,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  fetchMacros(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Macros")
        .doc(userId);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        carbohaydrates.value = "0";
        fat.value = "0";
        protein.value = "0";
        final data = doc.data() as Map<String, dynamic>;
        carbohaydrates.value = data["carbohydrates"];
        fat.value = data["fat"];
        protein.value = data["protein"];
        log("===========data ${data["calory"]}");
        isLoading.value = false;
      } else {
        carbohaydrates.value = "0";
        fat.value = "0";
        protein.value = "0";
        isLoading.value = false;
      }
    }, onError: (e) {
      isLoading.value = false;
      carbohaydrates.value = "0";
      fat.value = "0";
      protein.value = "0";
      log("Error getting document: $e");
      false;
    });
  }
}

// class MacrosTab2 extends StatelessWidget {
//   MacrosTab2({Key? key}) : super(key: key);
//
//   final dataMap = <String, double>{
//     "Flutter": 5,
//   };
//
//   final colorList = <Color>[
//     Colors.greenAccent,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Pie Chart 1"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: PieChart(
//           dataMap: dataMap,
//           chartType: ChartType.ring,
//           baseChartColor: Colors.grey[50]!.withOpacity(0.15),
//           colorList: colorList,
//           chartValuesOptions: const ChartValuesOptions(
//             showChartValuesInPercentage: true,
//           ),
//           totalValue: 20,
//         ),
//       ),
//     );
//   }
// }
