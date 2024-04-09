import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:intl/intl.dart';

class StringUtil {

  static bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool validateComplexPassword(String password) {
    if(password.length >= 6) {
      return true;
    }

    return false;
  }

  static String getFormatDateTime(DateTime dateTime) {
    final datetimeFormat = DateFormat(AppVariable.DATE_FORMAT, "en_US");
    return datetimeFormat.format(dateTime);
  }

}