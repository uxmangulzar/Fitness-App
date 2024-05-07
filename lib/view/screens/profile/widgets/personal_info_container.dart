import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/view/screens/profile/widgets/age_bottom_sheet.dart';
import 'package:fitness_app/view/screens/profile/widgets/profile_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonalInfoContainer extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;
  const PersonalInfoContainer(
      {super.key,
      required this.heightController,
      required this.weightController});

  @override
  _PersonalInfoContainerState createState() => _PersonalInfoContainerState();
}

class _PersonalInfoContainerState extends State<PersonalInfoContainer> {
  late final ValueNotifier<bool> visibilityNotifier;
  final ValueNotifier<bool> _isVisibleNotifier = ValueNotifier<bool>(true);

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
      onTap: () {
        toggleVisibility();
      },
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
              child: ValueListenableBuilder(
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
                        'Personal Infos',
                        style: styledText.copyWith(
                            fontSize: 13,
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w600),
                      ),
                      SvgPicture.asset(
                        iconPath,
                      )
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('Height (cm)',
                                      style: styledText.copyWith(
                                          fontSize: 12,
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ProfileTextFormField(
                                        //    height: size.width * 0.09,
                                        width: size.width * 0.3,
                                        controller: widget.heightController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Height';
                                          } else if (double.tryParse(value) ==
                                                  null ||
                                              double.parse(value) > 310.0 ||
                                              double.parse(value) < 0.0) {
                                            return 'enter a valid height';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        hintText: '0.00 cm')),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('Wieght (kg)',
                                      style: styledText.copyWith(
                                          fontSize: 12,
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ProfileTextFormField(
                                        //   height: size.width * 0.09,
                                        width: size.width * 0.3,
                                        controller: widget.weightController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Weight';
                                          } else if (double.tryParse(value) ==
                                                  null ||
                                              double.parse(value) > 500 ||
                                              double.parse(value) < 10) {
                                            return 'enter a valid weight';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        hintText: '0.00 kg')),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: size.width * 0.8,
                            height: size.width * 0.085,
                            decoration: BoxDecoration(
                                color: AppColors.primaryGreen,
                                borderRadius: BorderRadius.circular(5)),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const AgeBottomSheet();
                                    });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Age',
                                    style: styledText.copyWith(
                                        fontSize: 16,
                                        color: AppColors.kWhite,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SvgPicture.asset(
                                      'assets/images/img_icons_onprimarycontainer.svg')
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
