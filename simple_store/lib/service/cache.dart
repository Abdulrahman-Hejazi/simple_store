import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class DataSaver{
  static var _prefs ;

  static Future dataSaverIni() async {
    _prefs =  await SharedPreferences.getInstance();
    return true;
  }

  static void saveData(data,String key) async{
    _prefs ??= await SharedPreferences.getInstance();
    data = jsonEncode(data);
    _prefs.setString(key, data);
  }
  static void deleteData (String key) async{
    _prefs ??= await SharedPreferences.getInstance();
    _prefs.remove(key);
  }

  static getData(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    dynamic result = _prefs.getString(key);
    if (result == null){
      return null;
    }
    result = jsonDecode(result);
    return result;
  }
}