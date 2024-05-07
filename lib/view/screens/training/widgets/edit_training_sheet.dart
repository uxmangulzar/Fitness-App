import 'dart:developer';
import 'package:fitness_app/firebase/firestore_training_service.dart';
import 'package:fitness_app/fitness_app/model/training_model.dart';
import 'package:fitness_app/fitness_app/model/training_title_model.dart';
import 'package:fitness_app/provider/days_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/loader.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:fitness_app/view/screens/profile/widgets/profile_textformfield.dart';
import 'package:fitness_app/view/screens/training/widgets/sheet_days_list.dart';
import 'package:fitness_app/view/screens/training/widgets/time_spinning_widget.dart';
import 'package:fitness_app/view/screens/training/widgets/training_title_dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditTrainingBottomSheet extends StatefulWidget {
  final TrainingModel trainingModel;

  const EditTrainingBottomSheet({super.key, required this.trainingModel});

  @override
  State<EditTrainingBottomSheet> createState() => _TrainingBottomSheetState();
}

class _TrainingBottomSheetState extends State<EditTrainingBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<String>? _fromTimeNotifier;
  ValueNotifier<String>? _toTimeNotifier;
  late TextEditingController _titleController;
  final TextEditingController _caloriesController = TextEditingController();
  ValueNotifier<TrainingTitleModel> trainingTitleNotifier =
      ValueNotifier(TrainingTitleModel(id: '', title: 'Title', calories: ''));

  @override
  void initState() {
    super.initState();
    _fromTimeNotifier = ValueNotifier(widget.trainingModel.startTime ?? '');
    _toTimeNotifier = ValueNotifier(widget.trainingModel.endTime ?? '');
    _titleController = TextEditingController(text: widget.trainingModel.title);
  }

  @override
  void dispose() {
    _fromTimeNotifier!.dispose();
    _toTimeNotifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(_fromTimeNotifier!.value);
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            height: size.width * 0.1,
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
            ),
            child: Center(
                child: Text(
              'Edit Card',
              style: styledText.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.kWhite,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${widget.trainingModel.title} ${widget.trainingModel.calories}',
                      style: theme.textTheme.titleSmall),
                  SizedBox(height: size.height * 0.02),
                  StreamBuilder(
                      stream:
                          FirestoreTrainingService().getTrainingTitlesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<TrainingTitleModel> trainingTitles =
                              snapshot.data ?? [];
                          if (trainingTitles.isEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title",
                                    style: theme.textTheme.titleSmall),
                                SizedBox(height: size.height * 0.02),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProfileTextFormField(
                                          width: double.infinity,
                                          controller: _titleController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Title';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          hintText: 'title'),
                                    ),
                                    SizedBox(width: size.width * 0.03),
                                    Expanded(
                                      child: ProfileTextFormField(
                                          width: double.infinity,
                                          controller: _caloriesController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Calories';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          hintText: 'calories'),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                          return TrainingTitleDropdownList(
                            selectedValue: trainingTitleNotifier,
                            dropdownValues: [
                              TrainingTitleModel(
                                  id: '', title: 'Title', calories: ''),
                              ...trainingTitles
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Select day", style: theme.textTheme.titleSmall),
                  SizedBox(height: size.width * 0.04),
                  SizedBox(
                      height: AppSizes.screenHeight * 0.04,
                      child: const SheetDaysList()),
                  SizedBox(height: size.width * 0.1),
                  Text(
                    "Select time",
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: size.width * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: TimeSpinner(
                              timeNotifier: _fromTimeNotifier!, title: 'From')),
                      Expanded(
                          child: TimeSpinner(
                              timeNotifier: _toTimeNotifier!, title: 'To')),
                    ],
                  ),
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
                          if (trainingTitleNotifier.value.title == 'Title' &&
                              !_formKey.currentState!.validate()) {
                            return;
                          }
                          Loader.showLoader(context);
                          String selectedDay =
                              Provider.of<DaysProvider>(context, listen: false)
                                  .selectedDay;
                          log('$selectedDay, ${_toTimeNotifier!.value}, ${_fromTimeNotifier!.value}');

                          // Remove extra spaces and then convert strings to DateTime objects
                          DateFormat dateFormat = DateFormat('h : mm  a');

                          DateTime startTime =
                              dateFormat.parse(_toTimeNotifier!.value);
                          DateTime endTime =
                              dateFormat.parse(_fromTimeNotifier!.value);

                          // Calculate duration
                          Duration duration = startTime.difference(endTime);
                          int hours = duration.inHours;
                          int minutes = duration.inMinutes.remainder(60);

                          String title =
                              trainingTitleNotifier.value.title != 'Title'
                                  ? trainingTitleNotifier.value.title!
                                  : _titleController.text.trim();
                          String calories =
                              trainingTitleNotifier.value.title != 'Title'
                                  ? trainingTitleNotifier.value.calories!
                                  : _caloriesController.text.trim();

                          TrainingModel trainingModel = TrainingModel(
                              title: title,
                              day: selectedDay,
                              startTime: _fromTimeNotifier!.value,
                              endTime: _toTimeNotifier!.value,
                              duration: '${hours}h ${minutes}m',
                              calories: calories);
                          bool response = await FirestoreTrainingService()
                              .updateTraining(
                                  trainingModel, widget.trainingModel.id!);
                          if (response) {
                            Get.close(1);
                          }
                          Loader.hideLoader(context);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty
                              .resolveWith<EdgeInsetsGeometry>((states) =>
                                  const EdgeInsets.symmetric(horizontal: 10)),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (states.contains(MaterialState.hovered)) {
                              return AppColors
                                  .primaryBlue; // Color when button is hovered
                            } else {
                              return AppColors.primaryGreen; // Default color
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
