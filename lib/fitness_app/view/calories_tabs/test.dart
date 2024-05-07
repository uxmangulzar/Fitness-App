// import 'package:flutter/material.dart';
//
//
//
// class ABC extends StatefulWidget {
//   @override
//   _ABCState createState() => _ABCState();
// }
//
// class _ABCState extends State<ABC> {
//   final List<String> allFoods = [
//     'Pizza',
//     'Sushi',
//     'Spaghetti',
//     'Hamburger',
//     'Tacos',
//     'Salad',
//     'Fried Chicken',
//     'Ice Cream',
//     'Pancakes',
//     'Steak',
//   ];
//
//   List<String> filteredFoods = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredFoods = allFoods;
//   }
//
//   void filterFoods(String query) {
//     setState(() {
//       filteredFoods = allFoods
//           .where((food) =>
//           food.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Filter Foods'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: filterFoods,
//               decoration: InputDecoration(
//                 labelText: 'Search Food',
//                 hintText: 'Enter a food name',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredFoods.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(filteredFoods[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// import 'dart:io';
//
// import 'package:butterfly_app/commonWidget/appNavigationBar.dart';
// import 'package:butterfly_app/pages/accident_report.dart';
// import 'package:butterfly_app/pages/catalog.dart';
// import 'package:butterfly_app/pages/clinical.dart';
// import 'package:butterfly_app/pages/monarch.dart';
// import 'package:butterfly_app/pages/ifu.dart';
// import 'package:butterfly_app/pages/video.dart';
// import 'package:butterfly_app/pages/videoScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:url_launcher/url_launcher.dart' as u;
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   Color color=Colors.blueAccent;
//   static final List<Widget> _screens = <Widget>[
//     MonarchHome(),
//     Catalog(),
//     IFUScreen(),
//     VideoScreen(),
//     ClinicalSupport(),
//     AccidentReport(),
//   ];
//
//
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> bottomWidget = [
//       Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [Image.asset("assets/images/transparent_logo.png",height: 24,color: _selectedIndex==0?color: Colors.grey ), Text("Home",style: TextStyle(color: _selectedIndex==0?color: Colors.grey ),)],
//       ),
//       Column(
//         children: [Icon(Icons.book,color: _selectedIndex==1?color: Colors.grey ), Text("Catalog",style: TextStyle(color: _selectedIndex==1?color: Colors.grey ),)],
//       ),
//       Column(
//         children: [Icon(Icons.insert_drive_file,color: _selectedIndex==2?color: Colors.grey), Text("IFU",style: TextStyle(color: _selectedIndex==2?color: Colors.grey ),)],
//       ),
//       Column(
//         children: [Icon(Icons.video_collection_sharp,color: _selectedIndex==3?color: Colors.grey), Text("Video",style: TextStyle(color: _selectedIndex==3?color: Colors.grey ),)],
//       ),
//       Column(
//         children: [Icon(Icons.support_outlined,color: _selectedIndex==4?color: Colors.grey), Text("Support",style: TextStyle(color: _selectedIndex==4?color: Colors.grey ),)],
//       ),
//       Column(
//         children: [Icon(Icons.real_estate_agent_rounded,color: _selectedIndex==5?color: Colors.grey),Text("Accident",style: TextStyle(color: _selectedIndex==5?color: Colors.grey ),)],
//       ),
//     ];
//     return WillPopScope(
//       onWillPop: () async {
//         if (Platform.isAndroid) {
//           SystemNavigator.pop();
//         } else if (Platform.isIOS) {
//           exit(0);
//         }
//         return false;
//       },
//       child: Scaffold(
//         // appBar: AppBar(
//         //   automaticallyImplyLeading: false,
//         //   elevation: 0,
//         //   title: const Text("Monarch"),
//         //   centerTitle: true,
//         // ),
//         body: Center(
//           child: _screens.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: true
//             ?
//         SizedBox(
//           // height: 40,
//           width: MediaQuery.of(context).size.width,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: List.generate(bottomWidget.length, (index) =>
//                       InkWell(
//                           onTap:(){
//                             setState(() {
//                               _onItemTapped(index);
//                               if( _selectedIndex ==index){
//                                 color=Colors.blueAccent;
//                               }
//                               else{
//                                 color=Colors.black;
//                               }
//                             });
//                           } ,
//                           child:
//
//                           // Text(index.toString())
//
//                           // bottomWidget(widget: Image.asset("assets/images/monarch_logo.png",height: 20,color:color),string :"Monarch")
//
//                           // Column(
//                           //   mainAxisSize: MainAxisSize.min,
//                           //   children: [Image.asset("assets/images/monarch_logo.png",height: 40,), Text("Monarch")],
//                           // ),
//                           // Text(index.toString())
//                           bottomWidget[index]
//                       ))
//               ),
//             ),
//           ),
//         )
//             : Row(
//           children: [
//             Card(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [Text("data"), Icon(Icons.add)],
//               ),
//             ),
//             Expanded(
//               child: CustomBottomNavigationBar(
//                 items: <CustomBottomNavigationBarItem>[
//                   CustomBottomNavigationBarItem(
//                       icon: Icons.book, label: 'Catalog'),
//                   CustomBottomNavigationBarItem(
//                       icon: Icons.insert_drive_file, label: 'IFU'),
//                   CustomBottomNavigationBarItem(
//                       icon: Icons.video_collection_sharp, label: 'Video'),
//                   CustomBottomNavigationBarItem(
//                       icon: Icons.support_outlined, label: 'Support'),
//                   CustomBottomNavigationBarItem(
//                       icon: Icons.real_estate_agent_rounded,
//                       label: 'Accident'),
//                 ],
//                 currentIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final List<CustomBottomNavigationBarItem> items;
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   CustomBottomNavigationBar({
//     required this.items,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: items.map((item) {
//           var index = items.indexOf(item);
//           return GestureDetector(
//             onTap: () => onTap(index),
//             child: _CustomBottomNavigationBarItem(
//               item: item,
//               isSelected: index == currentIndex,
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class _CustomBottomNavigationBarItem extends StatelessWidget {
//   final CustomBottomNavigationBarItem item;
//   final bool isSelected;
//
//   _CustomBottomNavigationBarItem({
//     required this.item,
//     required this.isSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(item.icon, color: isSelected ? Colors.blue : Colors.grey),
//         Text(
//           item.label,
//           style: TextStyle(
//             color: isSelected ? Colors.blue : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }
// Widget bottomSheet(final Widget widget,final String string){
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       widget
//       // Image.asset("assets/images/monarch_logo.png",height: 20,color:color)
//       , Text(string,)],
//   );
// }
//
