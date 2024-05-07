import 'package:fitness_app/utill/const.dart';

class BlogBottomMenuModel {
  BlogBottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BlogBottomBarEnum type;
}