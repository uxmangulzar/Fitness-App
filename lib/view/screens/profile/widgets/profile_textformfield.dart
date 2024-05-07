import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';

class ProfileTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final double width;

  final String hintText;
  const ProfileTextFormField({
    super.key,
    required this.width,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
          cursorColor: AppColors.primaryGreen,
          decoration: InputDecoration(
            hintStyle:
                styledText.copyWith(color: AppColors.kGrey, fontSize: 12),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 9,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.primaryGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.primaryGreen),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.primaryGreen),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          validator: validator),
    );
  }
}
