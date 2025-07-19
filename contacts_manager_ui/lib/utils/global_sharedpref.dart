import 'package:shared_preferences/shared_preferences.dart';

class GlobalSharedpref {
  static String globalBaseUrl = "";

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    globalBaseUrl = prefs.getString('baseApiAddress') ?? '';
  }
}