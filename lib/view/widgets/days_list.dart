import 'package:fitness_app/provider/days_provider.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/app_decoration.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysList extends StatelessWidget {
  const DaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return Consumer<DaysProvider>(builder: (context, value, child) {
            return GestureDetector(
              onTap: () {
                value.setSelectedDay(day);
              },
              child: Container(
                margin: EdgeInsets.only(right: AppSizes.screenWidth * 0.0225),
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 8.v),
                decoration: value.selectedDay == day
                    ? AppDecoration.outlinePrimary2.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5)
                    : null,
                child: Text(day, style: theme.textTheme.bodyLarge),
              ),
            );
          });
        });
  }
}
