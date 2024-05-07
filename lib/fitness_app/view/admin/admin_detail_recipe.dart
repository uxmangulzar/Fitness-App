// ignore_for_file: must_be_immutable

import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

class AdminDetailRecipe extends StatefulWidget {
  String? img;
  String? title;
  String? category;
  String? serve;
  String? calories;
  String? carb;
  String? fat;
  String? protein;
  String? ingredients;
  String? instruction;
  AdminDetailRecipe(
      {super.key,
      required this.img,
      required this.title,
      required this.category,
      required this.calories,
      required this.serve,
      required this.carb,
      required this.fat,
      required this.protein,
      required this.ingredients,
      required this.instruction});

  @override
  State<AdminDetailRecipe> createState() => _AdminDetailRecipeState();
}

class _AdminDetailRecipeState extends State<AdminDetailRecipe> {
  List<String> ingredients = [];
  int key = 1;

  final colorList = <Color>[
    AppColors.kLightGreen,
    AppColors.kLightPurple,
    AppColors.kOrange,
  ];

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Carbs": double.parse(widget.carb!),
      "Fat": double.parse(widget.fat!),
      "Protein": double.parse(widget.protein!),
    };
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: math.min(MediaQuery.of(context).size.width / 4, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      // centerText:  "HYBRID",
      emptyColor: AppColors.kGrey,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,

      legendOptions:
          const LegendOptions(showLegendsInRow: false, showLegends: false),
      chartValuesOptions: const ChartValuesOptions(
          showChartValues: false, showChartValuesInPercentage: false),
    );
    AppSizes().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  widget.img!,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 12),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primaryGreen,
                        )),
                  ),
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 40.0,left:12),
            //       child: InkWell(
            //           onTap: (){Get.back();},
            //           child:const Icon(Icons.arrow_back_ios,color: AppColors.kLightBlue,)),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.all(40.0),
            //         child:       widget.img==""? Image.asset("assets/images/SpaghettiCarbonara.png",height: 160,
            //           // width: 120,
            //           fit: BoxFit.fill,
            //         )
            //             :SizedBox(
            //             width:MediaQuery.of(context).size.width,
            //             child:
            //             Image.network(widget.img!,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,)),
            //         // Image.asset("assets/images/SpaghettiCarbonara.png"),
            //       ),
            //     ),
            //   ],
            // ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.bgGray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title!,
                                style: titleText.copyWith(
                                    fontSize: 28,
                                    color: AppColors.primaryGreen),
                              ),
                            ),
                            Image.asset(
                              "assets/bottom_icons/recipie.png",
                              height: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text("Serve",
                                style: styledText.copyWith(
                                    color: AppColors.primaryGreen)),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.serve!,
                              style: titleText.copyWith(
                                  color: AppColors.primaryGreen),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.calories!,
                              style: titleText.copyWith(
                                  color: AppColors.primaryGreen),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Calories",
                                style: styledText.copyWith(
                                    color: AppColors.primaryGreen)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            chart,
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        color: AppColors.kLightGreen,
                                        child: const SizedBox(),
                                      ),
                                    ),
                                    Text(widget.carb!,
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen)),
                                  ],
                                ),
                                Text("Carbs",
                                    style: styledText.copyWith(
                                        color: AppColors.primaryGreen)),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        color: AppColors.kLightPurple,
                                        child: const SizedBox(),
                                      ),
                                    ),
                                    Text(widget.fat!,
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen)),
                                  ],
                                ),
                                Text("Fat",
                                    style: styledText.copyWith(
                                        color: AppColors.primaryGreen)),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        color: AppColors.kOrange,
                                        child: const SizedBox(),
                                      ),
                                    ),
                                    Text(widget.protein!,
                                        style: styledText.copyWith(
                                            color: AppColors.primaryGreen)),
                                  ],
                                ),
                                Text("Protein",
                                    style: styledText.copyWith(
                                        color: AppColors.primaryGreen)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        Text(
                          "Ingredients",
                          style:
                              titleText.copyWith(color: AppColors.primaryGreen),
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.ingredients!.removeAllWhitespace
                                .split(",")
                                .toList()
                                .length,
                            (index) => Text(
                              widget.ingredients!
                                  .split(",")
                                  .toList()[index]
                                  .toString()
                                  .trim(),
                              textAlign: TextAlign.start,
                              style: mediumText.copyWith(
                                  color: AppColors.primaryGreen),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        Text(
                          "Instructions",
                          style:
                              titleText.copyWith(color: AppColors.primaryGreen),
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        Text(
                          widget.instruction.toString(),
                          style: styledText.copyWith(
                              color: AppColors.primaryGreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )

            // ...
            // The rest of your RecipeCard widget remains the same
          ],
        ),
      ),
    );
  }
}
