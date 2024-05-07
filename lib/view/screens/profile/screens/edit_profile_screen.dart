import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fitness_app/firebase/firestore_profile_services.dart';
import 'package:fitness_app/fitness_app/model/profile_model.dart';
import 'package:fitness_app/fitness_app/widgets/image_dialog.dart';
import 'package:fitness_app/fitness_app/widgets/snakbar.dart';
import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/loader.dart';
import 'package:fitness_app/view/screens/profile/widgets/goal_container.dart';
import 'package:fitness_app/view/screens/profile/widgets/personal_info_container.dart';
import 'package:fitness_app/view/screens/profile/widgets/profile_textformfield.dart';
import 'package:fitness_app/view/screens/profile/widgets/tabbar.dart';
import 'package:fitness_app/view/widgets/circle_image.dart';
import 'package:fitness_app/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController tabviewController;
  final ValueNotifier<File?> _selectedImage = ValueNotifier(null);
  final ValueNotifier<String> _selectedGender = ValueNotifier<String>('Female');
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _weightGoalController = TextEditingController();
  final TextEditingController _currentWeightController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  // Default to Female
  void updateProfilePicture(String gender) {
    gender == 'Female'
        ? _selectedGender.value = 'Female'
        : _selectedGender.value = 'Male';
  }

  @override
  void dispose() {
    tabviewController.dispose();
    _selectedGender.dispose(); // Dispose the notifier
    _userNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _activityController.dispose();
    _weightGoalController.dispose();
    _currentWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: const CustomAppBar(index: 4),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile',
                              style: styledText.copyWith(
                                  fontSize: 18,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.width * 0.05,
                            ),
                            ProfileTabBar(
                              onTabChanged: updateProfilePicture,
                              initialTab: _selectedGender.value,
                            ),
                            SizedBox(height: size.width * 0.05),
                            Text(
                              'Username',
                              style: styledText.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryGreen),
                            ),
                            SizedBox(height: size.width * 0.01),
                            ProfileTextFormField(
                                //  height: size.width * 0.09,
                                width: size.width * 0.43,
                                controller: _userNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Username';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                hintText: 'username'),
                            SizedBox(height: size.width * 0.05),
                            Text(
                              'Upload Picture (Optional)',
                              style: styledText.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryGreen),
                            ),
                            SizedBox(
                              height: size.width * 0.02,
                            ),
                            ValueListenableBuilder(
                                valueListenable: _selectedImage,
                                builder: (contex, value, child) {
                                  return GestureDetector(
                                    onTap: () async {
                                      var imageSource =
                                          await showImageSourceSelectionDialog(
                                              context);
                                      if (imageSource != null) {
                                        XFile? xFile = await ImagePicker()
                                            .pickImage(source: imageSource);
                                        if (xFile == null) return;

                                        _selectedImage.value = File(xFile.path);
                                        log('File: ${_selectedImage.value}');
                                        await FirestoreProfileServices()
                                            .uploadProfilePic(
                                                _selectedImage.value!);
                                      }
                                    },
                                    child: value == null
                                        ? DottedBorder(
                                            padding: const EdgeInsets.all(10),
                                            radius: const Radius.circular(30),
                                            color: AppColors.primaryGreen,
                                            borderType: BorderType.RRect,
                                            dashPattern: const [
                                              4,
                                              4,
                                            ],
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.primaryGreen,
                                              size: size.width * 0.06,
                                            ))
                                        : CircleImage(
                                            imageFile: _selectedImage,
                                            onPress: () async {
                                              var imageSource =
                                                  await showImageSourceSelectionDialog(
                                                      context);
                                              if (imageSource != null) {
                                                XFile? xFile =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source:
                                                                imageSource);
                                                if (xFile == null) return;
                                                _selectedImage.value =
                                                    File(xFile.path);
                                                log('File: ${_selectedImage.value}');
                                                await FirestoreProfileServices()
                                                    .uploadProfilePic(
                                                        _selectedImage.value!);
                                              }
                                            },
                                          ),
                                  );
                                })
                          ],
                        ),
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: _selectedGender,
                        builder: (context, value, child) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 35),
                              child: Image.asset(
                                value == 'Female'
                                    ? 'assets/images/img_girl_running.png'
                                    : 'assets/images/young_man_running.png',
                                height: size.height * 0.38,
                                width: size.width * 0.47,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.02),
                  PersonalInfoContainer(
                      heightController: _heightController,
                      weightController: _weightController),
                  SizedBox(height: size.width * 0.03),
                  GoalContainer(
                      activityController: _activityController,
                      weightGoalController: _weightGoalController,
                      currentWeightController: _currentWeightController),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8, bottom: 8, right: 30),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Material(
                        elevation: 3,
                        child: SizedBox(
                          height: size.width * 0.1,
                          width: size.width * 0.20,
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Loader.showLoader(context);
                                ProfileModel profileModel = ProfileModel(
                                    gender: _selectedGender.value,
                                    username: _userNameController.text.trim(),
                                    height: _heightController.text.trim(),
                                    weight: _weightController.text.trim(),
                                    activity: _activityController.text.trim(),
                                    currentWeight:
                                        _currentWeightController.text.trim(),
                                    goalWeight:
                                        _weightGoalController.text.trim());
                                bool response = await FirestoreProfileServices()
                                    .createProfile(profileModel);
                                Loader.hideLoader(context);
                                if (response) {
                                  await Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .getProfile();
                                  successMsg('Success');
                                  Navigator.pop(context);

                                  //   if (_selectedImage.value != null)
                                  //     await FirestoreProfileServices()
                                  //         .uploadProfilePic(
                                  //             _selectedImage.value!);
                                }
                              }
                            },
                            style: ButtonStyle(
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
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
