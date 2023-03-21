import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/presentation/resources/language_manager.dart';

const String prefsKeyLanguage = 'PREFS_KEY_LANG';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLanguage);

    if (language != null && language.isNotEmpty) {
      return language;
    }
    else {
      return LanguageType.english.getValue();
    }
  }
}