import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppSizes.screenWidth * 0.02,
          height: AppSizes.screenWidth * 0.02,
          decoration: const BoxDecoration(
              color: AppColors.primaryBlue, shape: BoxShape.circle),
        ),
        Container(
          width: AppSizes.screenWidth * 0.005,
          height: AppSizes.screenWidth * 0.2,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
          ),
        ),
        Container(
          width: AppSizes.screenWidth * 0.02,
          height: AppSizes.screenWidth * 0.02,
          decoration: const BoxDecoration(
              color: AppColors.primaryBlue, shape: BoxShape.circle),
        )
      ],
    );
  }
}
