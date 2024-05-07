import 'package:fitness_app/fitness_app/openAi/open_ai.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AiStartingPage extends StatefulWidget {
  const AiStartingPage({Key? key}) : super(key: key);
  @override
  State<AiStartingPage> createState() => _AiStartingPageState();
}

class _AiStartingPageState extends State<AiStartingPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.kWhite,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'AI chat bots',
                      style: styledText.copyWith(
                          color: AppColors.primaryGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        signOut(context);
                      },
                      icon: SvgPicture.asset(
                          'assets/images/ai_chatbot_more_icon.svg')),
                ],
              ),
              SizedBox(
                  width: size.width * 0.5,
                  height: size.width * 0.4,
                  child: Image.asset(
                    'assets/images/img_0001_2.png',
                    fit: BoxFit.contain,
                  )),
              Text(
                'Hello I am AI chat rebot! and I am \nhere to assist you ',
                textAlign: TextAlign.center,
                style: styledText.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreen),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Suggestions',
                    style: styledText.copyWith(
                        fontSize: 20,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: size.width * 0.75),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.bgGray,
                      ),
                      child: Text(
                        'What can i do for my fitness?',
                        style: styledText.copyWith(
                            color: AppColors.primaryGreen, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 1,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: size.width * 0.75),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.bgGray,
                      ),
                      child: Text(
                        'What is the best exercise to in winter?',
                        style: styledText.copyWith(
                            color: AppColors.primaryGreen, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: size.width * 0.75),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.bgGray,
                      ),
                      child: Text(
                        'What is my Weight?',
                        style: styledText.copyWith(
                            color: AppColors.primaryGreen, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    elevation: 3,
                    child: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.33,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const OpenAi())));
                        },
                        style: ButtonStyle(
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
                          'Get Started',
                          style: styledText.copyWith(
                              color: AppColors.kWhite,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

/// Section Widget
