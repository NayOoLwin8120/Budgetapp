import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller.dart";
import "package:money_budget/history/controllers/history_controller.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";

class HistoryControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(
        () => HistoryController(),
        fenix: true,
      )
      ..lazyPut(
        () => HomeController(),
        fenix: true,
      );
    // Your want to callcontroller
    // Your want to callcontroller
  }
}
