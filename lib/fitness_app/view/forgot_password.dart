import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  void _sendPasswordResetEmail() async {
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      _emailController.clear();
      successSnackBar("Email");
      isLoading.value = false;
      // Password reset email sent successfully
      // Provide feedback to the user, e.g., show a snackbar or navigate to another screen.
    } catch (e) {
      isLoading.value = false;
      alertSnackBar(e.toString().split("]").last);
      log('Error sending password reset email: $e');
      // Handle and display the error to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      backgroundColor: AppColors.bgGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: AppColors.bgGray,
        title: const Text(
          'Forgot Password',
          style: styledText,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: AppSizes.appVerticalSm,
                ),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.kWhite),
                    controller: _emailController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(
                        Icons.mail_outlined,
                        color: Colors.white,
                      ),
                      hintStyle: const TextStyle(color: AppColors.kGrey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.kWhite), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.kWhite), //<-- SEE HERE
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
                isLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : InkWell(
                        onTap: _sendPasswordResetEmail,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                " Send",
                                style: styledText.copyWith(
                                    fontSize: 24,
                                    color: AppColors.lightGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
