import 'package:fitness_app/firebase/firestore_training_service.dart';
import 'package:fitness_app/fitness_app/model/training_model.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/image_constant.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/app_decoration.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:fitness_app/view/screens/training/widgets/edit_training_sheet.dart';
import 'package:fitness_app/view/screens/training/widgets/timeline.dart';
import 'package:fitness_app/view/widgets/icon_text_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrainingCard extends StatelessWidget {
  final TrainingModel trainingModel;
  const TrainingCard({Key? key, required this.trainingModel})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.screenHeight * 0.01),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trainingModel.startTime!,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 80.v),
              Text(
                trainingModel.endTime!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(width: 10.h),
          const Timeline(),
          SizedBox(width: 15.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 7.v,
              ),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trainingModel.title!,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        constraints:
                            BoxConstraints(maxHeight: size.width * 0.3),
                        position: PopupMenuPosition.over,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        // CustomRectangularBorder(
                        //     height: size.width * 0.25, width: size.width * 0.35),
                        icon: const Icon(Icons.more_horiz_outlined,
                            color: AppColors.primaryBlue),
                        offset: Offset(0, size.width * 0.07),
                        onSelected: (value) async {
                          if (value == 'edit') {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return EditTrainingBottomSheet(
                                    trainingModel: trainingModel,
                                  );
                                });
                          } else if (value == 'delete') {
                            final firestoreService = FirestoreTrainingService();
                            firestoreService.deleteTraining(trainingModel.id!);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                              height: size.height * 0.04,
                              value: 'edit',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/img_icons_gray_500.svg'),
                                  Text(
                                    'Edit Card',
                                    style: styledText.copyWith(
                                        color: AppColors.tertiaryGray,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ],
                              )),
                          PopupMenuItem<String>(
                              height: size.height * 0.04,
                              value: 'delete',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/img_icons_gray_500_15x15.svg'),
                                  Text(
                                    'Delete Card',
                                    style: styledText.copyWith(
                                      color: AppColors.tertiaryGray,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 21.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: IconTextListTile(
                            iconPath: ImageConstant.imgProperty1Days,
                            title: trainingModel.duration!),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconTextListTile(
                            iconPath: ImageConstant.imgIconsCyan700,
                            title: trainingModel.calories!),
                      )
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
