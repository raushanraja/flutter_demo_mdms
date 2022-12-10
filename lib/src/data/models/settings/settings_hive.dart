import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mdms/hive_helper/hive_types.dart';
import 'package:mdms/hive_helper/hive_adapters.dart';
import 'package:mdms/hive_helper/fields/settings_fields.dart';

part 'settings_hive.g.dart';

@HiveType(typeId: HiveTypes.settings, adapterName: HiveAdapters.settings)
class Settings extends HiveObject {
  @HiveField(SettingsFields.themeMode)
  String themeMode;
  @HiveField(SettingsFields.locale)
  String locale;

  Settings({
    this.themeMode = 'system',
    this.locale = 'hi',
  });

  // Convert string to ThemeMode
  ThemeMode get themeModeEnum {
    switch (themeMode) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Convert string to Locale
  Locale get localeEnum {
    switch (locale) {
      case 'hi':
        return const Locale('hi', '');
      case 'en':
        return const Locale('en', '');
      default:
        return Locale(locale, '');
    }
  }
}
