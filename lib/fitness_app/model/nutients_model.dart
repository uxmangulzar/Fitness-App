class NutrientModel {
  Nutrients? nutrients;

  NutrientModel({this.nutrients});

  NutrientModel.fromJson(Map<String, dynamic> json) {
    nutrients = json['nutrients'] != null
        ? Nutrients.fromJson(json['nutrients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nutrients != null) {
      data['nutrients'] = nutrients!.toJson();
    }
    return data;
  }
}

class Nutrients {
   // ignore: prefer_typing_uninitialized_variables
   var protein;
   var carbohydrates;
   var fiber;
   var sugar;
   var fat;
   var saturatedFat;
   var polyunsaturatedFat;
   var monosaturatedFat;
   var cholesterol;
   var sodium;
   var potassium;
   var vitaminA;
   var vitaminC;
   var calcium;
   var iron;

  Nutrients(
      {this.protein,
        this.carbohydrates,
        this.fiber,
        this.sugar,
        this.fat,
        this.saturatedFat,
        this.polyunsaturatedFat,
        this.monosaturatedFat,
        this.cholesterol,
        this.sodium,
        this.potassium,
        this.vitaminA,
        this.vitaminC,
        this.calcium,
        this.iron});

  Nutrients.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    carbohydrates = json['carbohydrates'];
    fiber = json['fiber'];
    sugar = json['sugar'];
    fat = json['fat'];
    saturatedFat = json['saturated_fat'];
    polyunsaturatedFat = json['polyunsaturated_fat'];
    monosaturatedFat = json['monosaturated_fat'];
    cholesterol = json['cholesterol'];
    sodium = json['sodium'];
    potassium = json['potassium'];
    vitaminA = json['vitamin_a'];
    vitaminC = json['vitamin_c'];
    calcium = json['calcium'];
    iron = json['iron'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['protein'] = protein;
    data['carbohydrates'] = carbohydrates;
    data['fiber'] = fiber;
    data['sugar'] = sugar;
    data['fat'] = fat;
    data['saturated_fat'] = saturatedFat;
    data['polyunsaturated_fat'] = polyunsaturatedFat;
    data['monosaturated_fat'] = monosaturatedFat;
    data['cholesterol'] = cholesterol;
    data['sodium'] = sodium;
    data['potassium'] = potassium;
    data['vitamin_a'] = vitaminA;
    data['vitamin_c'] = vitaminC;
    data['calcium'] = calcium;
    data['iron'] = iron;
    return data;
  }
}
