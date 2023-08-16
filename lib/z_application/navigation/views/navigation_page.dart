import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class NavigationScreen extends GetView<NavigationScreenController> {
  // static const String name = "/";

  const NavigationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 60,
        onTap: controller.onItemSelected,
        // inactiveColor: Get.theme.colorScheme.onSurface,
        inactiveColor: Colors.black,
        activeColor: Colors.white,
        backgroundColor: Get.theme.colorScheme.primary,
        iconSize: 25,
        // onTap: controller.onItemSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on),
            label: "Monthly".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category_rounded),
            label: "Category".tr,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return Stack(
          children: [
            controller.screens[index],
          ],
        );
      },
    );
  }
}
