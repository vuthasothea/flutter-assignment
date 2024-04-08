import 'dart:convert';

import 'package:final_project_with_firebase/data/models/app_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepository {

  Future<AppModel> getAppSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("AppSetting") == null) {
      final model = AppModel(isNightMode: false);
      setAppSetting(model);
      return model;
    } else {
      final rawJson = prefs.getString("AppSetting")!;
      final map = jsonDecode(rawJson) as Map<String, dynamic>;
      return AppModel.fromJson(map);
    }
  }

  Future<void> setAppSetting(AppModel appModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(appModel.toJson());
    prefs.setString("AppSetting", json);
  }

}