import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/fitness_app/view/calories_tabs/addFoodTest.dart';

final fireStore = FirebaseFirestore.instance;
final userId = auth.currentUser!.uid;

enum BottomBarEnum { today, recipe, blog, training, aichat }

enum BlogBottomBarEnum { share, comment, like }

const List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const List<String> foodList = [
  'Snack',
  'Dessert',
  'Dinner',
  'Lunch',
  'Breakfast'
];

const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

//GENERATE A LIST OF YEARS STARTING FROM 1951 TO CURRENT YEAR
List<String> years = List.generate(
  DateTime.now().year - 1950, // Current year - 1950
  (index) => (1951 + index).toString(),
).reversed.toList();
