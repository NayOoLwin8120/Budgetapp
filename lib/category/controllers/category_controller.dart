import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";

class CategoryController extends GetxController {
  RxBool isincome = true.obs;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final IncomeController income = Get.put(IncomeController());
  final OutcomeController expense = Get.put(OutcomeController());

  RxList<String> incomecategories = <String>[].obs;
  RxList<String> expensecategories = <String>[].obs;
  void showincome() {
    isincome.value = true;
    incomecategories.value = income.categories;
  }

  void showexpense() {
    isincome.value = false;
    expensecategories.value = expense.outcomecategories;
  }

  Future<void> getCategoriesFromStorage() async {
    final String? storedCategories =
        await secureStorage.read(key: "categories");

    if (storedCategories != null && storedCategories.isNotEmpty) {
      incomecategories.value = storedCategories.split(",");
      debugPrint(incomecategories.toString());
    }
  }

  Future<void> getExpenseCategoriesFromStorage() async {
    final String? storedCategories = await secureStorage.read(key: "expense");

    if (storedCategories != null && storedCategories.isNotEmpty) {
      expensecategories.value = storedCategories.split(",");
      debugPrint(expensecategories.toString());
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // await income.getCategoriesFromStorage();
    // await getCategoriesFromStorage();
    await getCategoriesFromStorage();
    await getExpenseCategoriesFromStorage();
    // Call this method during initialization
    // await expense.getCategoriesFromStorage();
  }
}
