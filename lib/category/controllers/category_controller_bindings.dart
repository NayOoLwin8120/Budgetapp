import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller.dart";

class CategoryControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CategoryController(),
      fenix: true,
    ); // Your want to callcontroller
  }
}
