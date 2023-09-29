import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:mdms/src/data/models/settings/settings_hive.dart';

final settingBox = Hive.box('settings');

// Create SettingsController to glue user settings to multiple Flutter Widgets.
class SettingsController extends ChangeNotifier {
  Settings _settings = Settings();

  // Load the user's preferred theme whe splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  Future<void> loadSettings() async {
    Settings loadedSettings =
        settingBox.get('custom', defaultValue: _settings);
    if (_settings != loadedSettings) {
      _settings = loadedSettings;
      notifyListeners();
    }
  }

  // Getters
  ThemeMode get themeMode => _settings.themeModeEnum;
  Locale get locale => _settings.localeEnum;

  // Update and persist the Settings
  Future<void> updateSettings(Settings newSettings) async {
    if (newSettings == _settings) return;
    _settings = newSettings;
    notifyListeners();
    await settingBox.put('custom', newSettings);
  }

  // Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _settings.themeModeEnum) return;
    _settings.themeMode = newThemeMode.name;
    notifyListeners();
    await settingBox.put('custom', _settings);
  }

  // Update and persist the Locale based on the user's selection.
  Future<void> updateLocale(Locale? newLocale) async {
    if (newLocale == null) return;
    if (newLocale == _settings.localeEnum) return;
    _settings.locale = newLocale.languageCode;
    notifyListeners();
    await settingBox.put('custom', _settings);
  }
}
