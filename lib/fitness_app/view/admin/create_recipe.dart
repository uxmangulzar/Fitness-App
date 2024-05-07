// ignore_for_file: dead_code

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  TextEditingController category = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController addCategory = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final recipelKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  int serve = 1;
  // String selectedValue = 'All';
  // List<String> dropdownItems = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snacks'];

  String? selectedValue;
  List<String> dropdownItems = [];
  File? _image;
  var imagePicker;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: AppBar(
          title: const Text("Create Recipe"),
          centerTitle: true,
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: recipelKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.black38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              SizedBox(
                                child: _image == null
                                    ? Container(
                                        height: 90,
                                        width: 90,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          "assets/images/user.png",
                                          color: AppColors.primaryGreen,
                                        ),
                                      )
                                    : SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.3),
                                          // radius: 60.0,
                                          backgroundImage: FileImage(_image!),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Picked Image",
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                  pickImage(ImageSource.camera);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.camera,
                                                        size: 30,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Expanded(
                                                            child: Text(
                                                          "Picked From Camera",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                  pickImage(
                                                      ImageSource.gallery);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .browse_gallery_sharp,
                                                          size: 30),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "Picked From Gallery",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]));
                                  },
                                  child: const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///categories

                  Row(
                    children: [
                      Text(
                        "Categories  ",
                        style: styledText.copyWith(fontSize: 18),
                      ),
                      false
                          ? SizedBox(
                              width: 100,
                              height: 100,
                              child: StreamBuilder<QuerySnapshot>(
                                // stream: rejectStream,
                                stream: FirebaseFirestore.instance
                                    .collection('Category')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: Text('Loading...'));
                                  }
                                  log(
                                      "=========== documents ${snapshot.data!.docs.length}");
                                  List<QueryDocumentSnapshot> documents =
                                      snapshot.data!.docs;
                                  return documents.isEmpty
                                      ? Center(
                                          child: Text(
                                            "No Category Added",
                                            style: styledText.copyWith(
                                                fontSize: 14),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: documents.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // Extract the data for each document
                                            Map<String, dynamic> data =
                                                documents[index].data()
                                                    as Map<String, dynamic>;
                                            List<String> dropdownCategory = [];
                                            // dropdownCategory.clear();
                                            dropdownCategory
                                                .add(data["category"]);
                                            log("========= list ${dropdownCategory.length}");
                                            String selectedValue =
                                                dropdownCategory.first;
                                            return true
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      DropdownButton<String>(
                                                        value: selectedValue,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedValue =
                                                                newValue!;
                                                          });
                                                        },
                                                        items: dropdownCategory
                                                            .map((String item) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                Text(
                                                                  item,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18), // White text
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: const TextStyle(
                                                          // backgroundColor: Colors.black, // Black background
                                                          color: Colors
                                                              .red, // White text for the selected item
                                                        ),
                                                        dropdownColor: AppColors
                                                            .kGreyShade,
                                                        iconEnabledColor:
                                                            AppColors.kGrey,
                                                        // icon: SizedBox(),
                                                        // Black background for dropdown menu
                                                        underline:
                                                            const SizedBox(),
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                        color:
                                                            AppColors.lightGrey,
                                                        height: AppSizes
                                                                .screenHeight *
                                                            0.3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                  style: styledText.copyWith(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  data[
                                                                      "subTitle"],
                                                                  style: styledText
                                                                      .copyWith(),
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
                                                  );
                                          },
                                        );
                                },
                              ))
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: selectedValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    items: dropdownItems.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                  color: AppColors
                                                      .tertiaryBlackText,
                                                  fontSize: 18), // White text
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    style: const TextStyle(
                                      // backgroundColor: Colors.black, // Black background
                                      color: Colors
                                          .red, // White text for the selected item
                                    ),
                                    dropdownColor: AppColors.bgGray,
                                    iconEnabledColor: AppColors.kGrey,
                                    // icon: SizedBox(),
                                    // Black background for dropdown menu
                                    underline: const SizedBox(),
                                  )
                                ],
                              ),
                            ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.bgGray)),
                          onPressed: () {
                            showDialog(
                                // barrierDismissible:isDiss.value ,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                    child: Form(
                                      key: globalKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Create Category",
                                              style: styledText.copyWith(
                                                  color: AppColors.primaryGreen,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppSizes.appVerticalSm,
                                          ),
                                          Text(
                                            "Category Name",
                                            style: styledText.copyWith(
                                                color: AppColors.primaryGreen,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: AppSizes.appVerticalSm,
                                          ),
                                          TextFormField(
                                            style: const TextStyle(
                                                color: AppColors.lightGrey),
                                            controller: addCategory,
                                            cursorColor: AppColors.lightGrey,
                                            decoration: InputDecoration(
                                              hintText: "add category",
                                              hintStyle: const TextStyle(
                                                  color: AppColors.lightGrey),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: AppColors
                                                        .lightGrey), //<-- SEE HERE
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: AppColors
                                                        .lightGrey), //<-- SEE HERE
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    24), // Adjust the radius as needed
                                                borderSide: const BorderSide(
                                                    color: Colors
                                                        .red), // Border color when there's an error
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    24), // Adjust the radius as needed
                                                borderSide: const BorderSide(
                                                    color: Colors
                                                        .red), // Border color when there's an error
                                              ),
                                            ),
                                            // onChanged: filterFoods,
                                            validator: (val) {
                                              if (val!.isEmpty || val == "") {
                                                return "required";
                                              }
                                              return null;
                                            },
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: styledText.copyWith(
                                                        color: Colors.red),
                                                  )),
                                              const Spacer(),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppColors
                                                                  .primaryGreen)),
                                                  onPressed: () {
                                                    if (globalKey.currentState!
                                                        .validate()) {
                                                      var map = {
                                                        "category": addCategory
                                                            .text
                                                            .trim(),
                                                      };
                                                      funCreate(
                                                          "Category", map);
                                                      addCategory.clear();
                                                      Get.back();
                                                      snackBar("Category");
                                                      fetchData();
                                                    }
                                                  },
                                                  child: const Text("Create")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                                });
                          },
                          child: Text(
                            "Add New",
                            style:
                                styledText.copyWith(color: AppColors.lightGrey),
                          ))
                    ],
                  ),

                  // Row(children: [
                  //   Expanded(child: Text("Category",style: styledText.copyWith(fontSize: 18),)),
                  //   const SizedBox(width: 4,),
                  //   SizedBox(
                  //       width: AppSizes.screenWidth*0.7,
                  //       child :TextFormField(
                  //   style: const TextStyle(color: AppColors.kDarkSky1),
                  //   controller: category,
                  //   decoration: InputDecoration(
                  //     hintText: "add category",
                  //     hintStyle: const TextStyle(color: AppColors.kGrey),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: const BorderSide(
                  //           color: AppColors.kDarkSky1), //<-- SEE HERE
                  //       borderRadius: BorderRadius.circular(24),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderSide: const BorderSide(
                  //           color: AppColors.kDarkSky1), //<-- SEE HERE
                  //       borderRadius: BorderRadius.circular(24),
                  //     ),
                  //     errorBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(24), // Adjust the radius as needed
                  //       borderSide: BorderSide(color: Colors.red), // Border color when there's an error
                  //     ),
                  //     focusedErrorBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(24), // Adjust the radius as needed
                  //       borderSide: BorderSide(color: Colors.red), // Border color when there's an error
                  //     ),
                  //   ),
                  //   // onChanged: filterFoods,
                  //   validator: (val){
                  //     if(val!.isEmpty || val==""){
                  //       return "required";
                  //     }
                  //     return null;
                  //   },
                  // ))],),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Title",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: title,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add title",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Serve",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                          width: AppSizes.screenWidth * 0.7,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (serve <= 1) {
                                        serve = 1;
                                      } else {
                                        serve--;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: AppColors.tertiaryBlackText,
                                  )),
                              Text(
                                serve.toString(),
                                style: styledText,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      serve++;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.tertiaryBlackText,
                                  ))
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Calories",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: calories,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add calories",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Text(
                    "Nutrition Per Serving",
                    style: styledText.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Carbs",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: carbs,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add carbs",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Fat",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: fat,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add fat",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Protein",
                        style: styledText.copyWith(fontSize: 18),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: protein,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add protein",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Add Ingredients",
                        style: styledText.copyWith(fontSize: 12),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: ingredients,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add ingredients separated by (,)",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        "Instruction",
                        style: styledText.copyWith(fontSize: 16),
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: AppSizes.screenWidth * 0.7,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 6,
                          style: const TextStyle(
                              color: AppColors.tertiaryBlackText),
                          controller: instruction,
                          cursorColor: AppColors.tertiaryBlackText,
                          decoration: InputDecoration(
                            hintText: "add instruction",
                            hintStyle: const TextStyle(
                                color: AppColors.tertiaryBlackText),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors
                                      .tertiaryBlackText), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(24),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  24), // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .red), // Border color when there's an error
                            ),
                          ),
                          // onChanged: filterFoods,
                          validator: (val) {
                            if (val!.isEmpty || val == "") {
                              return "required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),

                  isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGreen,
                          ),
                        )
                      : SizedBox(
                          width: AppSizes.screenWidth,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primaryGreen)),
                              onPressed: () async {
                                log("==== select Val $selectedValue");
                                if (recipelKey.currentState!.validate()) {
                                  isLoading.value = true;

                                  if (selectedValue == "Add First") {
                                    alertSnackBar(
                                        "please create category first");
                                    isLoading.value = false;
                                  } else {
                                    if (_image != null) {
                                      final imageUrl =
                                          await uploadImageToStorage(
                                              _image!.path);
                                      var data = {
                                        "category": selectedValue,
                                        "title": title.text.trim(),
                                        "serve": serve.toString(),
                                        "calories": calories.text.trim(),
                                        "carb": carbs.text.trim(),
                                        "fat": fat.text.trim(),
                                        "protein": protein.text.trim(),
                                        "ingredients": ingredients.text.trim(),
                                        "instruction": instruction.text.trim(),
                                        "img_url": imageUrl
                                      };
                                      firestore
                                          .collection(selectedValue.toString())
                                          .add(data);
                                      title.clear();
                                      Get.back();
                                      snackBar("Recipe");
                                      isLoading.value = false;
                                    } else {
                                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No image selected')));
                                      alertSnackBar("No image selected");
                                      isLoading.value = false;
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Create Recipe",
                                  style: styledText.copyWith(
                                      color: AppColors.bgGray,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadImageToStorage(String filePath) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child(_image!.path
            .split("/")
            .last
            .toString()); // Replace with your own naming strategy

    UploadTask uploadTask = storageReference.putFile(File(filePath));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    if (taskSnapshot.state == TaskState.success) {
      isLoading.value = false;
      return await storageReference.getDownloadURL();
    } else {
      isLoading.value = false;
      return "Failed to upload image";
    }
  }

  Future<void> fetchData() async {
    List<String> data = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Category').get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic>? documentData =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (documentData != null && documentData.containsKey('category')) {
        String fieldValue = documentData['category'];
        data.add(fieldValue);
      }
    }

    setState(() {
      dropdownItems = data;
      selectedValue = data.isNotEmpty ? data[0] : "Add First";
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => _image = imageTemp);
      log("======name :${_image!.path.split("/").last}");
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }
}
