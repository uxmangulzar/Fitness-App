import 'package:fitness_app/provider/recipe_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodMenuList extends StatelessWidget {
  const FoodMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.screenHeight,
      child: ListView.builder(
          itemCount: foodList.length,
          itemBuilder: (context, index) {
            final food = foodList[index];
            return Consumer<RecipeProvider>(builder: (context, value, child) {
              return GestureDetector(
                onTap: () => value.setSelectedFood(food),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 35.v, horizontal: 0),
                  child: Transform.rotate(
                    angle: -1.5708,
                    child: Column(
                      children: [
                        Text(food,
                            style: styledText.copyWith(
                                color: value.selectedFood == food
                                    ? AppColors.primaryBlue
                                    : AppColors.primaryBlue.withOpacity(0.3),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        if (value.selectedFood == food)
                          Container(
                            height: 8.adaptSize,
                            width: 8.adaptSize,
                            margin: EdgeInsets.symmetric(vertical: 10.v),
                            decoration: BoxDecoration(
                              color: appTheme.cyan700,
                              borderRadius: BorderRadius.circular(
                                4.h,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }),
    );
  }
}
