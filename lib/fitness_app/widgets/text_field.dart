
import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  final String? hintTxt;
  final TextEditingController? controller;
  final bool? isMaxLines;
  const AppTextField({Key? key,required this.controller,this.hintTxt,this.isMaxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        controller: controller,
        maxLines:isMaxLines==true?6:1,
        decoration: InputDecoration(hintText:hintTxt,
          enabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide( color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder:   OutlineInputBorder(
            borderSide:
            const BorderSide( color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
