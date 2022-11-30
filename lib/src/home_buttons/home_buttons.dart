import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdms/src/MDM/mdm_input_view.dart';

import '../MDM/mdm_inputs.dart';
import '../settings/settings_view.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a scaffold
    return Scaffold(
      // Create an app bar
      appBar: AppBar(
        // Use the AppLocalizations to retrieve the correct localized title
        title: Text(AppLocalizations.of(context)!.appTitle),
        // Create action button
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // Create a body reffering to Buttons Class
      // pass the context to Buttons Class
      body: Buttons(context),
    );
  }
}

// create a class Buttons
// pass the context to Buttons Class
class Buttons extends StatelessWidget {
  final BuildContext context;
  const Buttons(this.context);

  @override
  Widget build(BuildContext context) {
    // Create a column

    return Container(
      // Add padding on x axis
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Add padding on y axis
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              minimumSize: const Size.fromHeight(60), // NEW
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, MDMForm.routeName,
                  arguments: MDMRouteInfo(
                          title: AppLocalizations.of(context)!.class_i_title,
                          class_type: 'class_i')
                      .toMap());
            },
            child: Text(AppLocalizations.of(context)!.class_i_title,
                style: const TextStyle(fontSize: 25, color: Colors.white)),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              minimumSize: const Size.fromHeight(60), // NEW
            ),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
            child: Text(AppLocalizations.of(context)!.class_ii_title,
                style: const TextStyle(fontSize: 25, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
