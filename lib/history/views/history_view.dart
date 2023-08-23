// ignore_for_file: discarded_futures

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/detail/view/detail_page.dart";
import "package:money_budget/history/controllers/history_controller.dart";
import "package:money_budget/history/views/alldata.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/util/datalist.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class HistoryPage extends GetView<HistoryController> {
  HistoryPage({super.key});
  static const String name = "/historypage";
  HistoryController history = Get.put(HistoryController());
  HomeController home = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xff6633CC),
      ),
      body: Obx(() {
        debugPrint("===== Months are ${history.months}");
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color(0xff6633CC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "History",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Days",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "Weeks ",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "Month",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "Year",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xffFFFFFF)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 200),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: controller.months.map((month) {
                        return Text(
                          month,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xffFFFFFF),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    "Recently",
                    style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Get.toNamed(
                        AllDataPage.name,
                        id: Get.find<NavigationScreenController>()
                            .currentPage
                            .value,
                      );
                      debugPrint("see all");
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
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

              /// for show data
              Obx(() {
                return FutureBuilder<List<String>>(
                  future: () {
                    return home.filterDataByDateAndTitle(
                      home.selectedDate.value,
                      home.filenamegroupvalue.value,
                    );

                    // return home.readAllFilesInFolder(
                    //   "/storage/emulated/0/Download/Money/Outcome",
                    // );
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
                        final String categoryLine = lines.firstWhere(
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

                        final String category =
                            categoryLine.substring("Category: ".length);
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
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
