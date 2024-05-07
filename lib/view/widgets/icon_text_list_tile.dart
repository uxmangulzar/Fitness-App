import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/custom_text_style.dart';
import 'package:fitness_app/view/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class IconTextListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  const IconTextListTile(
      {super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: CustomImageView(
          imagePath: iconPath, height: 20.adaptSize, width: 20.adaptSize),
      title: Text(title, style: CustomTextStyles.bodyLargeOnPrimary),
    );
  }
}
