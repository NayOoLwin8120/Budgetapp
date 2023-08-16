import "package:get/get.dart";
import "package:money_budget/detail/controller/editcontroller.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/monthly_data/controllers/monthly_data_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => NavigationScreenController(), fenix: true)
      ..lazyPut(() => HomeController(), fenix: true)
      ..lazyPut(() => IncomeController(), fenix: true)
      ..lazyPut(() => OutcomeController(), fenix: true)
      ..lazyPut(() => EditController(), fenix: true)
      ..lazyPut(() => MonthlyDataController(), fenix: true);
    // Your want to callcontroller
  }
}
