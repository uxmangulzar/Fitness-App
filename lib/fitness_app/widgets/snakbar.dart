import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackBar(String msg) {
  return Get.snackbar("Successfully", "$msg Created Successfully",
      backgroundColor: Colors.white);
}

SnackbarController alertSnackBar(String msg) {
  return Get.snackbar("Alert", "$msg",
      backgroundColor: Colors.redAccent, colorText: AppColors.kWhite);
}

SnackbarController successSnackBar(String msg) {
  return Get.snackbar("Successfully", "$msg Send Successfully",
      backgroundColor: Colors.white);
}

SnackbarController successMsg(String msg) {
  return Get.snackbar("Success", msg, backgroundColor: Colors.white);
}
