import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/utill/image_constant.dart';
import 'package:fitness_app/view/screens/profile/screens/view_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchState extends ValueNotifier<bool> {
  SearchState(bool value) : super(value);

  void toggleSearch() {
    value = !value;
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  const CustomAppBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppSizes.screenHeight * 0.02),
        child: const SizedBox.shrink(),
      ),
      elevation: 0,
      backgroundColor: AppColors.kWhite,
      foregroundColor: AppColors.primaryGreen,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () async => await signOut(context),
        child: SizedBox(
          width: AppSizes.screenWidth * 0.3,
          child: Image.asset(
            'assets/images/logo_text.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: [
        SearchWidget(),
        IconButton(
            onPressed: () {
              Get.to(() => const ViewProfileScreen());
            },
            icon: SvgPicture.asset(index == 4
                ? ImageConstant.imgIcons2
                : ImageConstant.imgIcons1)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class SearchWidget extends StatelessWidget {
  final SearchState searchState = SearchState(false);

  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ValueListenableBuilder<bool>(
      valueListenable: searchState,
      builder: (context, isSearching, _) {
        if (isSearching) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              width: size.width * 0.45,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        ImageConstant.imgSearch,
                      ),
                    ),
                  ),
                  hintStyle:
                      styledText.copyWith(color: AppColors.kGrey, fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 9,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: AppColors.primaryGreen, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: AppColors.primaryGreen, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: AppColors.primaryGreen, width: 2),
                  ),
                ),
              ),
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              searchState.toggleSearch(); // Toggles search
            },
            icon: SvgPicture.asset(
                ImageConstant.imgSearch), // Icon to start the search
          );
        }
      },
    );
  }
}
