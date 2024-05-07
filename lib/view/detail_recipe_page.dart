import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';

class DetailRecipe extends StatefulWidget {
  final Map<String, dynamic> recipe;
  const DetailRecipe({Key? key, required this.recipe}) : super(key: key);

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 12),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.kPrimary,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image.asset("assets/images/SpaghettiCarbonara.png"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.kPrimary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
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
                                widget.recipe.values.first["name"],
                                style: titleText.copyWith(fontSize: 28),
                              ),
                            ),
                            Image.asset(
                              "assets/bottom_icons/recipie.png",
                              height: 40,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.recipe.values.first["calories"].toString(),
                              style: titleText,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("Calories"),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        const Text(
                          "Ingredients",
                          style: titleText,
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.recipe.values.first["ingredients"].length,
                            (index) => Text(
                              widget.recipe.values.first["ingredients"][index]
                                  .toString(),
                              style: mediumText,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        const Text(
                          "Instructions",
                          style: titleText,
                        ),
                        SizedBox(
                          height: AppSizes.appVerticalSm,
                        ),
                        Text(
                          widget.recipe.values.first["instructions"].toString(),
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
