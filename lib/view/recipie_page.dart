import 'package:flutter/material.dart';
class RecipiePage extends StatefulWidget {
  const RecipiePage({Key? key}) : super(key: key);

  @override
  State<RecipiePage> createState() => _RecipiePageState();
}

class _RecipiePageState extends State<RecipiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Expanded(child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
          return
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(

                  border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
              children: [
                Image.asset("assets/bottom_icons/calories.png",height: 40),
              ],
            ),),
          );
        })),
      ],
    ),);
  }
}
