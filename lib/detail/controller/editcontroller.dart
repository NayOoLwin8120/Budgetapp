import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/util/text_filed.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";
import "package:permission_handler/permission_handler.dart";

class EditController extends GetxController {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _filenameController = TextEditingController();
  final TextEditingController _addcategoryController = TextEditingController();

  TextEditingController get getdateController => _dateController;
  TextEditingController get getcategoriesController => _categoriesController;
  TextEditingController get getmoneyController => _moneyController;
  TextEditingController get getdescriptionController => _descriptionController;
  TextEditingController get getfilenameController => _filenameController;
  TextEditingController get getaddcategoryController => _addcategoryController;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // မင္းအျကာင္းအိမ္မက္

  final formKey = GlobalKey<FormState>();
  List<String> categories = ["Category 1", "Category 2", "Category 3"].obs;
  RxString selectedCategory = "".obs;
  HomeController home = Get.put(HomeController());

  RxString moneyedit = "".obs; // Replace with your category list
  RxString dateedit = "".obs; // Replace with your category list
  RxString categoryedit = "".obs; // Replace with your category list
  RxString descriptionedit = "".obs; // Replace with your category list
  // Replace with your category list
  Future store() async {
    if (formKey.currentState!.validate()) {
      debugPrint(
        "============== ${getcategoriesController.text}  ================",
      );
      debugPrint(
        "============== ${getmoneyController.text}  ================",
      );
      debugPrint(
        "============== ${getdateController.text}  ================",
      );
      debugPrint(
        "============== ${getdescriptionController.text}  ================",
      );
      debugPrint(
        "============== ${getfilenameController.text}  ================",
      );
      await storeData();
      await home.readIncomeFromFilesAndAddToMoneyList();
      await home.readFileContent(
        "/storage/emulated/0/Download/Money/Outcome/${getfilenameController.text}.txt",
      );
    }
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> openCategorySelectionBottomSheet() async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: categories.map((category) {
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

  // Future<void> storeData() async {
  //   if (formKey.currentState!.validate()) {
  //     final String money = getmoneyController.text;
  //     final String date = getdateController.text;
  //     final String category = getcategoriesController.text;
  //     final String description = getdescriptionController.text;
  //     final String filename = getfilenameController.text;
  //     moneyedit.value = money;
  //     dateedit.value = date;
  //     categoryedit.value = category;
  //     descriptionedit.value = description;

  //     final double moneyAmount = double.parse(money);

  //     // home.addMoney(moneyAmount);

  //     // Directory appDocumentsDirectory =
  //     //     await getApplicationDocumentsDirectory();
  //     final Directory appDocumentsDirectory =
  //         Directory("/storage/emulated/0/Download/Money/Outcome");

  //     if (!appDocumentsDirectory.existsSync()) {
  //       appDocumentsDirectory.createSync(recursive: true);
  //     }

  //     // Create a file inside the directory
  //     final File file = File("${appDocumentsDirectory.path}/$filename.txt");
  //     home.addMoney(moneyAmount);

  //     // Write the data to the file
  //     await file.writeAsString(
  //       "Title: ${home.title}\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: $filename",
  //     );

  //     debugPrint("Data stored in ${file.path}");
  //     Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
  //     getmoneyController.clear();
  //     getcategoriesController.clear();
  //     getdateController.clear();
  //     getdescriptionController.clear();
  //     getfilenameController.clear();
  //     Get.snackbar(
  //       "Success!",
  //       "Update Data successfully",
  //       backgroundColor: Colors.green,
  //     );
  //   }
  // }

  Future<void> storeData() async {
    if (formKey.currentState!.validate()) {
      final String money = getmoneyController.text;
      final String date = getdateController.text;
      final String category = getcategoriesController.text;
      final String description = getdescriptionController.text;
      final String filename = getfilenameController.text;

      moneyedit.value = money;
      dateedit.value = date;
      categoryedit.value = category;
      descriptionedit.value = description;

      final double moneyAmount = double.parse(money);
      final Directory appDocumentsDirectory =
          Directory("/storage/emulated/0/Download/Money/Outcome");

      if (!appDocumentsDirectory.existsSync()) {
        appDocumentsDirectory.createSync(recursive: true);
      }

      // Open the existing file using the original file name
      // final File file = File("${appDocumentsDirectory.path}/$filename.txt");
      // if (file.existsSync()) {
      //   debugPrint("=== file is already exists ====");
      //   file.deleteSync();
      // }
      // // Write the updated data to the file, overwriting its content
      // await file.writeAsString(
      //   "Title: ${home.title}\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: $filename",
      // );

      // final String originalFilePath =
      //     "${appDocumentsDirectory.path}/${home.filename.value}.txt";

      // debugPrint("Data original file path : $originalFilePath");

      // Create a new file with the updated file name

      // Create a new file with the updated file name
      final File newFile =
          File("${appDocumentsDirectory.path}/${home.filename}.txt");
      home.addMoney(moneyAmount);
      // Write the content to the new file with the updated file name
      await newFile.writeAsString(
        "Title: ${home.title}\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: ${home.filename}",
      );
      // Delete the original file

      debugPrint("Data updated in ${newFile.path}");
      Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
      getmoneyController.clear();
      getcategoriesController.clear();
      getdateController.clear();
      getdescriptionController.clear();
      getfilenameController.clear();
      Get.snackbar(
        "Success!",
        "Update Data successfully",
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

  // void addingcategory() {
  //   String newCategory = getaddcategoryController.text.toString();

  //   categories.add(newCategory);

  //   debugPrint(categories);
  //   debugPrint(newCategory);
  //   // Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
  //   Get.back();
  // }

  Future<void> addcategory() async {
    await Get.bottomSheet(
      Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Adding Category",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AuthTextField(
                  // filledColor: const Color(0xff0A4D68),
                  filledColor: Colors.cyan,
                  textColor: const Color(0xffFFFFFF),
                  isNormal: true,
                  hintText: "Category",
                  controller: getaddcategoryController,
                  // validator: ReuseableFunction.validateString,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "Need To Fill This Field";
                    }
                    return null;
                  },
                ),
                OutlinedButton(
                  onPressed: () async {
                    await addingCategory();
                  },
                  child: const Text("Add Category"),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              await deleteCategoriesFromStorage();
              Get.back();
            },
            child: const Text("Close"),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> addingCategory() async {
    final String newCategory = getaddcategoryController.text.toString();
    debugPrint(newCategory);
    categories.add(newCategory);

    await secureStorage.write(key: "categories", value: categories.join(","));
    await getCategoriesFromStorage();

    Get.back();
  }

  Future<void> getCategoriesFromStorage() async {
    final String? storedCategories =
        await secureStorage.read(key: "categories");

    if (storedCategories != null && storedCategories.isNotEmpty) {
      categories = storedCategories.split(",");
      debugPrint(categories.toString());
    }
  }

  Future<void> deleteCategoriesFromStorage() async {
    await secureStorage.delete(key: "categories");
  }

  Future<void> deleteFileAndRefreshUI(
    String filePath,
  ) async {
    await home.deleteFileAndRefreshUI(filePath);
    Get
      ..back(id: Get.find<NavigationScreenController>().currentPage.value)
      ..snackbar(
        "Sucess",
        "Delete Data Successfully !",
        backgroundColor: Colors.red,
      );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategoriesFromStorage(); // Call this method during initialization
  }
}
