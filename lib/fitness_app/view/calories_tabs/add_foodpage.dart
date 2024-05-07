// ignore_for_file: dead_code

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/home.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addFoodTest.dart';

class AddFood extends StatefulWidget {
  final String? formattedDate;
  const AddFood({Key? key, required this.formattedDate}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String selectedValue = 'Breakfast';
  List<String> dropdownItems = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  final List<String> allFoods = [
    'Pizza',
    'Sushi',
    'Spaghetti',
    'Hamburger',
    'Tacos',
    'Salad',
    'Fried Chicken',
    'Ice Cream',
    'Pancakes',
    'Steak',
  ];

  List<String> filteredFoods = [];
  String searchText = '';
  @override
  void initState() {
    super.initState();
    filteredFoods = allFoods;
  }

  void filterFoods(String query) {
    setState(() {
      filteredFoods = allFoods
          .where((food) => food.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    log("============== formattedDate ${widget.formattedDate}");
    return WillPopScope(
      onWillPop: () async {
        Get.close(2);
        Get.to(() => const HomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              true
                  ? DropdownButton<String>(
                      value: selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                    color: AppColors.bgGray,
                                    fontSize: 20), // White text
                              ),
                              const Divider(
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        // backgroundColor: Colors.black, // Black background
                        color: AppColors
                            .kDarkSky1, // White text for the selected item
                      ),
                      dropdownColor: AppColors
                          .kGreyShade, // Black background for dropdown menu
                      underline: const SizedBox(),
                      icon: const SizedBox(),
                    )
                  : DropdownButton<String>(
                      value: selectedValue,
                      iconEnabledColor: AppColors.kDarkSky1,
                      iconDisabledColor: AppColors.kDarkSky1,
                      underline: const SizedBox(),
                      padding: EdgeInsets.zero,
                      dropdownColor: AppColors.primaryGreen,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item,
                                style:
                                    styledText.copyWith(color: AppColors.kGrey),
                              ),
                              const Divider(
                                color: AppColors.kGrey,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.close(2);
                Get.to(() => const HomePage());
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: AppColors.kDarkSky1),
                // controller: TextEditingController(),
                cursorColor: AppColors.primaryGreen,

                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.kWhite,
                  ),
                  hintText: "Search for a food",
                  hintStyle: const TextStyle(color: AppColors.kGrey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.kWhite), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.kWhite), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
              ),
            ),
            true
                ? Expanded(
                    child: ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (BuildContext context, int index) {
                        final food = foods[index];
                        final foodName = food["food_name"].toLowerCase();
                        if (searchText.isNotEmpty &&
                            !foodName.contains(searchText)) {
                          return const SizedBox
                              .shrink(); // Hide the item if not matching search
                        }
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(food["food_name"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Protein: ${food['nutrients']['protein']} g"),
                                Text(
                                    "Carbohydrates: ${food['nutrients']['carbohydrates']} g"),
// Add more nutrient information as needed
                              ],
                            ),
                            trailing: true
                                ? ClipOval(
                                    child: Material(
                                      color: AppColors.bgGray, // Button color
                                      child: InkWell(
                                        splashColor: AppColors
                                            .primaryGreen, // Splash color
                                        onTap: () {
                                          final calories =
                                              calculateCalories(food);
                                          totalCalories.value += calories;

                                          // Calculate and add nutrients to the total
                                          food["nutrients"]
                                              .forEach((key, value) {
                                            if (totalNutrients
                                                .containsKey(key)) {
                                              totalNutrients[key] =
                                                  (totalNutrients[key] ?? 0) +
                                                      value;
                                            }
                                          });
                                          if (selectedValue == "Breakfast") {
                                            totalBreakFastCalories =
                                                totalBreakFastCalories +
                                                    (calories);
                                            fireStore
                                                .collection("Users")
                                                .doc(userId)
                                                .collection("Foods")
                                                .doc(userId)
                                                .collection(
                                                    "${widget.formattedDate}")
                                                .doc(userId)
                                                .collection("Nutrients")
                                                .doc(userId)
                                                .set(totalNutrients)
                                                .whenComplete(() {
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection(selectedValue)
                                                  .doc(userId)
                                                  .set({
                                                "calories":
                                                    totalBreakFastCalories.value
                                                        .toString()
                                              });
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection("Macros")
                                                  .doc(userId)
                                                  .set({
                                                "carbohydrates": totalNutrients[
                                                        "carbohydrates"]
                                                    .toString(),
                                                "fat": totalNutrients["fat"]
                                                    .toString(),
                                                "protein":
                                                    totalNutrients["protein"]
                                                        .toString(),
                                              });
                                            });
                                          } else if (selectedValue == "Lunch") {
                                            totalLunchCalories =
                                                totalLunchCalories + (calories);
                                            fireStore
                                                .collection("Users")
                                                .doc(userId)
                                                .collection("Foods")
                                                .doc(userId)
                                                .collection(
                                                    "${widget.formattedDate}")
                                                .doc(userId)
                                                .collection("Nutrients")
                                                .doc(userId)
                                                .set(totalNutrients)
                                                .whenComplete(() {
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection(selectedValue)
                                                  .doc(userId)
                                                  .set({
                                                "calories": totalLunchCalories
                                                    .value
                                                    .toString()
                                              });
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection("Macros")
                                                  .doc(userId)
                                                  .set({
                                                "carbohydrates": totalNutrients[
                                                        "carbohydrates"]
                                                    .toString(),
                                                "fat": totalNutrients["fat"]
                                                    .toString(),
                                                "protein":
                                                    totalNutrients["protein"]
                                                        .toString(),
                                              });
                                            });
                                          } else if (selectedValue ==
                                              "Dinner") {
                                            totalDinnerCalories =
                                                totalDinnerCalories +
                                                    (calories);
                                            fireStore
                                                .collection("Users")
                                                .doc(userId)
                                                .collection("Foods")
                                                .doc(userId)
                                                .collection(
                                                    "${widget.formattedDate}")
                                                .doc(userId)
                                                .collection("Nutrients")
                                                .doc(userId)
                                                .set(totalNutrients)
                                                .whenComplete(() {
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection(selectedValue)
                                                  .doc(userId)
                                                  .set({
                                                "calories": totalDinnerCalories
                                                    .value
                                                    .toString()
                                              });
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection("Macros")
                                                  .doc(userId)
                                                  .set({
                                                "carbohydrates": totalNutrients[
                                                        "carbohydrates"]
                                                    .toString(),
                                                "fat": totalNutrients["fat"]
                                                    .toString(),
                                                "protein":
                                                    totalNutrients["protein"]
                                                        .toString(),
                                              });
                                            });
                                          } else {
                                            totalSnackCalories =
                                                totalSnackCalories + (calories);
                                            fireStore
                                                .collection("Users")
                                                .doc(userId)
                                                .collection("Foods")
                                                .doc(userId)
                                                .collection(
                                                    "${widget.formattedDate}")
                                                .doc(userId)
                                                .collection("Nutrients")
                                                .doc(userId)
                                                .set(totalNutrients)
                                                .whenComplete(() {
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection(selectedValue)
                                                  .doc(userId)
                                                  .set({
                                                "calories": totalSnackCalories
                                                    .value
                                                    .toString()
                                              });
                                              fireStore
                                                  .collection("Users")
                                                  .doc(userId)
                                                  .collection("Foods")
                                                  .doc(userId)
                                                  .collection(
                                                      "${widget.formattedDate}")
                                                  .doc(userId)
                                                  .collection("Macros")
                                                  .doc(userId)
                                                  .set({
                                                "carbohydrates": totalNutrients[
                                                        "carbohydrates"]
                                                    .toString(),
                                                "fat": totalNutrients["fat"]
                                                    .toString(),
                                                "protein":
                                                    totalNutrients["protein"]
                                                        .toString(),
                                              });
                                            });
                                          }

                                          Get.snackbar("Message",
                                              "${food["food_name"]} Is Added To $selectedValue Meal",
                                              backgroundColor:
                                                  AppColors.primaryGreen,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              duration: const Duration(
                                                  milliseconds: 1000));

                                          // log("=========== Foods ${widget.formattedDate}");

// cal();
                                        },
                                        child: const SizedBox(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.primaryGreen,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      // Calculate and add calories to the total
                                      // setState(() {
                                      final calories = calculateCalories(food);
                                      totalCalories.value += calories;

                                      // Calculate and add nutrients to the total
                                      food["nutrients"].forEach((key, value) {
                                        if (totalNutrients.containsKey(key)) {
                                          totalNutrients[key] =
                                              (totalNutrients[key] ?? 0) +
                                                  value;
                                        }
                                      });
                                      if (selectedValue == "Breakfast") {
                                        log("===totalBreakFastCalories $totalBreakFastCalories");
                                        totalBreakFastCalories =
                                            totalBreakFastCalories + (calories);
                                        log("===totalBreakFastCalories $totalBreakFastCalories");
                                      } else if (selectedValue == "Lunch") {
                                        totalLunchCalories =
                                            totalLunchCalories + (calories);
                                      } else if (selectedValue == "Dinner") {
                                        totalDinnerCalories =
                                            totalDinnerCalories + (calories);
                                      } else {
                                        totalSnackCalories =
                                            totalSnackCalories + (calories);
                                      }
                                      // Show a snackbar with the updated total calories
                                      // }); // Update the UI
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppColors.lightGrey,
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.primaryGreen,
                                        size: 24,
                                      ),
                                    )),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: List.generate(
                          filteredFoods.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: AppColors.bgGray,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          filteredFoods[index].toString(),
                                          style: styledText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    )),
                  )
          ],
        ),
      ),
    );
  }

  cal() {
    final docRef = fireStore
        .collection("Users")
        .doc(userId)
        .collection("Foods")
        .doc(userId)
        .collection("${widget.formattedDate}")
        .doc(userId)
        .collection("Nutrients")
        .doc(userId)
        .collection(selectedValue)
        .doc(userId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        log("===========iron ${data["iron"]}");
      },
      onError: (e) => log("Error getting document: $e"),
    );
  }
}
