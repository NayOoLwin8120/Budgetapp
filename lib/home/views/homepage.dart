import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/detail/view/detail_page.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/views/income_page.dart";
import "package:money_budget/outcome/views/outcome_page.dart";
import "package:money_budget/util/datalist.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class Homepage extends GetView<HomeController> {
  Homepage({Key? key})
      : home = Get.put(HomeController()),
        super(key: key);

  final HomeController home;

  static const String name = "/homepage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyan,
      appBar: AppBar(
        // backgroundColor: Colors.cyan,
        title: const Center(child: Text("Home")),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        debugPrint(
                          "============== Income page ================",
                        );
                        await Get.toNamed(
                          IncomePage.name,
                          id: Get.find<NavigationScreenController>()
                              .currentPage
                              .value,
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(child: Text("Income")),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(
                          OutcomePage.name,
                          id: Get.find<NavigationScreenController>()
                              .currentPage
                              .value,
                        );

                        debugPrint(
                          "============== OutCome page ================",
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(child: Text("Expense")),
                      ),
                    ),
                  ],
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
                          const Text(" Total  "),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                home.totalMoney.toString(),
                                // style: const TextStyle(color: Colors.green),
                                style: TextStyle(color: incomeColor),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "K",
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
                                "K",
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
                                "K",
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
                SizedBox(
                  height: 3,
                  // width: 5,
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<String>>(
                  // ignore: discarded_futures
                  future: home.readAllFilesInFolder(
                    "/storage/emulated/0/Download/Money/Outcome",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      final List<String> fileContents = snapshot.data ?? [];

                      final Map<String, List<DataListItem>> groupedData =
                          {}; // Map to group data by date

                      for (final String content in fileContents) {
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
                                      debugPrint("deleete");
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
                                  )
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
                    // };
                  },
                ),
                // Obx(
                //   () {
                //     final List<String> loadedData = home.fileContents;
                //     if (loadedData.isEmpty) {
                //       return const Text("No data available.");
                //     } else {
                //       final Map<String, List<DataListItem>> groupedData =
                //           {}; // Map to group data by date

                //       for (final String content in loadedData) {
                //         final List<String> lines = content.split("\n");
                //         final String dateLine = lines.firstWhere(
                //           (line) => line.startsWith("Date:"),
                //           orElse: () => "Date:",
                //         );
                //         final String date = dateLine.substring("Date: ".length);

                //         final String moneyLine = lines.firstWhere(
                //           (line) => line.startsWith("Money:"),
                //           orElse: () => "Money:",
                //         );
                //         final String titleLine = lines.firstWhere(
                //           (line) => line.startsWith("Title:"),
                //           orElse: () => "Title:",
                //         );
                //         final String descriptionLine = lines.firstWhere(
                //           (line) => line.startsWith("Description:"),
                //           orElse: () => "Description:",
                //         );
                //         final String fileLine = lines.firstWhere(
                //           (line) => line.startsWith("Filename:"),
                //           orElse: () => "Filename:",
                //         );

                //         final String money =
                //             moneyLine.substring("Money: ".length);
                //         final String description =
                //             descriptionLine.substring("Description: ".length);
                //         final String filename =
                //             fileLine.substring("Filename: ".length);
                //         final String title =
                //             titleLine.substring("Title: ".length);

                //         final DataListItem item = DataListItem(
                //           iconaction: () async {
                //             await home.deleteFile(
                //               "/storage/emulated/0/Download/Money/Outcome/$filename.txt",
                //             );
                //             Get.find<HomeController>().update();
                //           },
                //           filename: filename,
                //           about: description,
                //           money: money,
                //           title: title,
                //         );

                //         if (groupedData.containsKey(date)) {
                //           groupedData[date]!.add(item);
                //         } else {
                //           groupedData[date] = [item];
                //         }
                //       }
                //       final List<Widget> groupWidgets = [];

                //       groupedData.forEach((date, dataItems) {
                //         final List<Widget> rowChildren = dataItems
                //             .map(
                //               (dataItem) => Column(
                //                 // crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   DataListItem(
                //                     iconaction: () async {
                //                       debugPrint("deleete");
                //                       final String content =
                //                           await home.readFileContent(
                //                         "/storage/emulated/0/Download/Money/Outcome/${dataItem.filename}.txt",
                //                       );

                //                       debugPrint(content);

                //                       await Get.toNamed(
                //                         DetailPage.name,
                //                         id: Get.find<
                //                                 NavigationScreenController>()
                //                             .currentPage
                //                             .value,
                //                       );
                //                     },
                //                     filename: dataItem.filename,
                //                     about: dataItem.about,
                //                     money: dataItem.money,
                //                     title: dataItem.title,
                //                   )
                //                 ],
                //               ),
                //             )
                //             .toList();

                //         groupWidgets.add(
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Center(
                //                 child: Text(
                //                   date,
                //                   style: const TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ),
                //               Column(
                //                 children: rowChildren,
                //               ),
                //               const SizedBox(height: 20),
                //             ],
                //           ),
                //         );
                //       });

                //       return Column(
                //         children: [
                //           ...groupWidgets,
                //         ],
                //       );
                //     }
                //   },
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
