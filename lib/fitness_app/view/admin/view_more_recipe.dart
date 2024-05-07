// ignore_for_file: dead_code

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/admin/admin_detail_recipe.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMoreRecipe extends StatefulWidget {
  final String? cat;
  const ViewMoreRecipe({Key? key, required this.cat }) : super(key: key);

  @override
  State<ViewMoreRecipe> createState() => _ViewMoreRecipeState();
}

class _ViewMoreRecipeState extends State<ViewMoreRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          title: Text(widget.cat!),
          centerTitle: true,
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection(widget.cat!).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const SizedBox();
              // Center(child: Text('No data available'));
            }

            log("=========snapshot.data!.docs ${snapshot.data!.docs.first["title"]}");
            // Process and display data from the breakfast subcollection
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 2.5),
                itemBuilder: (context, index) {
                  // Map<String, dynamic> data = snapshot.data!.docs as Map<String, dynamic>;

                  String title = snapshot.data!.docs[index]['title'];
                  // String subTitle = data['subTitle'];
                  String cal = snapshot.data!.docs[index]['calories'];
                  return InkWell(
                    onTap: () {
                      Get.to(() => AdminDetailRecipe(
                            img: snapshot.data!.docs[index]['img_url'],
                            title: title,
                            category: '',
                            calories: cal,
                            serve: snapshot.data!.docs[index]['serve'],
                            carb: snapshot.data!.docs[index]['carb'],
                            fat: snapshot.data!.docs[index]['fat'],
                            protein: snapshot.data!.docs[index]['protein'],
                            ingredients: snapshot.data!.docs[index]
                                ['ingredients'],
                            instruction: snapshot.data!.docs[index]
                                ['instruction'],
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: AppSizes.screenWidth * 0.45,
                        height: AppSizes.screenHeight * 0.3,
                        decoration: BoxDecoration(
                            image: snapshot.data!.docs[index]['img_url'] == ''
                                ? const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/SpaghettiCarbonara.png"))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        snapshot.data!.docs[index]['img_url'])),
                            color: AppColors.bgGray,
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                  child: Text(
                                title,
                                style: styledText.copyWith(
                                    fontSize: 18,
                                    color: AppColors.kWhite,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: AppSizes.screenWidth * 0.01,
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "$cal Cal",
                                    style: styledText.copyWith(
                                        color: AppColors.kWhite, fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String title = data['title'];
                // String subTitle = data['subTitle'];
                String cal = data['calories'];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Container(
                        width: AppSizes.screenWidth * 0.45,
                        decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/download.jpg", height: 140,
                              // width: 120,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text("$cal Cal", style: styledText)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
                // Add more widgets to display other breakfast data as needed
              }).toList(),
            );
          },
        ));
  }
}
