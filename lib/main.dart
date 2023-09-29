import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdms/src/config/routes/router.dart';
import 'package:mdms/src/data/models/chart/items.dart';
import 'package:mdms/src/data/models/chart/weekly_item.dart';

import 'src/app.dart';
import 'package:path_provider/path_provider.dart';
import 'src/data/models/settings/settings_hive.dart';

import 'src/data/services/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  // Initialize Hive
  await Hive.initFlutter(document.path);

  // Register the SettingsAdapter
  Hive.registerAdapter(SettingsAdapter());

  // Register the ItemsAdapter
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(ItemsAdapter());

  // Register the WeeklyItemsAdapter
  Hive.registerAdapter(WeeklyItemAdapter());
  Hive.registerAdapter(WeeklyItemsAdapter());

  await Hive.openBox('settings');
  await Hive.openBox('items');
  await Hive.openBox('weekitems');

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  MainRouter.setupRouter();
  runApp(MyApp(settingsController: settingsController));
}
