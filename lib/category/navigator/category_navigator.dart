import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller_bindings.dart";
import "package:money_budget/category/views/category_page.dart";
import "package:money_budget/z_application/generalrouting.dart";

class CategoryPageNavigator extends StatelessWidget {
  const CategoryPageNavigator({super.key});
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
            page: () => const CategoryPage(), // Your page
            settings: setting,
            bindings: [CategoryControllerBindings()], //Your controller Bindings
          );
        }
        return generalRouting(setting); //Your general Routing
      },
    );
  }
}
