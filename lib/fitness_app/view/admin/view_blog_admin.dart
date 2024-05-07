import 'package:fitness_app/fitness_app/widgets/blog_bottom_bar.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:fitness_app/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBlogAdmin extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? created;
  final String? createdBy;
  const ViewBlogAdmin(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.created,
      required this.createdBy})
      : super(key: key);

  @override
  State<ViewBlogAdmin> createState() => _ViewBlogAdminState();
}

class _ViewBlogAdminState extends State<ViewBlogAdmin> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: const CustomAppBar(index: 0),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryBlue,
                      )),
                  Text(
                    'Blog Post',
                    style: styledText.copyWith(
                        color: AppColors.primaryBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Center(
                child: Container(
                  height: size.height * 0.3,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/img_image_8_123x320.png')),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ListTile(
                    horizontalTitleGap: 2,
                    leading: CircleAvatar(
                      maxRadius: 16,
                      minRadius: 16,
                      child: Image.asset('assets/images/img_contact_list.png'),
                    ),
                    title: Text(
                      widget.createdBy!,
                      style: styledText.copyWith(
                          color: AppColors.primaryBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      widget.created!,
                      style: styledText.copyWith(
                          color: AppColors.tertiaryGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5),
                    )),
              ),
              ListTile(
                title: Text(
                  widget.title!,
                  style: styledText.copyWith(
                      color: AppColors.primaryGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${widget.subTitle!}It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                  textAlign: TextAlign.justify,
                  textScaleFactor: 1.1,
                  style: styledText.copyWith(
                      fontSize: 14,
                      color: AppColors.tertiaryBlackText,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlogBottomBar(selectedIndex: 0.obs),
    );
  }
}
