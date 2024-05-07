import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownList extends StatelessWidget {
  final String title;
  final ValueNotifier<String> selectedValue;
  final List<String> dropdownValues;
  const CustomDropdownList(
      {super.key,
      required this.selectedValue,
      required this.dropdownValues,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: styledText.copyWith(
                  fontSize: 12,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w600)),
          ValueListenableBuilder(
            valueListenable: selectedValue,
            builder: (context, value, child) {
              return DropdownButton(
                iconEnabledColor: AppColors.primaryGreen,
                menuMaxHeight: AppSizes.screenHeight * 0.3,
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                value: selectedValue.value,
                items: dropdownValues.map(
                  (String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item,
                          style:
                              item == 'Month' || item == 'Year' || item == 'Day'
                                  ? mediumText.copyWith(
                                      color: AppColors.tertiaryGray)
                                  : styledText.copyWith(
                                      color: AppColors.primaryGreen)),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) =>
                    selectedValue.value = newValue as String,
              );
            },
          )
        ],
      ),
    );
  }
}
