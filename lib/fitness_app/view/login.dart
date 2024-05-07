import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/view/admin/admin_home.dart';
import 'package:fitness_app/fitness_app/view/forgot_password.dart';
import 'package:fitness_app/fitness_app/view/home.dart';
import 'package:fitness_app/fitness_app/view/onBoradScreen.dart';
import 'package:fitness_app/fitness_app/view/signup_screen.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isObsecure = true.obs;

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.bgGray,
        body: Obx(
          () => Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSizes.appHorizontalXXL,
                    ),
                    Image.asset(
                      "assets/images/fitnessApp_logo.png",
                      color: AppColors.primaryGreen,
                      height: 140,
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        " Log In",
                        style: styledText.copyWith(
                            fontSize: 32, color: AppColors.primaryGreen),
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
                        cursorColor: AppColors.primaryGreen,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(
                            Icons.mail_outlined,
                            color: AppColors.primaryGreen,
                          ),
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
                          } else if (!val.contains("@")) {
                            return "enter valid email";
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
                        cursorColor: AppColors.primaryGreen,
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
                          } else if (val.length < 6) {
                            return "password length > 6";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot password?",
                            style: styledText.copyWith(
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalMd,
                    ),
                    isLoading.value == true
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryGreen,
                          )
                        : InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                isLoading.value = true;
                                if (email.text.trim() == "example@admin.com" &&
                                    password.text.trim() == "admin12345") {
                                  Timer(const Duration(milliseconds: 2500), () {
                                    isLoading.value = false;
                                    Get.to(() => const AdminHome());
                                  });
                                } else {
                                  await signInWithEmail(
                                      email.text.trim(), password.text.trim());
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    " Log In",
                                    style: styledText.copyWith(
                                        fontSize: 24,
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
                          "don't have account?",
                          style:
                              styledText.copyWith(color: AppColors.primaryBlue),
                        ),
                        SizedBox(
                          width: AppSizes.appVerticalSm,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => const SignUpScreen());
                            },
                            child: Text(
                              "Sign Up",
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

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .collection("Calory")
          .doc(userCredential.user!.uid)
          .get();

      if (snapshot.exists) {
        await Provider.of<ProfileProvider>(context, listen: false).getProfile();
        Get.to(() => const HomePage());
      } else {
        Get.to(() => const OnboardingScreen());
      }
      return userCredential.user;
    } catch (error) {
      alertSnackBar(error.toString().split("]").last);
      log('Error signing in: ${error.toString().split("]").last}');
      isLoading.value = false;
      return null;
    }
  }
}
