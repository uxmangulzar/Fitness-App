import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isObsecure = false.obs;
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.bgGray,
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSizes.appHorizontalLg,
                    ),
                    Image.asset(
                      "assets/images/fitnessApp_logo.png",
                      color: AppColors.primaryGreen,
                      height: 100,
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create Account",
                        style: styledText.copyWith(
                            fontSize: 32, color: AppColors.primaryGreen),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: AppColors.tertiaryBlackText),
                        controller: name,
                        cursorColor: Colors.white,

                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: const TextStyle(color: AppColors.kGrey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
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
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(color: AppColors.tertiaryBlackText),
                        controller: email,
                        cursorColor: Colors.white,

                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: AppColors.kGrey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
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
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: AppColors.tertiaryBlackText),
                        controller: password,
                        cursorColor: Colors.white,
                        obscureText: isObsecure.value,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: IconButton(
                              onPressed: () {
                                isObsecure.value = !isObsecure.value;
                              },
                              icon: Icon(
                                isObsecure.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryGreen,
                              )),
                          hintStyle: const TextStyle(color: AppColors.kGrey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
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
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style:
                            const TextStyle(color: AppColors.tertiaryBlackText),
                        controller: confirmPassword,
                        cursorColor: Colors.white,
                        obscureText: isObsecure.value,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          prefixIcon: IconButton(
                              onPressed: () {
                                isObsecure.value = !isObsecure.value;
                              },
                              icon: Icon(
                                isObsecure.value == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryGreen,
                              )),
                          hintStyle: const TextStyle(color: AppColors.kGrey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen), //<-- SEE HERE
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
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalMd,
                    ),
                    isLoading.value == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (password.text.trim() !=
                                    confirmPassword.text.trim()) {
                                  alertSnackBar("Password didn't matched");
                                } else {
                                  isLoading.value = true;

                                  User? user =
                                      await createUserWithEmailAndPassword(
                                          email.text.trim(),
                                          password.text.trim());
                                  if (user != null) {
                                    // User signed in successfully
                                    final userData = {
                                      'name': name.text.trim(),
                                      'email': email.text.trim(),
                                      // Include other data fields as needed
                                    };
                                    // Save data to Firestore
                                    await saveDataToFirestore(
                                            user.uid, userData)
                                        .then((value) {
                                      Get.to(() => const LogInScreen());
                                      isLoading.value = false;
                                    });
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryGreen,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    " Create Account",
                                    style: styledText.copyWith(
                                        fontSize: 18,
                                        color: AppColors.kWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "already have account?",
                          style:
                              styledText.copyWith(color: AppColors.primaryBlue),
                        ),
                        SizedBox(
                          width: AppSizes.appVerticalSm,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => const LogInScreen());
                            },
                            child: Text(
                              "Sign In",
                              style: styledText.copyWith(
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> saveDataToFirestore(
      String userId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set({
        'userId': userId,
        ...data, // Include your data fields here
      });
      log('Data saved to Firestore successfully');
    } catch (error) {
      log('Error saving data to Firestore: $error');
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (error) {
      log('Error creating user: $error');
      return null;
    }
  }
}
