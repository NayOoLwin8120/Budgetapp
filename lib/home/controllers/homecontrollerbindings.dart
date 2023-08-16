import "package:get/get.dart";
import "package:money_budget/detail/controller/editcontroller.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";

class HomepageControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(
        () => HomeController(),
        fenix: true,
      )
      ..lazyPut(
        () => IncomeController(),
        fenix: true,
      ) // Your want to callcontroller
      // Your want to callcontroller
      ..lazyPut(
        () => OutcomeController(),
        fenix: true,
      )
      ..lazyPut(
        () => EditController(),
        fenix: true,
      ); // Your want to callcontroller
    // Your want to callcontroller
  }
}
