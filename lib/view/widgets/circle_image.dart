import 'dart:io';

import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ValueNotifier<File?> imageFile;
  final VoidCallback onPress;

  const CircleImage({Key? key, required this.imageFile, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
          width: size.width * 0.3,
          height: size.width * 0.3,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kWhite,
              image: DecorationImage(
                  fit: BoxFit.fill, image: FileImage(imageFile.value!)))),
      Positioned(
        right: 5,
        bottom: 5,
        child: GestureDetector(
          onTap: onPress,
          child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.kWhite, shape: BoxShape.circle),
              child: const Icon(
                  color: AppColors.primaryGreen, Icons.add_a_photo_outlined)),
        ),
      ),
    ]);
  }
}
