import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/cupertino.dart";
import "package:get/get.dart";
import "package:money_budget/category/navigator/category_navigator.dart";
import "package:money_budget/history/navigator/history_navigator.dart";
import "package:money_budget/home/navigator/homenavigator.dart";
import "package:money_budget/monthly_data/navigator/monthly_data_pagenavigator.dart";
import "package:permission_handler/permission_handler.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class NavigationScreenController extends GetxController {
  final PersistentTabController _controller = PersistentTabController();

  PersistentTabController get getTabController => _controller;
  RxInt currentPage = 0.obs;
  RxBool permissionGranted = false.obs;

  void onItemSelected(int index) {
    debugPrint(currentPage.value.toString());
    if (currentPage == index) {
      switch (index) {
        case 0:
          if (HomepageNavigator.navigatorState?.currentState?.canPop() ??
              true) {
            HomepageNavigator.navigatorState!.currentState!
                .popUntil((route) => route.isFirst);
          }
          break;
        case 1:
          if (HistoryPageNavigator.navigatorState?.currentState?.canPop() ??
              true) {
            HistoryPageNavigator.navigatorState!.currentState!
                .popUntil((route) => route.isFirst);
          }
          break;

        case 2:
          if (MonthlyDataPageNavigator.navigatorState?.currentState?.canPop() ??
              true) {
            MonthlyDataPageNavigator.navigatorState!.currentState!
                .popUntil((route) => route.isFirst);
          }
          break;
        case 3:
          if (CategoryPageNavigator.navigatorState?.currentState?.canPop() ??
              true) {
            CategoryPageNavigator.navigatorState!.currentState!
                .popUntil((route) => route.isFirst);
          }
          break;

        default:
      }
    }
    currentPage.value = index;
  }

  List<Widget> screens = [
    // HomePage(),
    const HomepageNavigator(),
    const HistoryPageNavigator(),
    const MonthlyDataPageNavigator(),
    const CategoryPageNavigator(),
  ];

  // List<PersistentBottomNavBarItem> navItem = [
  //   generateItem(
  //     item: const Icon(CupertinoIcons.home),
  //     label: "Home",
  //   ),
  //   generateItem(item: const Icon(CupertinoIcons.calendar), label: "Income"),

  // ];

  @override
  Future<void> onInit() async {
    debugPrint(
      "........--------------Navi Co ----------------------------------------......",
    );

    await test();
    super.onInit();
  }

  Future<void> test() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    if (storageStatus == PermissionStatus.granted) {
      debugPrint("granted");
    }
    if (storageStatus == PermissionStatus.denied) {
      debugPrint("denied");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }
}

PersistentBottomNavBarItem generateItem({
  required Widget item,
  required String label,
}) {
  return PersistentBottomNavBarItem(
    icon: item,
    title: label,
    iconSize: 22,
    textStyle: const TextStyle(fontSize: 8),
    activeColorPrimary: Get.theme.colorScheme.secondary,
    inactiveColorPrimary: Get.theme.colorScheme.onBackground,
  );
}
