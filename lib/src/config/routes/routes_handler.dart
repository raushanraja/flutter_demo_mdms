import 'package:fluro/fluro.dart';
import 'package:mdms/src/home_buttons/home_buttons.dart';
import 'package:mdms/src/mdm/mdm.dart';

// Import SettingsView
import 'package:mdms/src/settings/settings_view.dart';

class RouterHandlers {
  static Handler homeHandler = Handler(
    handlerFunc: (context, params) {
      return const HomeButtons();
    },
  );

  static Handler mdmHanlder = Handler(
    handlerFunc: (context, params) {
      return MDM(
          title: params['title']![0], classType: params['classType']![0]);
    },
  );

  static Handler settingsHandler = Handler(
    handlerFunc: (context, params) {
      return SettingsView();
    },
  );
}
