// ignore_for_file: dead_code

import 'package:fitness_app/fitness_app/openAi/model/chatmodel.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

/// User Input
class UserInput extends StatelessWidget {
  /// Constructor.
  const UserInput({
    super.key,
    required this.chatcontroller,
  });

  /// Text editing controller
  final TextEditingController chatcontroller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 5,
            color: AppColors.kWhite,
            child: true
                ? TextFormField(
                    cursorColor: AppColors.primaryGreen,
                    controller: chatcontroller,
                    style: const TextStyle(color: AppColors.tertiaryBlackText),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Type Message...",
                        hintStyle:
                            const TextStyle(color: AppColors.tertiaryGray),
                        suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<ChatModel>()
                                  .sendChat(chatcontroller.text.trim());
                              chatcontroller.clear();
                            },
                            child: SvgPicture.asset(
                              'assets/images/ai_textfield_send_icon.svg',
                            ))),
                  )
                : Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 5,
                    color: AppColors.kWhite,
                    child: TextFormField(
                        onFieldSubmitted: (e) {
                          context.read<ChatModel>().sendChat(e);
                          chatcontroller.clear();
                        },
                        controller: chatcontroller,
                        style: const TextStyle(
                          color: AppColors.kWhite,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: SvgPicture.asset(
                              'assets/images/ai_textfield_send_icon.svg',
                            ))),
                  )),
      ),
    );
  }
}
