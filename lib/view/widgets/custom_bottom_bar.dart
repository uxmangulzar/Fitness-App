// ignore_for_file: must_be_immutable

import 'package:fitness_app/fitness_app/model/bottom_menu_model.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/image_constant.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/app_decoration.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:fitness_app/view/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  final RxInt selectedIndex;
  final Function(int)? onPress;
  const CustomBottomBar(
      {super.key, required this.selectedIndex, required this.onPress});
  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgIcons,
      activeIcon: ImageConstant.imgIcons,
      title: "Today",
      type: BottomBarEnum.today,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconsPrimary,
      activeIcon: ImageConstant.imgIconsPrimary,
      title: "Recipe",
      type: BottomBarEnum.recipe,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconsPrimary20x20,
      activeIcon: ImageConstant.imgIconsPrimary20x20,
      title: "Blog",
      type: BottomBarEnum.blog,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconsPrimary24x24,
      activeIcon: ImageConstant.imgIconsPrimary24x24,
      title: "Training",
      type: BottomBarEnum.training,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIcons24x24,
      activeIcon: ImageConstant.imgIcons24x24,
      title: "AI chat",
      type: BottomBarEnum.aichat,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(
          5.h,
        ),
        border: Border.all(
          color: appTheme.gray50,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: widget.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    color: theme.colorScheme.primary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 9.v),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              activeIcon: Container(
                decoration: AppDecoration.outlinePrimary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: bottomMenuList[index].activeIcon,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      color: theme.colorScheme.primary,
                      margin: EdgeInsets.only(top: 5.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 9.v,
                        bottom: 4.v,
                      ),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            );
          }),
          onTap: widget.onPress),
    );
  }
}
