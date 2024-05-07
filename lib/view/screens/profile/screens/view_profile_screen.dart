import 'package:fitness_app/provider/profile_provider.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/view/screens/profile/screens/edit_profile_screen.dart';
import 'package:fitness_app/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: const CustomAppBar(index: 4),
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: RefreshIndicator(
            onRefresh: () async {
              await value.getProfile();
            },
            child: value.profile == null
                ? ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: styledText.copyWith(
                            fontSize: 30,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            Get.to(() => const EditProfileScreen());
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.primaryGreen,
                          ),
                          label: Text(
                            'Edit Profile',
                            style: styledText.copyWith(
                                color: AppColors.primaryGreen),
                          ))
                    ],
                  )
                : ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profile',
                                style: styledText.copyWith(
                                    fontSize: 30,
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton.icon(
                                  onPressed: () {
                                    Get.to(() => const EditProfileScreen());
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.primaryGreen,
                                  ),
                                  label: Text(
                                    'Edit Profile',
                                    style: styledText.copyWith(
                                        color: AppColors.primaryGreen),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.bgGray,
                            backgroundImage: value
                                        .profile!.profilePicUrl!.isNotEmpty ||
                                    value.profile!.profilePicUrl != null
                                ? NetworkImage(value.profile!.profilePicUrl!)
                                    as ImageProvider
                                : const AssetImage(
                                    'assets/images/img_contact_list.png'),
                            maxRadius: 60,
                            minRadius: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              value.profile!.username!,
                              style: styledText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryGreen,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              value.profile!.gender!,
                              style: styledText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryBlue,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.1,
                      ),
                      Center(
                        child: Container(
                          width: size.width * 0.85,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.bgGray),
                          child: Column(
                            children: [
                              Text(
                                'My Info',
                                style: styledText.copyWith(
                                    fontSize: 18,
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text('Height',
                                              style: styledText.copyWith(
                                                  fontSize: 14,
                                                  color: AppColors.primaryGreen,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(value.profile!.height!,
                                              style: styledText.copyWith(
                                                  fontSize: 13,
                                                  color: AppColors.primaryBlue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text('Weight',
                                              style: styledText.copyWith(
                                                  fontSize: 14,
                                                  color: AppColors.primaryGreen,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(value.profile!.weight!,
                                              style: styledText.copyWith(
                                                  fontSize: 13,
                                                  color: AppColors.primaryBlue,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Age',
                                    style: styledText.copyWith(
                                        fontSize: 14,
                                        color: AppColors.primaryGreen,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    '${value.profile!.day} ${value.profile!.month}, ${value.profile!.year}',
                                    style: styledText.copyWith(
                                        fontSize: 13,
                                        color: AppColors.primaryBlue,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Activity',
                                        style: styledText.copyWith(
                                            fontSize: 14,
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(value.profile!.activity!,
                                        style: styledText.copyWith(
                                            fontSize: 13,
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Current Weight',
                                        style: styledText.copyWith(
                                            fontSize: 14,
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(value.profile!.currentWeight!,
                                        style: styledText.copyWith(
                                            fontSize: 13,
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Weight Goal',
                                        style: styledText.copyWith(
                                            fontSize: 14,
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(value.profile!.goalWeight!,
                                        style: styledText.copyWith(
                                            fontSize: 13,
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
