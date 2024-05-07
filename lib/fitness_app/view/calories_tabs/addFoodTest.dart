// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fitness_app/utill/appColor.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// const jsonData = '''
// {
//   "foods": [
//     {
//       "food_name": "Chicken Breast",
//       "nutrients": {
//         "protein": 31,
//         "carbohydrates": 0,
//         "fiber": 0,
//         "sugar": 0,
//         "fat": 3.6,
//         "saturated_fat": 1,
//         "polyunsaturated_fat": 0.8,
//         "monounsaturated_fat": 1.3,
//         "trans_fat": 0,
//         "cholesterol": 85,
//         "sodium": 74,
//         "potassium": 256,
//         "vitamin_a": 5,
//         "vitamin_c": 0,
//         "calcium": 0,
//         "iron": 1.1
//       }
//     },
//     {
//       "food_name": "Brown Rice (Cooked)",
//       "nutrients": {
//         "protein": 2.1,
//         "carbohydrates": 23,
//         "fiber": 1.8,
//         "sugar": 0.2,
//         "fat": 0.9,
//         "saturated_fat": 0.2,
//         "polyunsaturated_fat": 0.3,
//         "monounsaturated_fat": 0.2,
//         "trans_fat": 0,
//         "cholesterol": 0,
//         "sodium": 1,
//         "potassium": 43,
//         "vitamin_a": 0,
//         "vitamin_c": 0,
//         "calcium": 1,
//         "iron": 1
//       }
//     },
//     {
//       "food_name": "Spinach (Raw)",
//       "nutrients": {
//         "protein": 2.9,
//         "carbohydrates": 3.6,
//         "fiber": 2.2,
//         "sugar": 0.4,
//         "fat": 0.4,
//         "saturated_fat": 0.1,
//         "polyunsaturated_fat": 0.1,
//         "monounsaturated_fat": 0.1,
//         "trans_fat": 0,
//         "cholesterol": 0,
//         "sodium": 79,
//         "potassium": 558,
//         "vitamin_a": 469,
//         "vitamin_c": 47,
//         "calcium": 99,
//         "iron": 2.7
//       }
//     },
//     {
//       "food_name": "Banana",
//       "nutrients": {
//         "protein": 1.1,
//         "carbohydrates": 22,
//         "fiber": 2.6,
//         "sugar": 12,
//         "fat": 0.3,
//         "saturated_fat": 0.1,
//         "polyunsaturated_fat": 0.1,
//         "monounsaturated_fat": 0.1,
//         "trans_fat": 0,
//         "cholesterol": 0,
//         "sodium": 1,
//         "potassium": 358,
//         "vitamin_a": 1,
//         "vitamin_c": 10,
//         "calcium": 6,
//         "iron": 0.3
//       }
//     },
//     {
//       "food_name": "Salmon (Cooked)",
//       "nutrients": {
//         "protein": 25.4,
//         "carbohydrates": 0,
//         "fiber": 0,
//         "sugar": 0,
//         "fat": 13.4,
//         "saturated_fat": 2.2,
//         "polyunsaturated_fat": 3.1,
//         "monounsaturated_fat": 5.8,
//         "trans_fat": 0,
//         "cholesterol": 71,
//         "sodium": 50,
//         "potassium": 363,
//         "vitamin_a": 4,
//         "vitamin_c": 0,
//         "calcium": 8,
//         "iron": 1
//       }
//     }
//   ]
// }
// ''';
//
//
//
// class AddFoodTest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FoodList(),
//     );
//   }
// }
//
// class FoodList extends StatefulWidget {
//   @override
//   _FoodListState createState() => _FoodListState();
// }
//
// class _FoodListState extends State<FoodList> {
//   final foods = json.decode(jsonData)["foods"];
//   int totalCalories = 0;
//   int breakfastSum=0;
//   String? selectedValue;
//   List<String> dropdownItems = [];
//   Map<String, double> totalNutrients = {
//     "protein": 0,
//     "carbohydrates": 0,
//     "fiber": 0,
//     "sugar": 0,
//     "fat": 0,
//     "saturated_fat": 0,
//     "polyunsaturated_fat": 0,
//     "monounsaturated_fat": 0,
//     "trans_fat": 0,
//     "cholesterol": 0,
//     "sodium": 0,
//     "potassium": 0,
//     "vitamin_a": 0,
//     "vitamin_c": 0,
//     "calcium": 0,
//     "iron": 0,
//   };
//
//
//   Future<void> fetchData() async {
//     List<String> data = [];
//
//     QuerySnapshot querySnapshot =
//     await FirebaseFirestore.instance.collection('Category').get();
//
//     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
//       Map<String, dynamic>? documentData =
//       documentSnapshot.data() as Map<String, dynamic>?;
//       if (documentData != null && documentData.containsKey('category')) {
//         String fieldValue = documentData['category'];
//         if (fieldValue != null) {
//           data.add(fieldValue);
//         }
//       }
//     }
//
//     setState(() {
//       dropdownItems = data;
//       selectedValue = data.isNotEmpty ? data[0] : "Add First";
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text('Food Nutritional Information'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             color: AppColors.kLightBlue,
//             child: Row(children: [  Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   DropdownButton<String>(
//                     value: selectedValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedValue = newValue!;
//                       });
//                     },
//                     items: dropdownItems.map((String item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Column(
//                           mainAxisAlignment:
//                           MainAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               height: 16,
//                             ),
//                             Text(
//                               item,
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18), // White text
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                     style: const TextStyle(
//                       // backgroundColor: Colors.black, // Black background
//                       color: Colors
//                           .red, // White text for the selected item
//                     ),
//                     dropdownColor: AppColors.kGreyShade,
//                     iconEnabledColor: AppColors.kGrey,
//                     // icon: SizedBox(),
//                     // Black background for dropdown menu
//                     underline: const SizedBox(),
//                   )
//                 ],
//               ),
//             ),],),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(breakfastSum.toString()), SizedBox(width: 16,),Text(selectedValue!)],),
//           Expanded(
//             child: ListView.builder(
//               itemCount: foods.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final food = foods[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text(food["food_name"]),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Protein: ${food['nutrients']['protein']} g"),
//                         Text("Carbohydrates: ${food['nutrients']['carbohydrates']} g"),
//                         // Add more nutrient information as needed
//                       ],
//                     ),
//                     onTap: () {
//                       // Calculate and add calories to the total
//                       final calories = calculateCalories(food);
//
//
//                       print("============ calories $calories");
//
//                       totalCalories += calories;
//
//                       // Calculate and add nutrients to the total
//                       food["nutrients"].forEach((key, value) {
//                         if (totalNutrients.containsKey(key)) {
//                           totalNutrients[key] = (totalNutrients[key] ?? 0) + value;
//
//                         }
//                       });
//                       if(selectedValue=="breakfast"){
//                         breakfastSum=breakfastSum+(calories ?? 0);
//                       }
//
//                       // Show a snackbar with the updated total calories
//
//
//                       setState(() {}); // Update the UI
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Text(
//             'Total Calories: $totalCalories',
//             style: const TextStyle(fontSize: 18),
//           ),
//         const  SizedBox(height: 16),
//           const Text(
//             'Total Nutrients:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: totalNutrients.keys.map((key) {
//               return Text('$key: ${totalNutrients[key] ?? 0}');
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int calculateCalories(Map<String, dynamic> food) {
//     // Calculate calories based on the nutritional values (you can use your own formula)
//     final protein = food['nutrients']['protein'];
//     final carbohydrates = food['nutrients']['carbohydrates'];
//     final fat = food['nutrients']['fat'];
//
//     // Assuming a basic calorie calculation formula
//     final calories = (protein * 4) + (carbohydrates * 4) + (fat * 9);
//
//     return calories.round();
//   }
// }
///above working calculate calories and nutriens

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:provider/provider.dart';

const jsonData = '''
{
  "foods": [
    {
      "food_name": "Chicken Breast",
      "nutrients": {
        "protein": 31,
        "carbohydrates": 0,
        "fiber": 0,
        "sugar": 0,
        "fat": 3.6,
        "saturated_fat": 1,
        "polyunsaturated_fat": 0.8,
        "monounsaturated_fat": 1.3,
        "trans_fat": 0,
        "cholesterol": 85,
        "sodium": 74,
        "potassium": 256,
        "vitamin_a": 5,
        "vitamin_c": 0,
        "calcium": 0,
        "iron": 1.1
      }
    },
    {
      "food_name": "Brown Rice (Cooked)",
      "nutrients": {
        "protein": 2.1,
        "carbohydrates": 23,
        "fiber": 1.8,
        "sugar": 0.2,
        "fat": 0.9,
        "saturated_fat": 0.2,
        "polyunsaturated_fat": 0.3,
        "monounsaturated_fat": 0.2,
        "trans_fat": 0,
        "cholesterol": 0,
        "sodium": 1,
        "potassium": 43,
        "vitamin_a": 0,
        "vitamin_c": 0,
        "calcium": 1,
        "iron": 1
      }
    },
    {
      "food_name": "Spinach (Raw)",
      "nutrients": {
        "protein": 2.9,
        "carbohydrates": 3.6,
        "fiber": 2.2,
        "sugar": 0.4,
        "fat": 0.4,
        "saturated_fat": 0.1,
        "polyunsaturated_fat": 0.1,
        "monounsaturated_fat": 0.1,
        "trans_fat": 0,
        "cholesterol": 0,
        "sodium": 79,
        "potassium": 558,
        "vitamin_a": 469,
        "vitamin_c": 47,
        "calcium": 99,
        "iron": 2.7
      }
    },
    {
      "food_name": "Banana",
      "nutrients": {
        "protein": 1.1,
        "carbohydrates": 22,
        "fiber": 2.6,
        "sugar": 12,
        "fat": 0.3,
        "saturated_fat": 0.1,
        "polyunsaturated_fat": 0.1,
        "monounsaturated_fat": 0.1,
        "trans_fat": 0,
        "cholesterol": 0,
        "sodium": 1,
        "potassium": 358,
        "vitamin_a": 1,
        "vitamin_c": 10,
        "calcium": 6,
        "iron": 0.3
      }
    },
    {
      "food_name": "Salmon (Cooked)",
      "nutrients": {
        "protein": 25.4,
        "carbohydrates": 0,
        "fiber": 0,
        "sugar": 0,
        "fat": 13.4,
        "saturated_fat": 2.2,
        "polyunsaturated_fat": 3.1,
        "monounsaturated_fat": 5.8,
        "trans_fat": 0,
        "cholesterol": 71,
        "sodium": 50,
        "potassium": 363,
        "vitamin_a": 4,
        "vitamin_c": 0,
        "calcium": 8,
        "iron": 1
      }
    }
  ]
}
''';

Map<String, double> totalNutrients = {
  "protein": 0,
  "carbohydrates": 0,
  "fiber": 0,
  "sugar": 0,
  "fat": 0,
  "saturated_fat": 0,
  "polyunsaturated_fat": 0,
  "monounsaturated_fat": 0,
  // "trans_fat": 0,
  "cholesterol": 0,
  "sodium": 0,
  "potassium": 0,
  "vitamin_a": 0,
  "vitamin_c": 0,
  "calcium": 0,
  "iron": 0,
};
final foods = json.decode(jsonData)["foods"];
RxInt totalCalories = 0.obs;
RxInt totalBreakFastCalories = 0.obs;
RxInt totalLunchCalories = 0.obs;
RxInt totalDinnerCalories = 0.obs;
RxInt totalSnackCalories = 0.obs;

// double perBreakFast= ((totalBreakFastCalories.value/totalCalories.value)*100);
double perBreakFast = calculatePercent(totalBreakFastCalories.value);
String perLunch =
    ((totalLunchCalories.value / totalCalories.value) * 100).toString();
String perDinner =
    ((totalDinnerCalories.value / totalCalories.value) * 100).toString();
String perSnack =
    ((totalSnackCalories.value / totalCalories.value) * 100).toString();
final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signOut(BuildContext context) async {
  await Provider.of<ProfileProvider>(context, listen: false).clearProfile();
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (_) => const LogInScreen()), (route) => false);
  await auth.signOut();
  // Get.to(()=>const ());
}

int calculateCalories(Map<String, dynamic> food) {
  // Calculate calories based on the nutritional values (you can use your own formula)
  final protein = food['nutrients']['protein'];
  final carbohydrates = food['nutrients']['carbohydrates'];
  final fat = food['nutrients']['fat'];

  // Assuming a basic calorie calculation formula
  final calories = (protein * 4) + (carbohydrates * 4) + (fat * 9);

  return calories.round();
}

calculatePercent(int number) {
  return number != 0 ? ((number / totalCalories.value) * 100) : number;
}

Map<String, double> calculateNutrientGoals(double dailyCalories) {
  // Initialize the nutrient percentage ranges
  final Map<String, double> nutrientPercentages = {
    'Protein': 15, // Example percentage, you can adjust these as needed
    'Carbohydrates': 55,
    'Fat': 30,
    'Saturated Fat': 10,
    'Polyunsaturated Fat': 10,
    'Monounsaturated Fat': 20,
    'Cholesterol': 300, // milligrams per day
    'Sodium': 2300, // milligrams per day
  };

  // Initialize the specific daily recommendations
  final Map<String, double> nutrientRecommendations = {
    'Fiber': 25, // grams per day
    'Sugar': dailyCalories * 0.1 / 4, // Less than 10% of total calories
    'Potassium': 4700, // milligrams per day
    'Vitamin A': 900, // micrograms for men
    'Vitamin C': 90, // milligrams for men
    'Calcium': 1000, // milligrams per day
    'Iron': 8, // milligrams for men
  };

  // Calculate the nutrient goals based on percentage of total calories
  final Map<String, double> nutrientGoals = {};

  nutrientPercentages.forEach((nutrient, percentage) {
    nutrientGoals[nutrient] = (percentage / 100) * dailyCalories;
  });
  // Add the nutrient recommendations
  nutrientRecommendations.forEach((nutrient, recommendation) {
    nutrientGoals[nutrient] = recommendation;
  });

  return nutrientGoals;
}

double dailyCalories = 1000; // Replace with your daily calorie intake

Map<String, double> goals = calculateNutrientGoals(dailyCalories);

class AddFoodTest extends StatelessWidget {
  const AddFoodTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FoodList(),
    );
  }
}

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  // Map<String, double> totalNutrients = {
  //   "protein": 0,
  //   "carbohydrates": 0,
  //   "fiber": 0,
  //   "sugar": 0,
  //   "fat": 0,
  //   "saturated_fat": 0,
  //   "polyunsaturated_fat": 0,
  //   "monounsaturated_fat": 0,
  //   "trans_fat": 0,
  //   "cholesterol": 0,
  //   "sodium": 0,
  //   "potassium": 0,
  //   "vitamin_a": 0,
  //   "vitamin_c": 0,
  //   "calcium": 0,
  //   "iron": 0,
  // };

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Nutritional Information'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search by Food Name',
                hintText: 'Enter food name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (BuildContext context, int index) {
                final food = foods[index];
                final foodName = food["food_name"].toLowerCase();
                if (searchText.isNotEmpty && !foodName.contains(searchText)) {
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
                        Text("Protein: ${food['nutrients']['protein']} g"),
                        Text(
                            "Carbohydrates: ${food['nutrients']['carbohydrates']} g"),
                        // Add more nutrient information as needed
                      ],
                    ),
                    onTap: () {
                      // Calculate and add calories to the total
                      setState(() {
                        final calories = calculateCalories(food);
                        totalCalories.value += calories;

                        // Calculate and add nutrients to the total
                        food["nutrients"].forEach((key, value) {
                          if (totalNutrients.containsKey(key)) {
                            totalNutrients[key] =
                                (totalNutrients[key] ?? 0) + value;
                          }
                        });
                        // Show a snackbar with the updated total calories
                      }); // Update the UI
                    },
                  ),
                );
              },
            ),
          ),
          Text(
            'Total Calories: ${totalCalories.value}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text(
            'Total Nutrients:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: totalNutrients.keys.map((key) {
          //     return Text('$key: ${totalNutrients[key] ?? 0}');
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
