import 'dart:developer';

import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TimeSpinner extends StatelessWidget {
  String title;
  final ValueNotifier<String> timeNotifier;
  // Callback function to pass the updated time
  TimeSpinner({Key? key, required this.timeNotifier, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('h : mm  a');

    log(timeNotifier.value);
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: styledText.copyWith(
                color: AppColors.primaryGreen, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: ValueListenableBuilder<String>(
            valueListenable: timeNotifier,
            builder: (context, value, child) {
              return Container(
                  height: size.width * 0.1,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: AppColors.primaryGreen, width: 1)),
                  child: Center(
                      child: Text(
                    timeNotifier.value,
                    style: styledText.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: SizedBox(
            height: size.height * 0.18,
            width: size.width * 0.4,
            child: TimePickerSpinner(
              time: timeNotifier.value.isNotEmpty
                  ? dateFormat.parse(timeNotifier.value)
                  : null,
              alignment: Alignment.center,
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: 12, color: AppColors.primaryBlue.withOpacity(0.4)),
              highlightedTextStyle:
                  const TextStyle(fontSize: 16, color: AppColors.primaryGreen),
              spacing: 0,
              itemHeight: 40,
              isForce2Digits: true,
              onTimeChange: (time) {
                String formattedTime = DateFormat('h : mm  a').format(time);
                timeNotifier.value = formattedTime;
              },
            ),
          ),
        )
      ],
    );
  }
}
