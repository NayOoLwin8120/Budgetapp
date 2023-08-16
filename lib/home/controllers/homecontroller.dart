import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeController extends GetxController {
  // RxString incomemoney = "".obs;

  // void setIncomeMoney(String value) {
  //   incomemoney.value = value;
  // }

  // void increasemoney(String value) {
  //   incomemoney.value = value;
  //   int.parse(incomemoney.value);
  //   debugPrint(incomemoney.value);
  //   debugPrint(incomemoney.value.toString());
  // }
  RxString incomemoney = "0".obs;
  RxString outcomemoney = "0".obs;
  RxString totalmoney = "".obs;
  RxList<double> moneyList = <double>[].obs;
  RxList<double> outcomemoneyList = <double>[].obs;
  // RxList<String> fileContents = <String>[].obs;
  RxList<String> fileContents = RxList<String>([]);

  RxString date = "".obs;
  RxString data = "".obs;
  RxString category = "".obs;
  RxString money = "".obs;
  RxString filename = "".obs;
  RxString title = "".obs;
  RxString description = "".obs;

  @override
  Future<void> onInit() async {
    // incomemoney.val;
    // outcomemoney.value;
    await readIncomeFromFilesAndAddToMoneyList();
    await loadData();

    super.onInit();
  }

  void setIncomeMoney(String value) {
    incomemoney.value = value;
  }

  void addMoney(double amount) {
    moneyList.add(amount);
    final double total =
        moneyList.fold(0, (previousValue, element) => previousValue + element);
    incomemoney.value = total.toString();
    debugPrint(moneyList.toString());
  }
  // Default color for outcome

  void setOutcomeMoney(String value) {
    outcomemoney.value = value;
  }

  void addOutMoney(double amount) {
    outcomemoneyList.add(amount);
    final double total = outcomemoneyList.fold(
      0,
      (previousValue, element) => previousValue + element,
    );
    outcomemoney.value = total.toString();
    debugPrint(outcomemoneyList.toString());
  }

  double get totalIncome =>
      moneyList.fold(0, (previousValue, element) => previousValue + element);

  double get totalOutcome => outcomemoneyList.fold(
        0,
        (previousValue, element) => previousValue + element,
      );

  double get totalMoney => totalIncome - totalOutcome;

  Future<void> loadData() async {
    try {
      final List<String> data = await readAllFilesInFolder(
        "/storage/emulated/0/Download/Money/Outcome",
      );
      fileContents.assignAll(data);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<String>> readAllFilesInFolder(String folderPath) async {
    try {
      final Directory folder = Directory(folderPath);

      if (await folder.exists()) {
        final List<File> files = folder.listSync().whereType<File>().toList();
        final List<String> fileContents = [];

        for (final File file in files) {
          final String content = await file.readAsString();
          fileContents.add(content);
        }

        return fileContents;
      }
    } catch (e) {
      debugPrint("Error reading files: $e");
    }
    return []; // Return empty list if reading fails
  }

  // get total income from file

  Future<void> readIncomeFromFilesAndAddToMoneyList() async {
    final Directory appDocumentsDirectory =
        Directory("/storage/emulated/0/Download/Money/Outcome");
    if (!appDocumentsDirectory.existsSync()) {
      return;
    }
    moneyList.clear();
    outcomemoneyList.clear();
    final List<File> files =
        appDocumentsDirectory.listSync().whereType<File>().toList();

    for (final file in files) {
      final String content = await file.readAsString();
      final lines = content.split("\n");
      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title:",
      );
      final title = titleLine.split(" ").last;

      if (title == "income") {
        final moneyLine = lines.firstWhere(
          (line) => line.startsWith("Money:"),
          orElse: () => "Money: 0",
        );
        final money = double.tryParse(moneyLine.split(" ").last) ?? 0.0;

        moneyList.add(money);
      }
      if (title == "outcome") {
        final moneyLine = lines.firstWhere(
          (line) => line.startsWith("Money:"),
          orElse: () => "Money: 0",
        );
        final money = double.tryParse(moneyLine.split(" ").last) ?? 0.0;

        outcomemoneyList.add(money);
      }
    }
  }

  Future<void> deleteFile(String filePath) async {
    final File fileToDelete = File(filePath);
    await fileToDelete.delete();
    fileContents.remove(filePath);
    // Remove the deleted amount from the moneyList
    final String fileName =
        filePath.split("/").last; // Extract the filename from the path
    final String amountString = fileName.replaceAll(".txt", "");
    debugPrint(amountString); // Remove '.txt' extension
    final double deletedAmount = double.tryParse(amountString) ?? 0.0;
    debugPrint(deletedAmount.toString());

    moneyList.remove(deletedAmount);
    outcomemoneyList.remove(deletedAmount);

    // double total =
    //     moneyList.fold(0, (previousValue, element) => previousValue + element);
    // incomemoney.value = total.toString();

    incomemoney.value = moneyList
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toStringAsFixed(2);
    outcomemoney.value = outcomemoneyList
        .fold<double>(0, (previousValue, element) => previousValue + element)
        .toStringAsFixed(2);
    debugPrint(incomemoney.toString());
    debugPrint(outcomemoneyList.toString());

    // fileContents.remove(filePath);

    Get
      ..snackbar("Success", "Delete Succesfully")
      ..back();
  }

  /// read single file
  Future<String> readFileContent(String filePath) async {
    final File file = File(filePath);
    if (await file.exists()) {
      final String content = await file.readAsString();
      final List<String> lines = content.split("\n");
      for (final line in lines) {
        if (line.startsWith("Title:")) {
          title.value = line.substring("Title: ".length);
        } else if (line.startsWith("Money:")) {
          money.value = line.substring("Money: ".length);
        } else if (line.startsWith("Category:")) {
          category.value = line.substring("Category: ".length);
        } else if (line.startsWith("Date:")) {
          date.value = line.substring("Date: ".length);
        } else if (line.startsWith("Description:")) {
          description.value = line.substring("Description: ".length);
        } else if (line.startsWith("Filename:")) {
          filename.value = line.substring("Filename: ".length);
        }
      }
      debugPrint(" ============= pass ============ ");
      return content;

      // Money.value = aa[0];
      // Date.value = aa[2];
    }
    return ""; // Return empty string if file doesn't exist
  }

  Future<void> deleteFileAndRefreshUI(String filePath) async {
    final fileToDelete = File(filePath);
    if (await fileToDelete.exists()) {
      await fileToDelete.delete();
      await readIncomeFromFilesAndAddToMoneyList(); // Refresh the data
      update(); // Notify GetX to update the UI
    }
  }
}
