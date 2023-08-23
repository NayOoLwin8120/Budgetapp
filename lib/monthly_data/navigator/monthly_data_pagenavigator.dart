import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/monthly_data/controllers/monthlydatacontrollerbindings.dart";
import "package:money_budget/monthly_data/views/monthly_data_page.dart";
import "package:money_budget/z_application/generalrouting.dart";

class MonthlyDataPageNavigator extends StatelessWidget {
  const MonthlyDataPageNavigator({super.key});
  static int navigationKey = 2;
  static GlobalKey<NavigatorState>? navigatorState =
      Get.nestedKey(navigationKey);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (setting) {
        if (setting.name == "/") {
          return GetPageRoute(
            page: () => Monthlydatapage(), // Your page
            settings: setting,
            bindings: [
              MonthlyDataPageControllerBindings(),
            ], //Your controller Bindings
          );
        }
        return generalRouting(setting); //Your general Routing
      },
    );
  }
}
