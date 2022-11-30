import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  Future<SharedPreferences> getSharedPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setOnboardingShown() async {
    final prefs = await getSharedPreferencesInstance();
    await prefs.setBool('isOnboardingShown', true);
  }

  Future<bool> isOnboardingShown() async {
    final prefs = await getSharedPreferencesInstance();
    return prefs.getBool('isOnboardingShown') ?? false;
  }
}
