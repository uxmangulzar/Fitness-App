import 'package:fitness_app/firebase/firestore_training_service.dart';
import 'package:fitness_app/fitness_app/model/training_title_model.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/get_di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingTitleScreen extends StatefulWidget {
  const TrainingTitleScreen({super.key});

  @override
  State<TrainingTitleScreen> createState() => _TrainingTitleScreenState();
}

class _TrainingTitleScreenState extends State<TrainingTitleScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController calories = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isDiss = true.obs;
  final globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    title.dispose();
    calories.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "Create Training Title",
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
                              "Calories",
                              style: styledText.copyWith(
                                  color: AppColors.primaryGreen, fontSize: 18),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style:
                                  const TextStyle(color: AppColors.lightGrey),
                              controller: calories,
                              maxLines: 1,
                              cursorColor: AppColors.lightGrey,
                              decoration: InputDecoration(
                                hintText: "Add calories",
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
                                                "calories":
                                                    calories.text.trim(),
                                                "created_at":
                                                    DateTime.now().toString()
                                              };
                                              funCreate("Training Titles", map);
                                              title.clear();
                                              calories.clear();
                                              Get.back();
                                              snackBar("Training Title");
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
        ),
        appBar: AppBar(
          title: const Text("Training Titles"),
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
        body: StreamBuilder(
          stream: FirestoreTrainingService().getTrainingTitlesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryGreen));
            } else if (snapshot.hasError) {
              return const Icon(Icons.error);
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No data found', style: styledText),
              );
            }

            List<TrainingTitleModel> trainingTitles = snapshot.data ?? [];
            if (trainingTitles.isEmpty) {
              return const Center(
                child: Text('No data found', style: styledText),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: trainingTitles.length,
                itemBuilder: ((context, index) {
                  final trainingTitle = trainingTitles[index];
                  return Card(
                    child: ListTile(
                      leading: Text('${index + 1}',
                          style:
                              styledText.copyWith(fontWeight: FontWeight.bold)),
                      title: Text(trainingTitle.title!, style: styledText),
                      subtitle: Text(trainingTitle.calories!),
                    ),
                  );
                }));
          },
        ));
  }
}
