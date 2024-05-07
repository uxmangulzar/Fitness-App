import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';

class ProfileTabBar extends StatefulWidget {
  final Function(String) onTabChanged;
  final String initialTab; // New parameter for initial tab value
  const ProfileTabBar(
      {Key? key, required this.onTabChanged, required this.initialTab})
      : super(key: key);

  @override
  _ProfileTabBarState createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender =
        widget.initialTab; // Set initial value from the constructor
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: selectedGender == 'Female' ? 0 : 1);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      String selectedGender;
      if (_tabController.index == 0) {
        selectedGender = "Female";
      } else {
        selectedGender = "Male";
      }
      widget.onTabChanged(selectedGender); // Notify the parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.width * 0.09,
      width: size.width * 0.43,
      decoration: BoxDecoration(
        color: AppColors.bgGray,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.primaryGreen,
          width: 1,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelPadding: EdgeInsets.zero,
        labelColor: AppColors.kWhite,
        labelStyle: styledText.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryGreen,
            fontSize: 14),
        unselectedLabelColor: AppColors.primaryGreen,
        unselectedLabelStyle: styledText.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        indicator: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        tabs: const [
          Tab(
            text: 'Female',
          ),
          Tab(
            text: 'Male',
          ),
        ],
      ),
    );
  }
}
