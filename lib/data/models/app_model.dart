class AppModel {

  bool isNightMode;
  AppModel({required this.isNightMode});

  AppModel.fromJson(Map<String, dynamic> json)
    : isNightMode = json["isNightMode"] as bool;

  Map<String, dynamic> toJson() => {
    "isNightMode": isNightMode,
  };

}