import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:money_budget/componements/image.dart";
import "package:money_budget/detail/view/image_viewer.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";
import "package:permission_handler/permission_handler.dart";

class EditController extends GetxController {
  final picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString image = "".obs;
  RxString path = "".obs;
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
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final IncomeController incomecontroller = Get.put(IncomeController());
  final OutcomeController outcomeontroller = Get.put(OutcomeController());

  final formKey = GlobalKey<FormState>();
  // List<String> categories = ["Category 1", "Category 2", "Category 3"].obs;
  RxString selectedCategory = "".obs;
  HomeController home = Get.put(HomeController());

  RxString moneyedit = "".obs; // Replace with your category list
  RxString dateedit = "".obs; // Replace with your category list
  RxString categoryedit = "".obs; // Replace with your category list
  RxString descriptionedit = "".obs;

  // Replace with your category list
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
        "============== ${image.value}  ================",
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

  // Future<void> openCategorySelectionBottomSheet() async {
  //   List<String> filteredCategories = [];

  //   if (home.title == "income") {
  //     // Show income categories
  //     filteredCategories = incomecontroller.categories;
  //   } else if (home.title == "outcome") {
  //     // Show outcome categories
  //     filteredCategories = outcomeontroller.outcomecategories;
  //   }

  //   await Get.bottomSheet(
  //     Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: filteredCategories.map((category) {
  //         return ListTile(
  //           title: Text(category),
  //           onTap: () {
  //             setSelectedCategory(category);
  //             getcategoriesController.text = category;
  //             Navigator.pop(Get.overlayContext!); // Close the bottom sheet
  //           },
  //         );
  //       }).toList(),
  //     ),
  //     backgroundColor: Colors.white,
  //     isScrollControlled: true,
  //   );
  // }

  Future<void> openCategorySelectionBottomSheet() async {
    final List<String> filteredCategories = [];

    if (home.title == "income") {
      // Show income categories
      filteredCategories.addAll(incomecontroller.categories);
      debugPrint("=====  Filtered Categories $filteredCategories  =======");
      debugPrint(
        "=====  Filtered Categories ${filteredCategories.length} =======", //6
      );
    } else if (home.title == "outcome") {
      // Show outcome categories
      filteredCategories.addAll(outcomeontroller.outcomecategories);
      debugPrint("=====  Filtered Categories $filteredCategories  =======");
      debugPrint(
        "=====  Filtered Categories ${filteredCategories.length} =======", //6
      );
    }

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
                    for (int i = 0; i < filteredCategories.length; i += 3)
                      Row(
                        children: [
                          for (int j = i;
                              j < i + 3 && j < filteredCategories.length;
                              j++)
                            GestureDetector(
                              onTap: () {
                                setSelectedCategory(filteredCategories[j]);
                                getcategoriesController.text =
                                    filteredCategories[j];
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
                                  filteredCategories[j],
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
      final String category = getcategoriesController.text;
      final String description = getdescriptionController.text;
      final String filename = getfilenameController.text;

      moneyedit.value = money;
      dateedit.value = date;
      categoryedit.value = category;
      descriptionedit.value = description;
      home.image.value = selectedImage.value;
      home.imagepath.value = image.value;

      final double moneyAmount = double.parse(money);
      final Directory appDocumentsDirectory =
          Directory("/storage/emulated/0/Download/Money/Outcome");

      if (!appDocumentsDirectory.existsSync()) {
        appDocumentsDirectory.createSync(recursive: true);
      }

      // Create a new file with the updated file name
      final File newFile =
          File("${appDocumentsDirectory.path}/${home.filename}.txt");
      home.addMoney(moneyAmount);
      // Write the content to the new file with the updated file name
      await newFile.writeAsString(
        "Title: ${home.title}\nMoney: $money\nCategory: $category\nDate: $date\nDescription: $description\nFilename: ${home.filename}\nImagepath: $image",
      );
      // Delete the original file

      debugPrint("Data updated in ${newFile.path}");
      Get.back(id: Get.find<NavigationScreenController>().currentPage.value);
      getmoneyController.clear();
      getcategoriesController.clear();
      getdateController.clear();
      getdescriptionController.clear();
      getfilenameController.clear();
      selectedImage.close();
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
    // await getCategoriesFromStorage(); // Call this method during initialization
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

    //   if (pickedFile != null) {
    //     final CroppedFile? croppedFile = await ImageCropper().cropImage(
    //       sourcePath: pickedFile.path,
    //       aspectRatioPresets: [
    //         CropAspectRatioPreset.square,
    //         CropAspectRatioPreset.ratio3x2,
    //         CropAspectRatioPreset.original,
    //         CropAspectRatioPreset.ratio4x3,
    //         CropAspectRatioPreset.ratio16x9
    //       ],
    //       uiSettings: [
    //         AndroidUiSettings(
    //           toolbarTitle: "Cropper",
    //           toolbarColor: Colors.deepOrange,
    //           toolbarWidgetColor: Colors.white,
    //           initAspectRatio: CropAspectRatioPreset.original,
    //           lockAspectRatio: false,
    //         ),
    //         IOSUiSettings(
    //           title: "Cropper",
    //         ),
    //       ],
    //     );

    //     if (croppedFile != null) {
    //       selectedImage.value = selectedImage.value = File(croppedFile.path);

    //       isImageSelected = true; // Set the flag to true
    //     }
    //   }
    //   Get.back();
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

  // open full screen image
  Future<void> openFullscreenImage() async {
    await Get.toNamed(
      FullScreenImageViewer.name,
      id: Get.find<NavigationScreenController>().currentPage.value,
    );
  }

  /// End For Image Section
}
