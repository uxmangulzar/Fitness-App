import 'package:fitness_app/fitness_app/commonWidget.dart';
import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';

class ChatBoot extends StatefulWidget {
  const ChatBoot({Key? key}) : super(key: key);

  @override
  State<ChatBoot> createState() => _ChatBootState();
}

class _ChatBootState extends State<ChatBoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Training Routines"),
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Text(
              "Create Training Routines",
              textAlign: TextAlign.center,
              style: styledText.copyWith(fontSize: 36),
            ))),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: AppColors.kDarkSky1),
                    // controller: TextEditingController(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.kDarkSky1,
                      ),
                      hintText: "Create Training Routines",
                      hintStyle: const TextStyle(color: AppColors.kGrey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.kDarkSky1), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.kDarkSky1), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const CircleAvatar(
                  radius: 28,
                  child: Center(
                      child: Icon(
                    Icons.send_outlined,
                    size: 30,
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
