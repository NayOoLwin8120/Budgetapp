import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:money_budget/detail/view/detail_page.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/income/views/income_page.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";
import "package:money_budget/outcome/views/outcome_page.dart";
import "package:money_budget/util/cusbutton.dart";
import "package:money_budget/util/datalist.dart";
import "package:money_budget/util/date_range_picker.dart";
import "package:money_budget/util/datepicker.dart";
import "package:money_budget/util/text_filed.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class AllDataPage extends GetView<HomeController> {
  AllDataPage({super.key});
  final HomeController home = Get.put(HomeController());
  final IncomeController income = Get.put(IncomeController());
  final OutcomeController expense = Get.put(OutcomeController());
  static const String name = "/alldatapage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xff6633CC),
      ),
      body: Obx(
        () {
          final Color incomeColor =
              controller.totalIncome > controller.totalOutcome
                  ? Colors.green
                  : Colors.red;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xff6633CC),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                      bottomLeft: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Total Balance ",
                        // style: const TextStyle(color: Colors.green),
                        // style: TextStyle(color: incomeColor),

                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            home.totalMoney.toString(),
                            // style: const TextStyle(color: Colors.green),
                            // style: TextStyle(color: incomeColor),

                            style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "MMK",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const Text(" Income   "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                home.totalIncome.toString(),
                                style: const TextStyle(color: Colors.green),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "MMK",
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const Text("Expense "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // home.outcomemoney.value.toString(),
                                home.totalOutcome.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "MMK",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Filter section
                // Add Filter Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final selected = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2000),
                    //       lastDate: DateTime.now(),
                    //     );
                    //     final formatselect =
                    //         DateFormat("dd-MM-yyyy").format(selected!);

                    //     home.selectedformatdate.value = formatselect;

                    //     await controller.filterDataBySingleDate(selected);
                    //   },
                    //   child: home.selectedformatdate != null
                    //       ? Text(home.selectedformatdate.toString())
                    //       : const Text("Choose Date"),
                    // ),

                    DropdownButton<String>(
                      value: home.selectedFilter.value,
                      onChanged: (newValue) {
                        home.selectedFilter.value = newValue!;
                        // Reset selected date when changing filter type
                        home.selectedDate.value = DateTime.now();
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "all",
                          child: Text("All"),
                        ),
                        DropdownMenuItem(
                          value: "date",
                          child: Text("Date"),
                        ),
                        DropdownMenuItem(
                          value: "week",
                          child: Text("This Week"),
                        ),
                        DropdownMenuItem(
                          value: "month",
                          child: Text(" This Month"),
                        ),
                        // DropdownMenuItem(
                        //   value: "year",
                        //   child: Text("Year"),
                        // ),
                        // DropdownMenuItem(
                        //   value: "custom",
                        //   child: Text("Custom"),
                        // ),
                      ],
                    ),
                    Visibility(
                      visible: home.selectedFilter.value == "custom",
                      child: DateRangePickerWidget(
                        startDate: home.selectedstartDate.value,
                        endDate: home.selectedEndDate.value,
                        onStartDateChanged: (newStartDate) {
                          home.selectedDate.value = newStartDate;
                        },
                        onEndDateChanged: (newEndDate) {
                          home.selectedEndDate.value = newEndDate;
                        },
                      ),
                    ),

                    Visibility(
                      visible: home.selectedFilter.value != "all" &&
                          home.selectedFilter.value != "week" &&
                          home.selectedFilter.value != "custom",
                      child: DatePickerWidget(
                        selectedDate: home.selectedDate.value,
                        onDateChanged: (newDate) {
                          home.selectedDate.value = newDate;
                        },
                        datetext: (home.selectedFilter.value == "year")
                            ? home.selectedDate.value.year.toString()
                            : DateFormat("dd-MM-yyyy")
                                .format(home.selectedDate.value),
                        yearonly: home.selectedFilter.value == "year",
                      ),
                    ),
                  ],
                ),

                /// end Filter section
                SizedBox(
                  height: 3,
                  // width: 5,
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: "all",
                      groupValue: home.filenamegroupvalue.value,
                      onChanged: (data) {
                        home.filenamegroupvalue.value = data!;
                        debugPrint(home.filevalue.toString());
                      },
                      activeColor: home.filenamegroupvalue.value == "all"
                          ? Colors.green
                          : Colors.red,
                    ),
                    const Text("All"),
                    Radio<String>(
                      value: "income",
                      groupValue: home.filenamegroupvalue.value,
                      onChanged: (data) async {
                        home.filenamegroupvalue.value = data!;
                        debugPrint(home.filenamegroupvalue.toString());
                        // await home.filterDataIncome(data);
                      },
                      activeColor: home.filenamegroupvalue.value == "all"
                          ? Colors.green
                          : Colors.red,
                    ),
                    const Text("Income"),
                    Radio<String>(
                      value: "outcome",
                      groupValue: home.filenamegroupvalue.value,
                      onChanged: (data) async {
                        home.filenamegroupvalue.value = data!;
                        debugPrint(home.filevalue.toString());
                        // await home.filterDataIncome(data);
                      },
                      activeColor: home.filenamegroupvalue.value == "all"
                          ? Colors.green
                          : Colors.red,
                    ),
                    const Text("Expense"),
                  ],
                ),

                FutureBuilder<List<String>>(
                  future: () {
                    if (home.selectedFilter.value == "date") {
                      return home.filterDataByDateAndTitle(
                        home.selectedDate.value,
                        home.filenamegroupvalue
                            .value, // Pass the selected title here
                      );
                    } else if (home.selectedFilter.value == "week") {
                      return home.filterDataByWeekAndTitle(
                        home.selectedDate.value,
                        home.filenamegroupvalue
                            .value, // Pass the selected title here
                      );
                    } else if (home.selectedFilter.value == "month") {
                      return home.filterDataByMonthAndTitle(
                        home.selectedDate.value,
                        home.filenamegroupvalue.value,
                      );
                      // return home.filterDataByMonth(home.selectedDate.value);
                    } else if (home.selectedFilter.value == "custom") {
                      return home.filterDataByCustomRangeAndTitle(
                        home.selectedstartDate.value,
                        home.selectedEndDate.value,
                        home.filenamegroupvalue.value,
                      );
                      // return home.filterDataByCustom(
                      //   home.selectedstartDate.value,
                      //   home.selectedEndDate.value,
                      // );
                    } else if (home.selectedFilter.value == "year") {
                      return home.filterDataByYear(home.selectedDate.value);
                    } else if (home.selectedFilter.value == "all") {
                      if (home.filenamegroupvalue.value == "income" ||
                          home.filenamegroupvalue.value == "outcome") {
                        return home.filterDataIncomeAndExpense(
                          home.filenamegroupvalue.value,
                        );
                      } else {
                        return home.readAllFilesInFolder(
                          "/storage/emulated/0/Download/Money/Outcome",
                        );
                      }
                    } else if (home.filenamegroupvalue.value == "income") {
                      // return home.filterDataIncome("income");
                      return home
                          .filterDataIncome(home.filenamegroupvalue.value);
                    } else if (home.filenamegroupvalue.value == "outcome") {
                      // return home.filterDataIncome("outcome");
                      return home
                          .filterDataIncome(home.filenamegroupvalue.value);
                    } else {
                      return home.readAllFilesInFolder(
                        "/storage/emulated/0/Download/Money/Outcome",
                      );
                    }
                  }(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      final List<String> filteredData = snapshot.data ?? [];
                      debugPrint(filteredData.toString());
                      if (filteredData.isEmpty) {
                        return const Text("No data Found !");
                      }

                      final Map<String, List<DataListItem>> groupedData =
                          {}; // Map to group data by date

                      for (final String content in filteredData) {
                        final List<String> lines = content.split("\n");
                        final String dateLine = lines.firstWhere(
                          (line) => line.startsWith("Date:"),
                          orElse: () => "Date:",
                        );
                        final String date = dateLine.substring("Date: ".length);

                        final String moneyLine = lines.firstWhere(
                          (line) => line.startsWith("Money:"),
                          orElse: () => "Money:",
                        );
                        final String titleLine = lines.firstWhere(
                          (line) => line.startsWith("Title:"),
                          orElse: () => "Title:",
                        );
                        final String CategoryLine = lines.firstWhere(
                          (line) => line.startsWith("Category:"),
                          orElse: () => "Category:",
                        );
                        final String descriptionLine = lines.firstWhere(
                          (line) => line.startsWith("Description:"),
                          orElse: () => "Description:",
                        );
                        final String fileLine = lines.firstWhere(
                          (line) => line.startsWith("Filename:"),
                          orElse: () => "Filename:",
                        );

                        final String money =
                            moneyLine.substring("Money: ".length);
                        final String description =
                            descriptionLine.substring("Description: ".length);
                        final String category =
                            CategoryLine.substring("Category: ".length);
                        final String filename =
                            fileLine.substring("Filename: ".length);
                        final String title =
                            titleLine.substring("Title: ".length);

                        final DataListItem item = DataListItem(
                          iconaction: () async {
                            await home.deleteFile(
                              "/storage/emulated/0/Download/Money/Outcome/$filename.txt",
                            );
                            Get.find<HomeController>().update();
                          },
                          filename: filename,
                          about: category,
                          money: money,
                          title: title,
                        );

                        if (groupedData.containsKey(date)) {
                          groupedData[date]!.add(item);
                        } else {
                          groupedData[date] = [item];
                        }
                      }

                      final List<Widget> groupWidgets = [];

                      groupedData.forEach((date, dataItems) {
                        final List<Widget> rowChildren = dataItems
                            .map(
                              (dataItem) => Column(
                                children: [
                                  DataListItem(
                                    iconaction: () async {
                                      final String content =
                                          await home.readFileContent(
                                        "/storage/emulated/0/Download/Money/Outcome/${dataItem.filename}.txt",
                                      );

                                      debugPrint(content);

                                      await Get.toNamed(
                                        DetailPage.name,
                                        id: Get.find<
                                                NavigationScreenController>()
                                            .currentPage
                                            .value,
                                      );
                                    },
                                    filename: dataItem.filename,
                                    about: dataItem.about,
                                    money: dataItem.money,
                                    title: dataItem.title,
                                  ),
                                ],
                              ),
                            )
                            .toList();

                        groupWidgets.add(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Column(
                                children: rowChildren,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      });

                      return Column(
                        children: [
                          ...groupWidgets,
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
