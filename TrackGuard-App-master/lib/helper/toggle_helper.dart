import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleProvider extends ChangeNotifier {
  bool _isBasePhone = true;

  bool get isBasePhone => _isBasePhone;

  void setToggle(bool newValue) {
    _isBasePhone = newValue;
    notifyListeners(); // Notify listeners after updating the toggle state

    // Save the toggle value to SharedPreferences
    saveToggleToPrefs(newValue);
  }

  // Load toggle value from SharedPreferences
  Future<void> loadToggleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isBasePhone = prefs.getBool('isBasePhone') ?? true;
    notifyListeners(); // Notify listeners after loading the toggle value
  }

  // Save toggle value to SharedPreferences
  Future<void> saveToggleToPrefs(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBasePhone', newValue);
  }

  // Reset toggle value and update SharedPreferences
  Future<void> resetToggle() async {
    _isBasePhone = true;
    notifyListeners(); // Notify listeners after resetting the toggle value
    await saveToggleToPrefs(true); // Update SharedPreferences
  }
}
