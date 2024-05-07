import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/view/screens/profile/widgets/profile_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoalContainer extends StatefulWidget {
  final TextEditingController activityController;
  final TextEditingController currentWeightController;
  final TextEditingController weightGoalController;
  const GoalContainer(
      {super.key,
      required this.activityController,
      required this.currentWeightController,
      required this.weightGoalController});

  @override
  State<GoalContainer> createState() => _GoalContainerState();
}

class _GoalContainerState extends State<GoalContainer> {
  final ValueNotifier<bool> _isVisibleNotifier = ValueNotifier<bool>(false);
  @override
  void dispose() {
    super.dispose();
    _isVisibleNotifier.dispose();
  }

  void toggleVisibility() {
    _isVisibleNotifier.value = !_isVisibleNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: toggleVisibility,
      child: Column(
        children: <Widget>[
          Container(
            height: size.width * 0.1,
            width: size.width * 0.85,
            decoration: const BoxDecoration(
                color: AppColors.bgGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ValueListenableBuilder<bool>(
                valueListenable: _isVisibleNotifier,
                builder: (context, isVisible, child) {
                  final String iconPath = isVisible
                      ? 'assets/images/img_icons_primary_18x18.svg'
                      : 'assets/images/img_icons_18x18.svg';

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Goal',
                        style: styledText.copyWith(
                          fontSize: 13,
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SvgPicture.asset(
                        iconPath,
                        // Add appropriate height and width as needed
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _isVisibleNotifier,
            builder: (context, value, child) {
              return Visibility(
                visible: _isVisibleNotifier.value,
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: AppColors.bgGray),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Text('Activity',
                            style: styledText.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600)),
                      ),
                      ProfileTextFormField(
                          // height: size.width * 0.09,
                          width: size.width * 0.8,
                          controller: widget.activityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Activity';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          hintText: 'Text'),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Text('Current Weight (kg)',
                            style: styledText.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600)),
                      ),
                      ProfileTextFormField(
                          //  height: size.width * 0.09,
                          width: size.width * 0.8,
                          controller: widget.currentWeightController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Current Weight';
                            } else if (double.tryParse(value) == null ||
                                double.parse(value) > 500.0 ||
                                double.parse(value) < 0.0) {
                              return 'enter a valid weight';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          hintText: '00'),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Text('Weight Goal (kg)',
                            style: styledText.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600)),
                      ),
                      ProfileTextFormField(
                          // height: size.width * 0.09,
                          width: size.width * 0.8,
                          controller: widget.weightGoalController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Weight Goal';
                            } else if (double.tryParse(value) == null ||
                                double.parse(value) > 500.0 ||
                                double.parse(value) < 10.0) {
                              return 'enter a valid weight';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          hintText: '00'),
                      SizedBox(
                        height: size.width * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/img_icons_cyan_700_24x24.svg'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Calories Goal',
                                  style: styledText.copyWith(
                                      fontSize: 14,
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          Text(
                            '000 per day',
                            style: styledText.copyWith(
                                fontSize: 14,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
