class ProfileModel {
  String? profilePicUrl;
  String? gender;
  String? username;
  String? height;
  String? weight;
  String? month;
  String? year;
  String? day;
  String? activity;
  String? currentWeight;
  String? goalWeight;

  ProfileModel(
      {this.profilePicUrl,
      this.gender,
      this.username,
      this.height,
      this.weight,
      this.month,
      this.year,
      this.day,
      this.currentWeight,
      this.goalWeight,
      this.activity});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profilePicUrl = json['profilePicUrl'] ?? '';
    gender = json['gender'] ?? '';
    username = json['username'] ?? '';
    height = json['height'] ?? '';
    weight = json['weight'] ?? '';
    month = json['month'] ?? '';
    year = json['year'] ?? '';
    day = json['day'] ?? '';
    currentWeight = json['currentWeight'] ?? '';
    goalWeight = json['goalWeight'] ?? '';
    activity = json['activity'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['username'] = username;
    data['height'] = height;
    data['weight'] = weight;
    data['currentWeight'] = currentWeight;
    data['goalWeight'] = goalWeight;
    data['activity'] = activity;
    return data;
  }

  Map<String, dynamic> ageToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['year'] = year;
    data['day'] = day;
    return data;
  }
}
