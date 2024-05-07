import 'package:flutter/material.dart';
class DateScreen extends StatelessWidget {
  final String currentDate;
  const DateScreen({Key? key,required this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(currentDate),),);
  }
}
