import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/model/nutients_model.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utill/app_size.dart';
import '../../../utill/get_di.dart';

class NutrientsTab extends StatefulWidget {
  const NutrientsTab({Key? key}) : super(key: key);

  @override
  State<NutrientsTab> createState() => _NutrientsTabState();
}

class _NutrientsTabState extends State<NutrientsTab> {
  DateTime currentDate = DateTime.now();
  RxString formattedDate = "".obs;
  List<String> goalsList = [];

  List<Nutrients> nutrients = [];
  Map<String, dynamic> fetchedNutrients = {};
  RxList<String> nutrientsName = <String>[].obs;
  RxList<String> nt = <String>[].obs;
  RxList<String> nValue = <String>[].obs;
  RxBool isLoading = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate.value = DateFormat.MMMd().add_y().format(currentDate);
    // fetchNutrientsByDate(formattedDate!);
    fetch(formattedDate.value);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    goalsList.clear();

    return Scaffold(
      backgroundColor: AppColors.bgGray,
      body: Obx(() {
        goalsList.clear();
        nt.clear();
        goals.values.map((e) => goalsList.add(e.toString())).toList();
        goals.keys.map((e) => nt.add(e.toString())).toList();
        log("-------- nt $nt");
        return SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: IntrinsicHeight(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         IconButton(
              //           icon: const Icon(
              //             Icons.keyboard_arrow_left_rounded,
              //             color: AppColors.kWhite,
              //             size: 32,
              //           ),
              //           onPressed: () {
              //             // Navigate to the previous day
              //             currentDate =
              //                 currentDate.subtract(const Duration(days: 1));
              //             formattedDate.value =
              //                 DateFormat.MMMd().add_y().format(currentDate);
              //             nValue.clear();
              //             nutrientsName.clear();
              //             fetch(formattedDate.value);
              //           },
              //         ),
              //         const VerticalDivider(
              //           color: AppColors.kGrey,
              //           thickness: 1,
              //         ),
              //         Expanded(
              //           child: Center(
              //             child: Text(
              //               formattedDate.value,
              //               style: styledText.copyWith(fontSize: 18),
              //             ),
              //           ),
              //         ),
              //         const VerticalDivider(
              //           color: AppColors.kGrey,
              //           thickness: 1,
              //         ),
              //         IconButton(
              //           icon: const Icon(
              //             Icons.keyboard_arrow_right_rounded,
              //             color: AppColors.kWhite,
              //             size: 32,
              //           ),
              //           onPressed: () {
              //             // Navigate to the next day
              //             currentDate =
              //                 currentDate.add(const Duration(days: 1));
              //             formattedDate.value =
              //                 DateFormat.MMMd().add_y().format(currentDate);
              //             nValue.clear();
              //             nutrientsName.clear();
              //             fetch(formattedDate.value);
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 6, right: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Today',
                      style: titleText.copyWith(color: AppColors.primaryBlue),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                        // flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Total",
                              style: styledText.copyWith(
                                  color: AppColors.primaryBlue),
                            ))),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Goal",
                              style: styledText.copyWith(
                                  color: AppColors.primaryGreen),
                            ))),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Left",
                              style: styledText.copyWith(
                                  color: AppColors.secondaryOrange),
                            ))),
                  ],
                ),
              ),
              isLoading.value == true
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(64.0),
                        child: CircularProgressIndicator(
                          color: AppColors.kOrange,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: nutrientsName.isEmpty
                          ? List.generate(
                              nt.length,
                              (index) => rowsData(
                                  nt[index].toUpperCase().replaceAll("_", " "),
                                  "0",
                                  goalsList[index].toString().split(".").first,
                                  (double.parse(goalsList[index].toString()))
                                      .toString()
                                      .split(".")
                                      .first,
                                  0.0))
                          : List.generate(
                              nutrientsName.length,
                              (index) => rowsData(
                                  nutrientsName[index]
                                      .toUpperCase()
                                      .replaceAll("_", " "),
                                  nValue[index].split(".").first.toString(),
                                  goalsList[index].toString().split(".").first,
                                  (double.parse(goalsList[index].toString()) -
                                          double.parse(
                                              nValue[index].toString()))
                                      .toString()
                                      .split(".")
                                      .first,
                                  0.0),
                            )),
            ],
          ),
        );
      }),
    );
  }

  Future<void> fetchNutrientsByDate(String date) async {
    final querySnapshot = await firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection("$formattedDate")
        .doc(userId)
        .collection("Nutrients")
        // .where('date', isEqualTo: date)
        .get();
    setState(() {
      // Nutrients.fromJson(querySnapshot.docs.toMap());

      // log("====querySnapshot.docs ${querySnapshot.docs.first["fat"]}");
      nutrients = querySnapshot.docs
          .map((doc) => Nutrients(fat: doc["fat"].toString()))
          .toList();
    });
  }

  fetch(String date) {
    isLoading.value = true;
    final docRef = firestore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection(date)
        .doc(userId)
        .collection("Nutrients")
        .doc(auth.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          fetchedNutrients = doc.data() as Map<String, dynamic>;
          // ignore: invalid_use_of_protected_member
          fetchedNutrients.keys.map((e) => nutrientsName.value.add(e)).toList();
          fetchedNutrients.values
              // ignore: invalid_use_of_protected_member
              .map((e) => nValue.value.add(e.toString()))
              .toList();
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      },
      onError: (e) {
        isLoading.value = false;
        log("Error getting document: $e");
      },
    );
  }
}

Widget rowsData(
    String name, String total, String goal, String left, double progress) {
  return Container(
    margin: EdgeInsets.only(bottom: AppSizes.screenHeight * 0.01),
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    decoration: BoxDecoration(
        border: Border.all(
          color:
              AppColors.primaryBlue, // Specify your desired border color here
          //width: 2.0, // Specify the border width
        ),
        borderRadius: BorderRadius.circular(4)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            flex: 2,
            child: Text(name,
                style: styledText.copyWith(color: AppColors.primaryBlue))),
        Expanded(
            // flex: ,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  total,
                  style: styledText.copyWith(color: AppColors.primaryBlue),
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  goal,
                  style: styledText.copyWith(color: AppColors.primaryGreen),
                ))),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  left,
                  style: styledText.copyWith(color: AppColors.secondaryOrange),
                ))),
      ],
    ),
  );
}
