import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        // Wrap the DropdownButton in a column so that it is centered.

        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Dropdown for theme selector
          DropdownButton<ThemeMode>(
            value: controller.themeMode,
            onChanged: (ThemeMode? value) {
              if (value != null) {
                controller.updateThemeMode(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Default'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark'),
              ),
            ],
          ),

          // Dropdown for language selector
          DropdownButton<Locale>(
            value: controller.locale,
            onChanged: (Locale? value) {
              if (value != null) {
                controller.updateLocale(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en', ''),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('hi', ''),
                child: Text('Hindi'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
