class TrainingTitleModel {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainingTitleModel &&
        other.id == id &&
        other.title == title &&
        other.calories == calories;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ calories.hashCode;

  String? id;
  String? title;
  String? calories;

  TrainingTitleModel({this.id, this.title, this.calories});

  TrainingTitleModel.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    title = json['title'] ?? '';
    calories = json['calories'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['calories'] = calories;
    return data;
  }
}
