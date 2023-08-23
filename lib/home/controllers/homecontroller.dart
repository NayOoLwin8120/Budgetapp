import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class HomeController extends GetxController {
// ------------------------ start new design --------------------------------
  RxBool isincome = true.obs;
// ------------------------ end new design ----------------------------------
  RxString incomemoney = "0".obs;
  RxString outcomemoney = "0".obs;
  RxString totalmoney = "".obs;
  RxList<double> moneyList = <double>[].obs;
  RxList<double> outcomemoneyList = <double>[].obs;
  // RxList<String> fileContents = <String>[].obs;
  RxList<String> fileContents = RxList<String>([]);
  RxList<String> fileData = RxList<String>([]);
  RxString imagepath = "".obs;

  RxString date = "".obs;
  RxString data = "".obs;
  RxString category = "".obs;
  RxString money = "".obs;
  RxString filename = "".obs;
  RxString title = "".obs;
  RxString description = "".obs;
  Rx<File?> image = Rx<File?>(null);
  RxList<String> displayeddata = RxList<String>([]);
  RxString filenamegroupvalue = "all".obs;
  RxString filevalue = "all".obs;

  @override
  Future<void> onInit() async {
    await readIncomeFromFilesAndAddToMoneyList();

    super.onInit();
  }
// ------------------------ start new design --------------------------------

  void showincome() {
    isincome.value = true;
  }

  void showexpense() {
    isincome.value = false;
  }
// ------------------------ end new design --------------------------------

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
  // String getFormattedTotalMoney() {
  //   final formatter = NumberFormat("#,##0.00", "en_US");
  //   return formatter.format(totalMoney);
  // }

// 1000000

  // Future<void> loadData() async {
  //   try {
  //     final List<String> data = await readAllFilesInFolder(
  //       "/storage/emulated/0/Download/Money/Outcome",
  //     );
  //     fileContents.assignAll(data);
  //     update();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

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
        } else if (line.startsWith("Imagepath:")) {
          imagepath.value = line.substring("Imagepath: ".length);
          image.value = File(line.substring("Imagepath: ".length));

          debugPrint(image.toString());
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

  /// _______________________________________________________
  /// Filter date section
  // RxList<String> filteredData = <String>[].obs;

  ///  __________________________  single date filter
  // Rx<DateTime> selectedDate = DateTime.now().obs;
  // final RxString selectedformatdate = "".obs;

  // Future<void> filterDataBySingleDate(DateTime selectedDate) async {
  //   final filterdate = DateFormat("dd-MM-yyyy").format(selectedDate);
  //   selectedformatdate.value = filterdate;
  //   debugPrint(filterdate);
  //   try {
  //     final filteredData = fileContents.where((content) {
  //       final lines = content.split("\n");
  //       final dateLine = lines.firstWhere(
  //         (line) => line.startsWith("Date:"),
  //         orElse: () => "Date:",
  //       );
  //       final date = dateLine.substring("Date: ".length);
  //       final bool tf = date == filterdate;
  //       return tf;
  //     }).toList();

  //     debugPrint(filteredData.runtimeType.toString());

  //     // ... Display filtered data ...
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  /// -------------------end single date filter

  /// start one week filter
  // void filterDataByOneWeek(DateTime startDate) {
  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");

  //   final filteredData = fileContents.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date:",
  //     );
  //     final date = dateLine.substring("Date: ".length);
  //     final currentDate = formatter.parse(date);
  //     return currentDate.isAfter(startDate) ||
  //         currentDate.isAtSameMomentAs(startDate);
  //   }).toList();
  //   debugPrint(filteredData.toString());
  // }

  // /// end one week filter
  /// end Filter date section

  /// =================  Start new filter  ======================

  Future<void> loadInitialData() async {
    fileContents.value = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );
    debugPrint("===== pass loadData ======");
  }

  final RxString selectedFilter = "all".obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<DateTime> selectedstartDate = DateTime.now().obs;
  final Rx<DateTime> selectedEndDate = DateTime.now().obs;
  final RxList<String> filteredData = <String>[].obs;

// single date
  // Future<List<String>> filterDataByDate(DateTime selectedDate) async {
  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //   final filterdate = formatter.format(selectedDate);
  //   debugPrint(" Filter date is $filterdate");

  //   final filteredData = fileContents.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date:",
  //     );
  //     final date = dateLine.substring("Date: ".length).trim();

  //     debugPrint("Date is $date");
  //     return date == filterdate;
  //   }).toList();

  //   return filteredData;
  // }
  // Future<List<String>> filterDataByDate(DateTime selectedDate) async {
  //   fileData.value = await filterDataIncome(filenamegroupvalue.value);

  //   if (filenamegroupvalue.value == "all") {
  //     debugPrint("data");
  //     fileData.value = await readAllFilesInFolder(
  //       "/storage/emulated/0/Download/Money/Outcome",
  //     );
  //   }

  //   // fileContents.value = fileContent;
  //   // final fileContent = await filterDataIncome(filenamegroupvalue.value);

  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //   final filterdate = formatter.format(selectedDate);

  //   debugPrint(" Filter date is $filterdate and $filenamegroupvalue");
  //   debugPrint(fileData.toString());
  //   final filteredData = fileData.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date: ",
  //     );

  //     final titleLine = filenamegroupvalue.value == "all "
  //         ? null
  //         : lines.firstWhere(
  //             (line) => line.startsWith("Title:"),
  //             orElse: () => "Title: ",
  //           );

  //     final date = dateLine.substring("Date: ".length).trim();
  //     final title = titleLine!.substring("Title: ".length).trim();
  //     debugPrint("date is $date");
  //     debugPrint("value is ${filenamegroupvalue.value}");
  //     debugPrint("data is $title");

  //     return date == filterdate && title == filenamegroupvalue.value;
  //   }).toList();

  //   return filteredData;
  // }

  Future<List<String>> filterDataByDateAndTitle(
    DateTime selectedDate,
    String title,
  ) async {
    // final fileContent = await filterDataIncome(title);
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );

    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final filterDate = formatter.format(selectedDate);

    debugPrint("Filter date is $filterDate");
    debugPrint(fileContent.toString());

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");

      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date: ",
      );
      final date = dateLine.substring("Date: ".length);

      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );
      final dataTitle = titleLine.substring("Title: ".length);

      if (title == "all") {
        return date == filterDate;
      } else {
        return date == filterDate && dataTitle == title;
      }
    }).toList();

    return filteredData;
  }

  /// new
  // Future<List<String>> filterDataByDate(DateTime selectedDate) async {
  //   final fileContent = await readAllFilesInFolder(
  //     "/storage/emulated/0/Download/Money/Outcome",
  //   );

  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //   final filterdate = formatter.format(selectedDate);

  //   debugPrint(" Filter date is $filterdate ");
  //   debugPrint(fileContent.toString());
  //   final filteredData = fileContent.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date: ",
  //     );

  //     final date = dateLine.substring("Date: ".length).trim();

  //     debugPrint("date is $date");
  //     debugPrint("value is ${filenamegroupvalue.value}");

  //     return date == filterdate;
  //   }).toList();

  //   return filteredData;
  // }

  Future<List<String>> filterDataIncome(String title) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );

    debugPrint(" Filter date is $title");
    debugPrint(fileContents.toString());
    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");
      final titleline = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );

      final data = titleline.substring("Title: ".length);
      debugPrint("date is $data");

      if (data == title) {
        debugPrint(data);
      }

      return data == title;
    }).toList();

    return filteredData;
  }

  // filter data by income and expemse
  Future<List<String>> filterDataIncomeAndExpense(String title) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");
      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );
      final dataTitle = titleLine.substring("Title: ".length);

      return dataTitle == title;
    }).toList();

    return filteredData;
  }

  // week
  Future<List<String>> filterDataByWeekAndTitle(
    DateTime selectedDate,
    String title,
  ) async {
    // final fileContent = await filterDataIncome(filenamegroupvalue.value);
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );
    final DateTime startDate =
        selectedDate.subtract(Duration(days: selectedDate.weekday));
    final DateTime endDate = startDate.add(const Duration(days: 6));

    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final formatstartDate = formatter.format(startDate);
    final formatendDate = formatter.format(endDate);

    debugPrint("Filter week start date: ${formatter.format(startDate)}");
    debugPrint("Filter week end date: ${formatter.format(endDate)}");

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");

      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date: ",
      );
      final dateStr = dateLine.substring("Date: ".length);

      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );
      final dataTitle = titleLine.substring("Title: ".length);

      if (title == "all") {
        return dateStr.compareTo(formatstartDate.toString()) >= 0 &&
            dateStr.compareTo(formatendDate.toString()) <= 0;
      } else {
        return dateStr.compareTo(formatstartDate.toString()) >= 0 &&
            dateStr.compareTo(formatendDate.toString()) <= 0 &&
            dataTitle == title;
      }
    }).toList();

    return filteredData;
  }

  // Future<List<String>> filterDataByWeek(DateTime selectedDate) async {
  //   final fileContent = await readAllFilesInFolder(
  //     "/storage/emulated/0/Download/Money/Outcome",
  //   );
  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //   final DateTime startDate =
  //       selectedDate.subtract(Duration(days: selectedDate.weekday));
  //   // final DateTime startDate =
  //   //     selectedDate.subtract(Duration(days: selectedDate.weekday));
  //   debugPrint(startDate.toString());

  //   final formatstartdate = formatter.format(startDate);
  //   debugPrint(formatstartdate.toString());
  //   final DateTime endDate = startDate.add(const Duration(days: 6));
  //   debugPrint(endDate.toString());
  //   final formatenddate = formatter.format(endDate);
  //   debugPrint(formatenddate.toString());

  //   final filteredData = fileContent.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date:",
  //     );
  //     // final date = DateTime.parse(dateLine.substring("Date: ".length));
  //     final date = dateLine.substring("Date: ".length).trim();
  //     // return date.isAfter(startDate) && date.isBefore(endDate);
  //     // return date.compareTo(startDate.toString()) >= 0 &&
  //     //     date.compareTo(endDate.toString()) <= 0;
  //     return date.compareTo(formatstartdate.toString()) >= 0 &&
  //         date.compareTo(formatenddate.toString()) <= 0;
  //   }).toList();
  //   debugPrint(filteredData.toString());

  //   return filteredData;
  // }

  // custom filter
  Future<List<String>> filterDataByCustom(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final formatStartDate = formatter.format(startDate);
    final formatEndDate = formatter.format(endDate);

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");
      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date:",
      );
      final date = dateLine.substring("Date: ".length);

      return date.compareTo(formatStartDate) >= 0 &&
          date.compareTo(formatEndDate) <= 0;
    }).toList();

    return filteredData;
  }

  //  new cusotom filter and title
  Future<List<String>> filterDataByCustomRangeAndTitle(
    DateTime startDate,
    DateTime endDate,
    String title,
  ) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );

    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final formatStartDate = formatter.format(startDate);
    final formatEndDate = formatter.format(endDate);
    debugPrint(formatStartDate);
    debugPrint(formatEndDate);

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");

      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date: ",
      );
      final dateStr = dateLine.substring("Date: ".length);
      debugPrint("========= My data is $dateStr ============");

      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );
      final dataTitle = titleLine.substring("Title: ".length);
      debugPrint("========= My title is $dataTitle ============");

      if (title == "all") {
        return dateStr.compareTo(formatStartDate) >= 0 &&
            date.compareTo(formatEndDate) <= 0;
      } else {
        return dateStr.compareTo(formatStartDate) >= 0 &&
            date.compareTo(formatEndDate) <= 0 &&
            dataTitle == title;
      }
    }).toList();
    debugPrint("========= My data is $filteredData ============");

    return filteredData;
  }

  // Future<List<String>> filterDataByMonth(DateTime selectedDate) async {
  //   // final DateFormat formatter = DateFormat("MM-yyyy");
  //   final DateFormat formatter = DateFormat("dd-MM-yyyy");
  //   final filterMonth = formatter.format(selectedDate);

  //   final filteredData = fileContents.where((content) {
  //     final lines = content.split("\n");
  //     final dateLine = lines.firstWhere(
  //       (line) => line.startsWith("Date:"),
  //       orElse: () => "Date:",
  //     );
  //     // final date = DateTime.parse(dateLine.substring("Date: ".length));
  //     final date = dateLine.substring("Date: ".length);
  //     debugPrint(date.toString());
  //     debugPrint(date.startsWith(filterMonth).toString());
  //     // final monthYear = formatter.format(date);
  //     // return monthYear == filterMonth;
  //     return date.startsWith(filterMonth);
  //   }).toList();

  //   return filteredData;
  // }

  // month
  Future<List<String>> filterDataByMonth(DateTime selectedDate) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final filterMonth = DateFormat("MM-yyyy").format(selectedDate);

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");
      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date:",
      );
      final dateString = dateLine.substring("Date: ".length);
      final date = formatter.parse(dateString);
      final monthYear = DateFormat("MM-yyyy").format(date);
      return monthYear == filterMonth;
    }).toList();

    return filteredData;
  }

  // filter by month and title
  Future<List<String>> filterDataByMonthAndTitle(
    DateTime selectedDate,
    String title,
  ) async {
    final fileContent = await readAllFilesInFolder(
      "/storage/emulated/0/Download/Money/Outcome",
    );
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final filterMonth = DateFormat("MM-yyyy").format(selectedDate);

    debugPrint("Filter week start date: ${formatter.format(selectedDate)}");

    final filteredData = fileContent.where((content) {
      final lines = content.split("\n");

      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date: ",
      );
      final dateStr = dateLine.substring("Date: ".length);
      final date = formatter.parse(dateStr);
      final monthYear = DateFormat("MM-yyyy").format(date);

      final titleLine = lines.firstWhere(
        (line) => line.startsWith("Title:"),
        orElse: () => "Title: ",
      );
      final dataTitle = titleLine.substring("Title: ".length);

      if (title == "all") {
        return monthYear == filterMonth;
      } else {
        return monthYear == filterMonth && dataTitle == title;
      }
    }).toList();

    return filteredData;
  }

  /// year filter
  Future<List<String>> filterDataByYear(DateTime selectedDate) async {
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final filterYear = DateFormat("yyyy").format(selectedDate);

    final filteredData = fileContents.where((content) {
      final lines = content.split("\n");
      final dateLine = lines.firstWhere(
        (line) => line.startsWith("Date:"),
        orElse: () => "Date:",
      );
      final dateString = dateLine.substring("Date: ".length);
      final date = formatter.parse(dateString);
      final year = DateFormat("yyyy").format(date);
      return year == filterYear;
    }).toList();

    return filteredData;
  }

  //show date range picker

  /// =================end new filter ===========================
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  /// -------------------------- New Design ----------------------
  ///

  
}

enum FilterType {
  singleDate,
  oneWeek,
  thisMonth,
  // Add more filter options as needed ...
}
