import 'package:fitness_app/firebase/firestore_training_service.dart';
import 'package:fitness_app/fitness_app/model/training_model.dart';
import 'package:fitness_app/provider/days_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/image_constant.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/view/screens/training/widgets/training_bottom_sheet.dart';
import 'package:fitness_app/view/screens/training/widgets/training_card.dart';
import 'package:fitness_app/view/widgets/custom_icon_button.dart';
import 'package:fitness_app/view/widgets/custom_image_view.dart';
import 'package:fitness_app/view/widgets/days_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              vertical: 8.v,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppSizes.screenHeight * 0.05,
                  child: Row(
                    children: [
                      const Flexible(child: DaysList()),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const TrainingBottomSheet();
                              });
                        },
                        child: CustomIconButton(
                          height: 34.adaptSize,
                          width: 34.adaptSize,
                          padding: EdgeInsets.all(5.h),
                          decoration: IconButtonStyleHelper.outlineBlack,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17.v),
                Consumer<DaysProvider>(builder: (context, value, child) {
                  return StreamBuilder(
                      stream: FirestoreTrainingService().getTrainingsStream(),
                      builder: (context, snapshot) {
                        List<TrainingModel> trainings = snapshot.data ?? [];

                        List<TrainingModel> filteredTrainings = trainings
                            .where(
                                (training) => training.day == value.selectedDay)
                            .toList();

                        if (filteredTrainings.isEmpty) {
                          return const Center(
                              child: Text('No Trainings Available',
                                  style: styledText));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: filteredTrainings.length,
                            itemBuilder: (context, index) {
                              final training = filteredTrainings[index];
                              return TrainingCard(trainingModel: training);
                            });
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
