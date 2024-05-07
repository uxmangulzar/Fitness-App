import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/fitness_app/view/home.dart';
import 'package:fitness_app/fitness_app/view/login.dart';
import 'package:fitness_app/fitness_app/view/onBoradScreen.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late AnimationController _animationController;
  String emailCheck = '';

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
      // reverseDuration: const Duration(seconds: 16),
      animationBehavior: AnimationBehavior.normal,
      lowerBound: 1.0,
      upperBound: 10.0,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkUserDataExistence();
      }
    });
    _animationController.forward();
    // _animationController.reverse();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Center(
        child: ScaleTransition(
            scale: _animationController,
            child: const Image(
              height: 20,
              width: 20,
              color: AppColors.kWhite,
              image: ExactAssetImage(
                'assets/images/fitnessApp_logo.png',
              ),
            )),
      ),
    );
  }

  Future<void> checkUserDataExistence() async {
    User? user = auth.currentUser;
    if (user != null) {
      // User is signed in

      // Specify the Firestore collection and document ID
      String collectionName = 'users';
      String documentId = user.uid;
      // Check if the document exists
      DocumentSnapshot snapshot =
          await fireStore.collection(collectionName).doc(documentId).get();

      if (snapshot.exists) {
        Get.to(() => const LogInScreen());

        // Document exists, user data is present
        log('User data exists');
      } else {
        Get.to(() => const OnboardingScreen());
        // Document doesn't exist, user data is not present
        log('User data does not exist');
      }
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
      Get.to(() => const HomePage());
      log('User is signed in as ${user.displayName}');
    } else {
      Get.to(() => const LogInScreen());
      // No user is signed in
      log('No user is signed in');
    }
  }
  // void checkUserDataExistence() async {
  //   User? user = auth.currentUser;
  //
  //   if (user != null) {
  //     // User is signed in
  //
  //     // Specify the Firestore collection and document ID
  //     String collectionName = 'users';
  //     String documentId = user.uid;
  //
  //     // Check if the document exists
  //     DocumentSnapshot snapshot = await fireStore.collection(collectionName).doc(documentId).get();
  //
  //     if (snapshot.exists) {
  //
  //       // Document exists, user data is present
  //      Get.to(()=>HomePage());
  //     } else {
  //       Get.to(()=>LogInScreen());
  //
  //       // Document doesn't exist, user data is not present
  //     log('User data does not exist');
  //     }
  //   } else {
  //     // Get.to(()=>OnboardingScreen());
  //   log("====${ auth.signOut()}");
  //     // No user is signed in
  //     Get.to(()=>OnboardingScreen());
  //
  //   log('No user is signed in');
  //   }
  // }
}
