import 'package:fitness_app/utill/appColor.dart';
import 'package:fitness_app/utill/app_size.dart';
import 'package:fitness_app/utill/font_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CaloryPage extends StatefulWidget {
  const CaloryPage({Key? key}) : super(key: key);

  @override
  State<CaloryPage> createState() => _CaloryPageState();
}

class _CaloryPageState extends State<CaloryPage> {
  List<String> product = [
    "Bread",
    "Milk",
    "2 Eggs",
    "Bacon",
    "Chicken",
    "Pancakes"
  ];
  List<String> cal = ["60", "100", "120", "300", "300", "200"];
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CALORIES",
          style: titleText,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            // height: AppSizes.appHorizontalXXL,
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: CircularPercentIndicator(
              radius: 130.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: 0.6,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Goal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30.0),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "2000",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30.0),
                      ),
                      Text(
                        " Cal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalSm,
                  ),
                  const Text(
                    "Just a bit more",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30.0),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "920",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30.0),
                      ),
                      Text(
                        "Cal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              backgroundColor: Colors.white,
              progressColor: AppColors.kPrimary,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                    product.length,
                    (index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 6),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  product[index].toString(),
                                  style: titleText,
                                )),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      cal[index].toString(),
                                      style: titleText,
                                    ),
                                    const Text(
                                      "Cal",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            ),
          )),
          SizedBox(
            height: AppSizes.appHorizontalXXL,
          )
          // Center(
          //   child: Column(
          //       children: <Widget>[
          //         new CircularPercentIndicator(
          //           radius: 100.0,
          //           lineWidth: 10.0,
          //           percent: 0.8,
          //           header: new Text("Icon header"),
          //           center: new Icon(
          //             Icons.person_pin,
          //             size: 50.0,
          //             color: Colors.blue,
          //           ),
          //           backgroundColor: Colors.grey,
          //           progressColor: Colors.blue,
          //         ),
          //         new CircularPercentIndicator(
          //           radius: 130.0,
          //           animation: true,
          //           animationDuration: 1200,
          //           lineWidth: 15.0,
          //           percent: 0.4,
          //           center: new Text(
          //             "40 hours",
          //             style:
          //             new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          //           ),
          //           circularStrokeCap: CircularStrokeCap.butt,
          //           backgroundColor: Colors.yellow,
          //           progressColor: Colors.red,
          //         ),
          //         new CircularPercentIndicator(
          //           radius: 120.0,
          //           lineWidth: 13.0,
          //           animation: true,
          //           percent: 0.7,
          //           center: new Text(
          //             "70.0%",
          //             style:
          //             new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          //           ),
          //           footer: new Text(
          //             "Sales this week",
          //             style:
          //             new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          //           ),
          //           circularStrokeCap: CircularStrokeCap.round,
          //           progressColor: Colors.purple,
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(15.0),
          //           child: new CircularPercentIndicator(
          //             radius: 60.0,
          //             lineWidth: 5.0,
          //             percent: 1.0,
          //             center: new Text("100%"),
          //             progressColor: Colors.green,
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsets.all(15.0),
          //           child: new Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //               new CircularPercentIndicator(
          //                 radius: 45.0,
          //                 lineWidth: 4.0,
          //                 percent: 0.10,
          //                 center: new Text("10%"),
          //                 progressColor: Colors.red,
          //               ),
          //               new Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10.0),
          //               ),
          //               new CircularPercentIndicator(
          //                 radius: 45.0,
          //                 lineWidth: 4.0,
          //                 percent: 0.30,
          //                 center: new Text("30%"),
          //                 progressColor: Colors.orange,
          //               ),
          //               new Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10.0),
          //               ),
          //               new CircularPercentIndicator(
          //                 radius: 45.0,
          //                 lineWidth: 4.0,
          //                 percent: 0.60,
          //                 center: new Text("60%"),
          //                 progressColor: Colors.yellow,
          //               ),
          //               new Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 10.0),
          //               ),
          //               new CircularPercentIndicator(
          //                 radius: 45.0,
          //                 lineWidth: 4.0,
          //                 percent: 0.90,
          //                 center: new Text("90%"),
          //                 progressColor: Colors.green,
          //               )
          //             ],
          //           ),
          //         )
          //       ]),
          // ),
        ],
      ),
    );
  }
}
