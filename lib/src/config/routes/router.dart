import 'package:fluro/fluro.dart';
import 'package:mdms/src/config/routes/routes_handler.dart';

// Create a main router with FlutoRouter
class MainRouter {
  static final FluroRouter router = FluroRouter();

  // Create a static setupRouter method
  static void setupRouter() {
    // Define a route for the home page
    router.define('home', handler: RouterHandlers.homeHandler);
    router.define('settings', handler: RouterHandlers.settingsHandler);
    router.define('mdm/:title/:classType', handler: RouterHandlers.mdmHanlder);
    // router.define('mdm/:class', handler: RouterHandlers.homeHandler);
  }
}
