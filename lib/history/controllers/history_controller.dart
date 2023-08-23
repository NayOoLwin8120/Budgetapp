import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:money_budget/home/controllers/homecontroller.dart";

class HistoryController extends GetxController {
  RxList<String> months = <String>[].obs;
  HomeController home = HomeController();
  @override
  void onInit() {
    month();

    super.onInit();
  }

  void month() {
    final now = DateTime.now();
    final monthFormat = DateFormat.MMM();

    // Add last 2 months
    for (int i = 2; i >= 1; i--) {
      final lastMonth = DateTime(now.year, now.month - i);
      months.add(monthFormat.format(lastMonth));
    }

    // Add current month
    months.add(monthFormat.format(now));

    // Add next 2 months
    for (int i = 1; i <= 2; i++) {
      final nextMonth = DateTime(now.year, now.month + i);
      months.add(monthFormat.format(nextMonth));
    }
  }
}
