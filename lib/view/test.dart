import 'dart:convert';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/view/detail_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Import the services library

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    // Load and parse the local JSON file
    loadLocalJson();
  }

  Future<void> loadLocalJson() async {
    final String data = await rootBundle.loadString('assets/file/recipie.json');
    final List<dynamic> jsonData = json.decode(data);
    setState(() {
      recipes = List<Map<String, dynamic>>.from(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RECIPE",
          style: titleText,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2 / 2.5),
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            final recipe = recipes[index];
            return InkWell(
                onTap: () {
                  Get.to(() => DetailRecipe(recipe: recipe));
                },
                child: RecipeCard(recipe: recipe));
          },
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Image.network(recipe.values.first["image"]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/SpaghettiCarbonara.png"),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.values.first["name"],
                      style: titleText,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          recipe.values.first["calories"].toString(),
                          style: mediumText,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text("Calories"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )

          // ...
          // The rest of your RecipeCard widget remains the same
        ],
      ),
    );
  }
}
