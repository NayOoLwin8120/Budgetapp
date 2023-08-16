import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/home/controllers/homecontrollerbindings.dart";
import "package:money_budget/home/views/homepage.dart";
import "package:money_budget/z_application/generalrouting.dart";

class HomepageNavigator extends StatelessWidget {
  const HomepageNavigator({super.key});
  static int navigationKey = 0;
  static GlobalKey<NavigatorState>? navigatorState =
      Get.nestedKey(navigationKey);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (setting) {
        if (setting.name == "/") {
          return GetPageRoute(
            page: () => Homepage(), // Your page
            settings: setting,
            bindings: [HomepageControllerBindings()], //Your controller Bindings
          );
        }
        return generalRouting(setting); //Your general Routing
      },
    );
  }
}
