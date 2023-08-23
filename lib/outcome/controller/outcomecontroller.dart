import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:money_budget/componements/image.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/history/views/history_view.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/util/text_filed.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";
import "package:permission_handler/permission_handler.dart";

class OutcomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  List<String> outcomecategories = ["expense1"].obs;
  HomeController home = Get.put(HomeController());
  IncomeController income = Get.put(IncomeController());
  RxString selectedCategory = "".obs;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString image = "".obs;
  bool isImageSelected = false;
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

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategoriesFromStorage(); // Call this method during initialization
  }

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
      SingleChildScrollView(
        child: Container(
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < outcomecategories.length; i += 3)
                      Row(
                        children: [
                          for (int j = i;
                              j < i + 3 && j < outcomecategories.length;
                              j++)
                            GestureDetector(
                              onTap: () {
                                setSelectedCategory(outcomecategories[j]);
                                getcategoriesController.text =
                                    outcomecategories[j];
                                Get.back(); // Close the bottom sheet
                              },
                              child: Container(
                                width: Get.width / 2.8 - 32,
                                height: 80, // Set the desired height
                                margin: const EdgeInsets.all(5.0),
                                alignment: Alignment.center,

                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  outcomecategories[j],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
          ? DateFormat("yyyy-MM-dd-kk-mm-ss").format(DateTime.now())
          : getfilenameController.text;
      final double moneyAmount = double.parse(money);
      home.addOutMoney(moneyAmount);
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
        "Title: outcome\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: $filename\nImagepath: $image",
      );

      debugPrint("Data stored in ${file.path}");
      // Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
      await Get.toNamed(
        HistoryPage.name,
        id: Get.find<NavigationScreenController>().currentPage.value,
      );
      getmoneyController.clear();
      getcategoriesController.clear();
      getdateController.clear();
      getdescriptionController.clear();
      selectedImage.value = null;

      Get.snackbar(
        "Success!",
        "Adding outcome data successfully",
        backgroundColor: Colors.green,
      );
    }
  }

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
                    if (data == null || data.isEmpty) {
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
    if (getaddcategoryController.text.isEmpty) {
      // Show an error message if the input is empty
      Get.snackbar(
        "Error",
        "Please enter a category.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // Exit the function if input is empty
    }

    final String newCategory = getaddcategoryController.text.toString();
    debugPrint(newCategory);
    final storedCategories = await secureStorage.read(key: "expense");
    if (storedCategories != null) {
      final List<String> existingCategories = storedCategories.split(",");
      if (existingCategories.contains(newCategory)) {
        // Category already exists, show an error message
        Get.snackbar(
          "Error",
          "Category already exists.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return; // Exit the function if category exists
      }
    }
    outcomecategories.add(newCategory);

    await secureStorage.write(
      key: "expense",
      value: outcomecategories.join(","),
    );
    await getCategoriesFromStorage();
    getaddcategoryController.clear();
    // update();

    Get.back();
  }

  Future<void> getCategoriesFromStorage() async {
    final String? storedCategories = await secureStorage.read(key: "expense");

    if (storedCategories != null && storedCategories.isNotEmpty) {
      outcomecategories = storedCategories.split(",");
      debugPrint(outcomecategories.toString());
    }
  }

  Future<void> deleteCategoriesFromStorage() async {
    await secureStorage.delete(key: "expense");
    await getCategoriesFromStorage();
  }

  /// For Image Section
  Future<void> showImagePickerDialog() async {
    await showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Select Image From",
              style: TextStyle(
                color: Color(0xff0A4D68),
              ),
            ),
          ),
          content: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowImage(Assets.icons.camera.path, "Camera", () {
                  pickImage(ImageSource.camera);
                }),
                ShowImage(Assets.icons.gallery.path, "Photo Gallery", () {
                  pickImage(ImageSource.gallery);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final PermissionStatus permissionStatus = await requestpermission();

    if (permissionStatus == PermissionStatus.denied) {
      await showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text(
              "Please grant permission to access the camera or gallery.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    final pickedFile = await picker.pickImage(source: source);

    debugPrint(pickedFile.toString());
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      final String filePathWithPrefix = selectedImage.value.toString();

      image.value =
          filePathWithPrefix.substring(7, filePathWithPrefix.length - 1);

      debugPrint(selectedImage.value.toString());
      debugPrint(image.value);
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  Future<PermissionStatus> requestpermission() async {
    final PermissionStatus permissionStatus = await Permission.camera.request();

    if (permissionStatus.isGranted) {
      // Permission granted, proceed with accessing the camera.
      // You can call the method to open the camera here.
    } else if (permissionStatus.isDenied) {
      // Permission denied. Show an error message or handle it as needed.
      debugPrint("Camera permission denied");
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied. Show a dialog or navigate to app settings.
      debugPrint("Camera permission permanently denied");
    }

    return permissionStatus;
  }
}
