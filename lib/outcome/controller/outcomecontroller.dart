import "dart:io";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";
import "package:permission_handler/permission_handler.dart";

class OutcomeController extends GetxController {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _filenameController = TextEditingController();

  TextEditingController get getdateController => _dateController;
  TextEditingController get getcategoriesController => _categoriesController;
  TextEditingController get getmoneyController => _moneyController;
  TextEditingController get getdescriptionController => _descriptionController;
  TextEditingController get getfilenameController => _filenameController;
  final formKey = GlobalKey<FormState>();
  // List<String> categories = ["Category 1", "Category 2", "Category 3"];
  HomeController home = Get.put(HomeController());
  IncomeController income = Get.put(IncomeController());
  RxString selectedCategory = "".obs;

  Future store() async {
    if (formKey.currentState!.validate()) {
      debugPrint(
        "============== ${getcategoriesController.text}  ================",
      );
      debugPrint("============== ${getmoneyController.text}  ================");
      debugPrint("============== ${getdateController.text}  ================");
      debugPrint(
        "============== ${getdescriptionController.text}  ================",
      );
      await storeData();
    }
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> openCategorySelectionBottomSheet() async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: income.categories.map((category) {
          return ListTile(
            title: Text(category),
            onTap: () {
              setSelectedCategory(category);
              getcategoriesController.text = category;
              Navigator.pop(Get.overlayContext!); // Close the bottom sheet
            },
          );
        }).toList(),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  Future<void> storeData() async {
    if (formKey.currentState!.validate()) {
      final String money = getmoneyController.text;
      final String date = getdateController.text;
      final String description = getdescriptionController.text;
      final String category = getcategoriesController.text;
      final String filename = getfilenameController.text.isEmpty
          ? DateFormat("yyyy-MM-dd-kk-mm").format(DateTime.now())
          : getfilenameController.text;
      final double moneyAmount = double.parse(money);
      // home.increasemoney(money);
      home.addOutMoney(moneyAmount);
      // home.incomemoney(moneyAmount);

      // Get the application's document directory
      // Directory appDocumentsDirectory =
      //     await getApplicationDocumentsDirectory();
      final Directory appDocumentsDirectory =
          Directory("/storage/emulated/0/Download/Money/Outcome");
      if (!appDocumentsDirectory.existsSync()) {
        appDocumentsDirectory.createSync(recursive: true);
      }

      // Create a file inside the directory
      final File file = File("${appDocumentsDirectory.path}/$filename.txt");

      debugPrint(file.toString());

      // Write the data to the file
      await file.writeAsString(
        "Title: outcome\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: $filename",
      );

      debugPrint("Data stored in ${file.path}");
      Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
      getmoneyController.clear();
      getcategoriesController.clear();
      getdateController.clear();
      getdescriptionController.clear();
   
      Get.snackbar(
        "Success!",
        "Adding income data successfully",
        backgroundColor: Colors.green,
      );
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
