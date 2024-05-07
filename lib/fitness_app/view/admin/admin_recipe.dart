// ignore_for_file: dead_code

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/admin/admin_detail_recipe.dart';
import 'package:fitness_app/fitness_app/view/admin/create_recipe.dart';

import 'package:fitness_app/fitness_app/view/admin/view_more_recipe.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRecipe extends StatefulWidget {
  const AdminRecipe({Key? key}) : super(key: key);

  @override
  State<AdminRecipe> createState() => _AdminRecipeState();
}

class _AdminRecipeState extends State<AdminRecipe> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isDiss = true.obs;
  final CollectionReference recipeCollection = FirebaseFirestore.instance
      .collection('Recipe')
      .doc("MQ4V5Cs3tf5vIGjamSCX")
      .collection("breakfast");
  final globalKey = GlobalKey<FormState>();
  String selectedValue = 'All';
  List<String> dropdownItems = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks'
  ];
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.clear();
    subTitle.clear();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> recipes = recipeCollection.snapshots();

    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: AppBar(
          title: const Text("Recipe"),
          centerTitle: true,
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.until((route) => !Get.isOverlaysClosed);
                  Get.to(() => const LogInScreen());
                },
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: true
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Category')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text(
                      'No data available',
                      style: styledText.copyWith(fontSize: 18),
                    ));
                  }
                  // Process and display data from the breakfast sub collection
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String categories = data['category'];
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(categories)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // return const Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const SizedBox();
                            // Center(child: Text('No data available'));
                          }

                          // Process and display data from the breakfast subcollection
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      categories,
                                      style: styledText.copyWith(fontSize: 20),
                                    )),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => ViewMoreRecipe(
                                              cat: categories,
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "View More",
                                            style: styledText.copyWith(
                                                color: AppColors.kGrey,
                                                fontSize: 12),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: AppColors.kGrey,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data =
                                        document.data() as Map<String, dynamic>;
                                    String title = data['title'];
                                    // String subTitle = data['subTitle'];
                                    String cal = data['calories'];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => AdminDetailRecipe(
                                              img: data['img_url'],
                                              title: title,
                                              category: '',
                                              calories: cal,
                                              serve: data['serve'],
                                              carb: data['carb'],
                                              fat: data['fat'],
                                              protein: data['protein'],
                                              ingredients: data['ingredients'],
                                              instruction: data['instruction'],
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  AppSizes.screenWidth * 0.45,
                                              decoration: BoxDecoration(
                                                  color: AppColors.tabGray,
                                                  // border: Border.all(color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  data['img_url'] == ''
                                                      ? Image.asset(
                                                          "assets/images/SpaghettiCarbonara.png",
                                                          height: 140,
                                                          // width: 120,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.network(
                                                          data['img_url'],
                                                          fit: BoxFit.fill,
                                                          height: 140),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        SizedBox(
                                                            child: Text(
                                                          title,
                                                          style: styledText,
                                                        )),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Text("$cal Cal",
                                                            style: styledText)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                    // Add more widgets to display other breakfast data as needed
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.appHorizontalXs),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.primaryGreen)),
                      child: Column(
                        children: [
                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                            stream: recipes,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: Text('Loading...'));
                              }
                              log(
                                  "=========== documents ${snapshot.data!.docs.length}");
                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return documents.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Recipe Added Yet",
                                        style:
                                            styledText.copyWith(fontSize: 32),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: documents.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // Extract the data for each document
                                        Map<String, dynamic> data =
                                            documents[index].data()
                                                as Map<String, dynamic>;
                                        log(
                                            "-============== time ${data["created_at"]}");
                                        // String timestamp = data["created_at"];
                                        // DateTime dateTime = DateTime.parse(timestamp);
                                        // String formattedTime = DateFormat.jm().format(dateTime); // Format to 12-hour time with AM/PM
                                        // log(formattedTime);
                                        return InkWell(
                                          onTap: () {
                                            // Get.to(()=>ViewBlogAdmin(title:data["title"] ,subTitle:data["subTitle"] ,created: formattedTime,));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                color: AppColors.lightGrey,
                                                height:
                                                    AppSizes.screenHeight * 0.2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data["title"],
                                                          style: styledText
                                                              .copyWith(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        // Text(data["subTitle"],style: styledText.copyWith(),),
                                                        const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            // Text(formattedTime,textAlign: TextAlign.end,style: styledText.copyWith(),),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .timer_outlined,
                                                              color: AppColors
                                                                  .kGrey,
                                                              size: 16,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.kWhite,
          onPressed: () {
            Get.to(() => const CreateRecipe());
          },
          child: const Icon(
            Icons.create_outlined,
            color: AppColors.lightGrey,
          ),
        ));
  }
}
