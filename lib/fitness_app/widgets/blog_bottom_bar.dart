import 'package:fitness_app/fitness_app/model/blog_bottom_menu_model.dart';
import 'package:fitness_app/utill/const.dart';
import 'package:fitness_app/utill/size_utils.dart';
import 'package:fitness_app/utill/theme/theme_helper.dart';
import 'package:fitness_app/view/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogBottomBar extends StatefulWidget {
  final RxInt selectedIndex;
  const BlogBottomBar({
    super.key,
    required this.selectedIndex,
  });
  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<BlogBottomBar> {
  List<BlogBottomMenuModel> blogbottomMenuList = [
    BlogBottomMenuModel(
      icon: 'assets/images/img_nav_85_share.svg',
      activeIcon: 'assets/images/img_nav_85_share.svg',
      title: "85 Shares",
      type: BlogBottomBarEnum.share,
    ),
    BlogBottomMenuModel(
      icon: 'assets/images/blog_comment_icon.svg',
      activeIcon: 'assets/images/blog_comment_icon.svg',
      title: "100 comment",
      type: BlogBottomBarEnum.comment,
    ),
    BlogBottomMenuModel(
      icon: 'assets/images/blog_like_icon.svg',
      activeIcon: 'assets/images/blog_like_icon.svg',
      title: " 75 Like",
      type: BlogBottomBarEnum.like,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18),
      child: Container(
        height: 57.v,
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
          items: List.generate(blogbottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: blogbottomMenuList[index].icon,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    color: theme.colorScheme.primary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.v),
                    child: Text(
                      blogbottomMenuList[index].title ?? "",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              label: '',
            );
          }),
        ),
      ),
    );
  }
}
