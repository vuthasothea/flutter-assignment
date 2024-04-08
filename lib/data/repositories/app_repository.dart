import 'package:final_project_with_firebase/data/models/app_model.dart';

class AppRepository {

  Future<AppModel> getAppSetting() async {
    return AppModel(isNightMode: true);
  }

}