import 'dart:developer';

import 'package:fitness_app/fitness_app/model/training_title_model.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class TrainingTitleDropdownList extends StatelessWidget {
  final ValueNotifier<TrainingTitleModel> selectedValue;
  final List<TrainingTitleModel> dropdownValues;

  const TrainingTitleDropdownList({
    Key? key,
    required this.selectedValue,
    required this.dropdownValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (TrainingTitleModel title in dropdownValues) {
      log('${title.id}, ${title.title},${title.calories}');
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title", style: theme.textTheme.titleSmall),
          ValueListenableBuilder(
            valueListenable: selectedValue,
            builder: (context, value, child) {
              return DropdownButton<TrainingTitleModel>(
                  iconEnabledColor: AppColors.primaryGreen,
                  menuMaxHeight: AppSizes.screenHeight * 0.3,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  value: selectedValue.value,
                  items: dropdownValues.map(
                    (TrainingTitleModel item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.title}',
                                style: item.title == 'Title'
                                    ? mediumText.copyWith(
                                        color: AppColors.tertiaryGray)
                                    : styledText.copyWith(
                                        color: AppColors.primaryGreen)),
                            Text('${item.calories}',
                                style: item.title == 'Title'
                                    ? mediumText.copyWith(
                                        color: AppColors.tertiaryGray)
                                    : styledText.copyWith(
                                        color: AppColors.primaryGreen))
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (TrainingTitleModel? newValue) =>
                      selectedValue.value = newValue as TrainingTitleModel);
            },
          ),
        ],
      ),
    );
  }
}
