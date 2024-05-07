import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/utill/appColor.dart';

import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
          onPressed: () async {
            await signOut(context);
          },
          icon: const Icon(Icons.login_outlined))
    ],
    backgroundColor: AppColors.primaryGreen,
  );
}
