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
        border: Border.all(color: Colors.transparent),
        height: 60,
        onTap: controller.onItemSelected,
        // inactiveColor: Get.theme.colorScheme.onSurface,
        inactiveColor: const Color(0xff6633CC).withOpacity(0.5),
        activeColor: const Color(0xff6633CC),
        backgroundColor: const Color(0xffEEEEEE),
        iconSize: 25,
        // onTap: controller.onItemSelected,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: "History".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.monetization_on),
            label: "Monthly".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: "Profile".tr,
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
