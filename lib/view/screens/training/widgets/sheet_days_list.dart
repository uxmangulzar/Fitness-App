import 'package:fitness_app/provider/days_provider.dart';
import 'package:fitness_app/utill/appColor.dart';

import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/font_style.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetDaysList extends StatelessWidget {
  const SheetDaysList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              child: value.selectedDay == day
                  ? Container(
                      height: size.width * 0.04,
                      width: size.width * 0.14,
                      // margin:
                      //     EdgeInsets.only(right: AppSizes.screenWidth * 0.0225),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 7.h, vertical: 8.v),
                      decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(day,
                            style: styledText.copyWith(
                                color: AppColors.kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                      child: Text(day,
                          style: styledText.copyWith(
                              color: AppColors.tertiaryGray,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
            );
          });
        });
  }
}
