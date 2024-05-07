import 'package:fitness_app/firebase/firestore_profile_services.dart';
import 'package:fitness_app/fitness_app/model/profile_model.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/loader.dart';
import 'package:fitness_app/view/widgets/custom_dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AgeBottomSheet extends StatefulWidget {
  const AgeBottomSheet({super.key});

  @override
  State<AgeBottomSheet> createState() => _AgeBottomSheetState();
}

class _AgeBottomSheetState extends State<AgeBottomSheet> {
  final ValueNotifier<String> _selectedMonth = ValueNotifier('Month');
  final ValueNotifier<String> _selectedYear = ValueNotifier('Year');
  final ValueNotifier<String> _selectedDay = ValueNotifier('Day');
  // TextEditingController yearController = TextEditingController();
  // TextEditingController dayController = TextEditingController();

  @override
  void dispose() {
    _selectedMonth.dispose();
    _selectedYear.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: size.width * 0.1,
          decoration: const BoxDecoration(color: AppColors.primaryGreen),
          child: Center(
              child: Text(
            'Age',
            style: styledText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.kWhite,
            ),
          )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.screenHeight * 0.01,
                horizontal: AppSizes.screenWidth * 0.03),
            child: FutureBuilder(
                future: FirestoreProfileServices().getProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryGreen,
                    ));
                  }
                  ProfileModel? profileModel = snapshot.data;
                  if (profileModel != null) {
                    if (profileModel.month!.isNotEmpty) {
                      _selectedMonth.value = profileModel.month!;
                    }
                    if (profileModel.year!.isNotEmpty) {
                      _selectedYear.value = profileModel.year!;
                    }
                    if (profileModel.day!.isNotEmpty) {
                      _selectedDay.value = profileModel.day!;
                    }
                  }
                  return Column(
                    children: [
                      CustomDropdownList(
                          selectedValue: _selectedMonth,
                          dropdownValues: const ['Month', ...months],
                          title: 'Month'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomDropdownList(
                                selectedValue: _selectedYear,
                                dropdownValues: ['Year', ...years],
                                title: 'Year'),
                          ),
                          Expanded(
                            child: CustomDropdownList(
                                selectedValue: _selectedDay,
                                dropdownValues: const ['Day', ...days],
                                title: 'Day'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.close(1);
                            },
                            child: Text(
                              'Dismiss',
                              style: styledText.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_selectedMonth.value == 'Month' ||
                                  _selectedYear.value == 'Year' ||
                                  _selectedDay.value == 'Day') {
                                alertSnackBar('Please fill all fields');
                                return;
                              }
                              Loader.showLoader(context);
                              ProfileModel profileModel = ProfileModel(
                                  month: _selectedMonth.value,
                                  year: _selectedYear.value,
                                  day: _selectedDay.value);

                              bool response = await FirestoreProfileServices()
                                  .createProfile(profileModel, isAge: true);
                              Loader.hideLoader(context);
                              if (response) {
                                await Provider.of<ProfileProvider>(context,
                                        listen: false)
                                    .getProfile();
                                successMsg('Age added successfully');
                                Get.close(1);
                              }
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith<
                                      EdgeInsetsGeometry>(
                                  (states) => const EdgeInsets.symmetric(
                                      horizontal: 10)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return AppColors
                                      .primaryBlue; // Color when button is hovered
                                } else {
                                  return AppColors
                                      .primaryGreen; // Default color
                                }
                              }),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                return Colors.white; // Default text color
                              }),
                            ),
                            child: Text(
                              'Save',
                              style: styledText.copyWith(
                                  color: AppColors.kWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }
}
 // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Year',
                    //         style: styledText.copyWith(
                    //             fontSize: 12,
                    //             color: AppColors.primaryGreen,
                    //             fontWeight: FontWeight.w600)),
                    //     ProfileTextFormField(
                    //         height: size.width * 0.09,
                    //         width: size.width * 0.4,
                    //         controller: yearController,
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'Enter Year';
                    //           }
                    //           return null;
                    //         },
                    //         keyboardType: TextInputType.number,
                    //         hintText: 'Year')
                    //   ],
                    // ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Day',
                    //         style: styledText.copyWith(
                    //             fontSize: 12,
                    //             color: AppColors.primaryGreen,
                    //             fontWeight: FontWeight.w600)),
                    //     ProfileTextFormField(
                    //         height: size.width * 0.09,
                    //         width: size.width * 0.4,
                    //         controller: dayController,
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'Enter Day';
                    //           }
                    //           return null;
                    //         },
                    //         keyboardType: TextInputType.number,
                    //         hintText: 'Day')
                    //   ],
                    // ),