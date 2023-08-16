import "package:get/get.dart";
import "package:money_budget/monthly_data/controllers/monthly_data_controller.dart";

class MonthlyDataPageControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MonthlyDataController(),
      fenix: true,
    ); // Your want to callcontroller
  }
}
