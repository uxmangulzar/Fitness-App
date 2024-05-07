import 'package:fitness_app/utill/const.dart';
import 'package:flutter/material.dart';

class RecipeProvider with ChangeNotifier {
  String _selectedFood = foodList[0];

  String get selectedFood => _selectedFood;
  void setSelectedFood(String food) {
    _selectedFood = food;
    notifyListeners();
  }
}
