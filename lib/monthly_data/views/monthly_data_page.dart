import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/home/controllers/homecontroller.dart";

class Monthlydatapage extends GetView<HomeController> {
  Monthlydatapage({Key? key}) : super(key: key);
  final HomeController home = Get.find<HomeController>();

  static const String name = "/monthlydatapage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Data Page"),
      ),
      body: Column(
        children: [
          const Text("Income "),
          Expanded(
            child: FutureBuilder<List<String>>(
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

                  final Map<String, double> categoryToTotalMoney =
                      {}; // Map to store total money for each category

                  for (final String content in fileContents) {
                    final List<String> lines = content.split("\n");
                    final String CategoryLine = lines.firstWhere(
                      (line) => line.startsWith("Category:"),
                      orElse: () => "Category:",
                    );
                    final String moneyLine = lines.firstWhere(
                      (line) => line.startsWith("Money:"),
                      orElse: () => "Money:",
                    );
                    final String titleLine = lines.firstWhere(
                      (line) => line.startsWith("Title:"),
                      orElse: () => "Title:",
                    );

                    final String category =
                        CategoryLine.substring("Category: ".length);
                    final String title = titleLine.substring("Title: ".length);
                    final String money = moneyLine.substring("Money: ".length);
                    final double moneyAmount = double.tryParse(money) ?? 0;

                    if (title == "income") {
                      if (categoryToTotalMoney.containsKey(category)) {
                        categoryToTotalMoney[category] =
                            (categoryToTotalMoney[category] ?? 0) + moneyAmount;
                      } else {
                        categoryToTotalMoney[category] = moneyAmount;
                      }
                    }
                    if (title == "outcome") {
                      if (categoryToTotalMoney.containsKey(category)) {
                        categoryToTotalMoney[category] =
                            (categoryToTotalMoney[category] ?? 0) + moneyAmount;
                      } else {
                        categoryToTotalMoney[category] = moneyAmount;
                      }
                    }
                  }

                  final List<Widget> categoryWidgets = [];
                  final List<PieChartSectionData> pieChartSections =
                      categoryToTotalMoney.entries.map((entry) {
                    final String category = entry.key;
                    final double totalMoney = entry.value;

                    return PieChartSectionData(
                      // value: totalMoney,
                      title: category,
                      color: Colors.primaries[
                          categoryToTotalMoney.keys.toList().indexOf(category) %
                              Colors.primaries.length],
                      radius: 150,
                      badgePositionPercentageOffset: .5,
                      badgeWidget: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "\n\n \$${totalMoney.toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList();

                  categoryToTotalMoney.forEach((category, totalMoney) {
                    categoryWidgets.add(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "$category Income Total: \$${totalMoney.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  });

                  return Column(
                    children: [
                      ...categoryWidgets,
                      Expanded(
                        child: Center(
                          child: PieChart(
                            PieChartData(
                              sections: pieChartSections,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                              centerSpaceColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
