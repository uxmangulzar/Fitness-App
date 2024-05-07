import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';

class Loader {
  static void showLoader(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Container(
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.kWhite,
            ),
            child:
                const CircularProgressIndicator(color: AppColors.primaryGreen),
          ));
        });
  }

  static void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}
