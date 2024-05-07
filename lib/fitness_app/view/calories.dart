// ignore_for_file: dead_code

import 'dart:developer';

import 'package:fitness_app/fitness_app/view/calories_tabs/calory.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/macros_tab.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/nutrients.dart';

import 'package:fitness_app/utill/appColor.dart';
import 'package:flutter/material.dart';

class CaloriesPage extends StatefulWidget {
  const CaloriesPage({Key? key}) : super(key: key);

  @override
  State<CaloriesPage> createState() => _CaloriesPageState();
}

class _CaloriesPageState extends State<CaloriesPage> {
  @override
  Widget build(BuildContext context) {
    log('Insidee calories page');
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        body: Column(
          children: [
            Container(
              color: AppColors.tabGray,
              child: TabBar(
                unselectedLabelColor: AppColors.primaryGreen,
                indicator: BoxDecoration(
                    color: AppColors.primaryGreen,
                    borderRadius: BorderRadius.circular(
                        8) // Set the background color of the selected tab
                    ),
                tabs: const [
                  Tab(text: 'Calories'),
                  Tab(text: 'Nutrients'),
                  Tab(text: 'Macros'),
                  Tab(icon: Icon(Icons.calendar_month_outlined)),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CaloriesTab(),
                  NutrientsTab(),
                  // Center(child: Text('Tab 2 Content')),
                  // HomePage2(),
                  // Content for Tab 3
                  MacrosTab(),
                  // ABC()
                  Center(child: Text('Tab 3 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // CalendarController? _calendarController;
//   DateTime currentDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     // _calendarController = CalendarController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Calendar Day View'),
//         ),
//         body: true
//             ? Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back),
//                           onPressed: () {
//                             // Navigate to the previous day
//                             currentDate =
//                                 currentDate.subtract(const Duration(days: 1));
//                             formattedDate =
//                                 DateFormat('dd/MM/yyyy').format(currentDate);
//                             setState(() {});
//                           },
//                         ),
//                         Text(
//                           formattedDate,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward),
//                           onPressed: () {
//                             // Navigate to the next day
//                             currentDate =
//                                 currentDate.add(const Duration(days: 1));
//                             formattedDate =
//                                 DateFormat('dd/MM/yyyy').format(currentDate);
//                             setState(() {});

//                             // Navigate to the DateScreen with the next date
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => DateScreen(
//                                       currentDate: currentDate.toString())),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                 children: <Widget>[
//                   TableCalendar(
//                     // calendarFormat: CalendarFormat.single,
//                     headerVisible: true,
//                     shouldFillViewport: false,
//                     availableGestures: AvailableGestures.verticalSwipe,
//                     // calendarController: _calendarController,
//                     calendarBuilders: CalendarBuilders(
//                       headerTitleBuilder: (context, date) {
//                         final today = DateTime.now();
//                         if (date.day == today.day &&
//                             date.month == today.month &&
//                             date.year == today.year) {
//                           // Customize the appearance of the current day cell.
//                           return Container(
//                             alignment: Alignment.center,
//                             decoration: const BoxDecoration(
//                               color: Colors.blue,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Text(
//                               date.day.toString(),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           );
//                         } else {
//                           return const SizedBox
//                               .shrink(); // Hide non-current day cells.
//                         }
//                       },
//                     ),
//                     focusedDay: DateTime.now(),
//                     firstDay: DateTime.now(),
//                     lastDay: DateTime(2024),
//                   ),
//                 ],
//               ));
//   }

//   @override
//   void dispose() {
//     // _calendarController.dispose();
//     super.dispose();
//   }
// }
