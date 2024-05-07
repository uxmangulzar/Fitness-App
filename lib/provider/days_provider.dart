import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';

class DaysProvider with ChangeNotifier {
  String _selectedDay = days[0];

  String get selectedDay => _selectedDay;

  void setSelectedDay(String day) {
    _selectedDay = day;
    notifyListeners();
  }
}
