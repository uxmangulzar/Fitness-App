import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/admin/view_blog_admin.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/fitness_app/widgets/image_dialog.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/snakbar.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController blogWriter = TextEditingController();
  final ValueNotifier<File?> _blogCreatorImage = ValueNotifier(null);
  RxBool isLoading = false.obs;
  RxBool isDiss = true.obs;
  final CollectionReference userRequest =
      FirebaseFirestore.instance.collection('Blogs');

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
    Stream<QuerySnapshot> rejectStream = userRequest.snapshots();

    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: AppBar(
          title: const Center(child: Text("Blog")),
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
        body: Column(
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
                      stream: rejectStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: Text(
                            'Loading...',
                            style: styledText,
                          ));
                        }
                        log("=========== documents ${snapshot.data!.docs.length}");
                        List<QueryDocumentSnapshot> documents =
                            snapshot.data!.docs;
                        return documents.isEmpty
                            ? Center(
                                child: Text(
                                  "No Topic Added Yet",
                                  style: styledText.copyWith(fontSize: 18),
                                ),
                              )
                            : ListView.builder(
                                itemCount: documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // Extract the data for each document
                                  Map<String, dynamic> data = documents[index]
                                      .data() as Map<String, dynamic>;
                                  log("-============== time ${data["created_at"]}");
                                  String timestamp = data["created_at"];
                                  DateTime dateTime = DateTime.parse(timestamp);
                                  String formattedTime = DateFormat.jm().format(
                                      dateTime); // Format to 12-hour time with AM/PM
                                  log(formattedTime);
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ViewBlogAdmin(
                                            title: data["title"],
                                            subTitle: data["subTitle"],
                                            createdBy: data['blogWriter'],
                                            created: formattedTime,
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              minHeight:
                                                  AppSizes.screenHeight * 0.2,
                                              maxHeight:
                                                  AppSizes.screenHeight * 0.32),
                                          color: AppColors.bgGray,
                                          // height: AppSizes.screenHeight * 0.3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data["title"],
                                                    style: styledText.copyWith(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        AppSizes.appVerticalXs,
                                                  ),
                                                  Row(
                                                    children: [
                                                      ValueListenableBuilder(
                                                        valueListenable:
                                                            _blogCreatorImage,
                                                        builder: (context,
                                                            value, child) {
                                                          return CircleAvatar(
                                                            maxRadius: 16,
                                                            minRadius: 16,
                                                            child: _blogCreatorImage
                                                                        .value ==
                                                                    null
                                                                ? Image.asset(
                                                                    'assets/images/placeholder.png')
                                                                : Image.file(
                                                                    _blogCreatorImage
                                                                        .value!),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        data["blogWriter"],
                                                        style: styledText
                                                            .copyWith(),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        AppSizes.appVerticalXs,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      data["subTitle"],
                                                      style:
                                                          styledText.copyWith(),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        AppSizes.appVerticalSm,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "created at  $formattedTime",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: styledText
                                                            .copyWith(),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      const Icon(
                                                        Icons.timer_outlined,
                                                        color: AppColors.kGrey,
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
            showDialog(
                barrierDismissible: isDiss.value,
                context: context,
                builder: (context) {
                  return Obx(
                    () => AlertDialog(
                        content: SingleChildScrollView(
                      child: Form(
                        key: globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(
                              child: Text(
                                "Create Blog",
                                style: styledText.copyWith(
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Text(
                              "Title",
                              style: styledText.copyWith(
                                  color: AppColors.primaryGreen, fontSize: 18),
                            ),
                            TextFormField(
                              style:
                                  const TextStyle(color: AppColors.lightGrey),
                              controller: title,
                              cursorColor: AppColors.lightGrey,

                              decoration: InputDecoration(
                                hintText: "Add title",
                                hintStyle:
                                    const TextStyle(color: AppColors.lightGrey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          AppColors.lightGrey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          AppColors.lightGrey), //<-- SEE HERE
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
                            Text(
                              "Subtitle",
                              style: styledText.copyWith(
                                  color: AppColors.primaryGreen, fontSize: 18),
                            ),
                            TextFormField(
                              style:
                                  const TextStyle(color: AppColors.lightGrey),
                              controller: subTitle,
                              maxLines: 6,
                              cursorColor: AppColors.lightGrey,
                              decoration: InputDecoration(
                                hintText: "Add subtitle",
                                hintStyle:
                                    const TextStyle(color: AppColors.lightGrey),
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
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          AppColors.lightGrey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          AppColors.lightGrey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(24),
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
                            Text(
                              "Blog Writer", // Label for blog writer name
                              style: styledText.copyWith(
                                color: AppColors.primaryGreen,
                                fontSize: 18,
                              ),
                            ),
                            TextFormField(
                              style:
                                  const TextStyle(color: AppColors.lightGrey),
                              controller: blogWriter,
                              cursorColor: AppColors.lightGrey,
                              decoration: InputDecoration(
                                hintText: "blog writer",
                                hintStyle:
                                    const TextStyle(color: AppColors.lightGrey),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.lightGrey),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.lightGrey),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty || val == "") {
                                  return "required";
                                }
                                return null;
                              },
                            ),
                            GestureDetector(
                                onTap: () async {
                                  var imageSource =
                                      await showImageSourceSelectionDialog(
                                          context);
                                  if (imageSource != null) {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: imageSource);
                                    if (xFile == null) return;

                                    _blogCreatorImage.value = File(xFile.path);
                                    log('File: ${_blogCreatorImage.value}');
                                  }
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: _blogCreatorImage,
                                  builder: (context, value, child) {
                                    return CircleAvatar(
                                      maxRadius: 16,
                                      minRadius: 16,
                                      child: _blogCreatorImage.value == null
                                          ? Image.asset(
                                              'assets/images/placeholder.png')
                                          : Image.file(
                                              _blogCreatorImage.value!),
                                    );
                                  },
                                )),
                            isLoading.value == true
                                ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryGreen,
                                    ),
                                  ))
                                : Row(
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
                                                  MaterialStateProperty.all(
                                                      AppColors.primaryGreen)),
                                          onPressed: () {
                                            if (globalKey.currentState!
                                                .validate()) {
                                              var map = {
                                                "title": title.text.trim(),
                                                "subTitle":
                                                    subTitle.text.trim(),
                                                "created_at":
                                                    DateTime.now().toString(),
                                                "blogWriter":
                                                    blogWriter.text.toString()
                                              };
                                              funCreate("Blogs", map);
                                              title.clear();
                                              subTitle.clear();
                                              blogWriter.clear();
                                              Get.back();
                                              snackBar("Blog");
                                            }
                                          },
                                          child: const Text("Create")),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )),
                  );
                });
          },
          child: const Icon(
            Icons.create_outlined,
            color: AppColors.lightGrey,
          ),
        ));
  }
}
