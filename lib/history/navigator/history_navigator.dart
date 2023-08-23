import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller_bindings.dart";
import "package:money_budget/category/views/category_page.dart";
import "package:money_budget/history/controllers/history_controller_bindings.dart";
import "package:money_budget/history/views/history_view.dart";
import "package:money_budget/z_application/generalrouting.dart";

class HistoryPageNavigator extends StatelessWidget {
  const HistoryPageNavigator({super.key});
  static int navigationKey = 1;
  static GlobalKey<NavigatorState>? navigatorState =
      Get.nestedKey(navigationKey);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (setting) {
        if (setting.name == "/") {
          return GetPageRoute(
            page: () => HistoryPage(), // Your page
            settings: setting,
            bindings: [HistoryControllerBindings()], //Your controller Bindings
          );
        }
        return generalRouting(setting); //Your general Routing
      },
    );
  }
}
