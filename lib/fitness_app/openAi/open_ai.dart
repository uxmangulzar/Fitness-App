import 'package:fitness_app/fitness_app/openAi/model/chatmodel.dart';
import 'package:fitness_app/fitness_app/openAi/widgets/user_input.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';

import 'package:fitness_app/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Assuming you have ChatModel and UserInput defined

class OpenAi extends StatefulWidget {
  const OpenAi({Key? key}) : super(key: key);

  @override
  State<OpenAi> createState() => _OpenAiState();
}

class _OpenAiState extends State<OpenAi> {
  @override
  Widget build(BuildContext context) {
    final chatController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        index: 4,
      ),
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
                  onPressed: () {},
                  icon: SvgPicture.asset(
                      'assets/images/ai_chatbot_more_icon.svg')),
            ],
          ),
          Expanded(
            child: Consumer<ChatModel>(
              builder: (context, model, child) {
                final messages = model.getMessages;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      "Create Training Routines",
                      textAlign: TextAlign.center,
                      style: styledText,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: messages[
                            index], // Assuming messages contain strings
                        // Customize ListTile according to your message structure
                      );
                    },
                  );
                }
              },
            ),
          ),
          UserInput(chatcontroller: chatController)
        ],
      ),
    );
  }
}
