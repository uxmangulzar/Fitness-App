class TrainingModel {
  String? id;
  String? title;
  String? day;
  String? startTime;
  String? endTime;
  String? duration;
  String? calories;

  TrainingModel(
      {this.id,
      this.title,
      this.day,
      this.startTime,
      this.endTime,
      this.duration,
      this.calories});

  TrainingModel.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    title = json['title'] ?? '';
    day = json['day'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    duration = json['duration'] ?? '';
    calories = json['calories'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['day'] = day;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['duration'] = duration;
    data['calories'] = calories;
    return data;
  }
}
