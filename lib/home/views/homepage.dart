// ignore_for_file: discarded_futures

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

class Homepage extends GetView<HomeController> {
  Homepage({Key? key})
      : home = Get.put(HomeController()),
        super(key: key);

  final HomeController home;
  IncomeController income = Get.put(IncomeController());
  OutcomeController expense = Get.put(OutcomeController());
  static const String name = "/homepage";

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: const Color(0xffEEEEEE),
    //   appBar: AppBar(
    //     // backgroundColor: Colors.cyan,
    //     title: const Center(child: Text("Home")),
    //   ),
    //   body: Obx(
    //     () {
    //       final Color incomeColor =
    //           controller.totalIncome > controller.totalOutcome
    //               ? Colors.green
    //               : Colors.red;
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () async {
    //                     debugPrint(
    //                       "============== Income page ================",
    //                     );
    //                     await Get.toNamed(
    //                       IncomePage.name,
    //                       id: Get.find<NavigationScreenController>()
    //                           .currentPage
    //                           .value,
    //                     );
    //                   },
    //                   child: Container(
    //                     width: 150,
    //                     height: 50,
    //                     decoration: BoxDecoration(
    //                       color: Colors.cyan,
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     ),
    //                     child: const Center(child: Text("Income")),
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () async {
    //                     await Get.toNamed(
    //                       OutcomePage.name,
    //                       id: Get.find<NavigationScreenController>()
    //                           .currentPage
    //                           .value,
    //                     );

    //                     debugPrint(
    //                       "============== OutCome page ================",
    //                     );
    //                   },
    //                   child: Container(
    //                     width: 150,
    //                     height: 50,
    //                     decoration: BoxDecoration(
    //                       color: Colors.cyan,
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     ),
    //                     child: const Center(child: Text("Expense")),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 20),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Container(
    //                   width: 120,
    //                   height: 50,
    //                   decoration: BoxDecoration(
    //                     // color: Colors.cyan,
    //                     borderRadius: BorderRadius.circular(10.0),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       const Text(" Income   "),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             home.totalIncome.toString(),
    //                             style: const TextStyle(color: Colors.green),
    //                           ),
    //                           const SizedBox(width: 4),
    //                           const Text(
    //                             "K",
    //                             style: TextStyle(color: Colors.green),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   width: 120,
    //                   height: 50,
    //                   decoration: BoxDecoration(
    //                     // color: Colors.cyan,
    //                     borderRadius: BorderRadius.circular(10.0),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       const Text("Expense "),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             // home.outcomemoney.value.toString(),
    //                             home.totalOutcome.toString(),
    //                             style: const TextStyle(color: Colors.red),
    //                           ),
    //                           const SizedBox(width: 4),
    //                           const Text(
    //                             "K",
    //                             style: TextStyle(color: Colors.red),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   width: 120,
    //                   height: 50,
    //                   decoration: BoxDecoration(
    //                     // color: Colors.cyan,
    //                     borderRadius: BorderRadius.circular(10.0),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       const Text(" Total  "),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           Text(
    //                             home.totalMoney.toString(),
    //                             // style: const TextStyle(color: Colors.green),
    //                             style: TextStyle(color: incomeColor),
    //                           ),
    //                           const SizedBox(width: 4),
    //                           const Text(
    //                             "K",
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 10),

    //             /// Filter section
    //             // Add Filter Options
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 // ElevatedButton(
    //                 //   onPressed: () async {
    //                 //     final selected = await showDatePicker(
    //                 //       context: context,
    //                 //       initialDate: DateTime.now(),
    //                 //       firstDate: DateTime(2000),
    //                 //       lastDate: DateTime.now(),
    //                 //     );
    //                 //     final formatselect =
    //                 //         DateFormat("dd-MM-yyyy").format(selected!);

    //                 //     home.selectedformatdate.value = formatselect;

    //                 //     await controller.filterDataBySingleDate(selected);
    //                 //   },
    //                 //   child: home.selectedformatdate != null
    //                 //       ? Text(home.selectedformatdate.toString())
    //                 //       : const Text("Choose Date"),
    //                 // ),

    //                 DropdownButton<String>(
    //                   value: home.selectedFilter.value,
    //                   onChanged: (newValue) {
    //                     home.selectedFilter.value = newValue!;
    //                     // Reset selected date when changing filter type
    //                     home.selectedDate.value = DateTime.now();
    //                   },
    //                   items: const [
    //                     DropdownMenuItem(
    //                       value: "all",
    //                       child: Text("All"),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: "date",
    //                       child: Text("Date"),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: "week",
    //                       child: Text("This Week"),
    //                     ),
    //                     DropdownMenuItem(
    //                       value: "month",
    //                       child: Text(" This Month"),
    //                     ),
    //                     // DropdownMenuItem(
    //                     //   value: "year",
    //                     //   child: Text("Year"),
    //                     // ),
    //                     // DropdownMenuItem(
    //                     //   value: "custom",
    //                     //   child: Text("Custom"),
    //                     // ),
    //                   ],
    //                 ),
    //                 Visibility(
    //                   visible: home.selectedFilter.value == "custom",
    //                   child: DateRangePickerWidget(
    //                     startDate: home.selectedstartDate.value,
    //                     endDate: home.selectedEndDate.value,
    //                     onStartDateChanged: (newStartDate) {
    //                       home.selectedDate.value = newStartDate;
    //                     },
    //                     onEndDateChanged: (newEndDate) {
    //                       home.selectedEndDate.value = newEndDate;
    //                     },
    //                   ),
    //                 ),

    //                 Visibility(
    //                   visible: home.selectedFilter.value != "all" &&
    //                       home.selectedFilter.value != "week" &&
    //                       home.selectedFilter.value != "custom",
    //                   child: DatePickerWidget(
    //                     selectedDate: home.selectedDate.value,
    //                     onDateChanged: (newDate) {
    //                       home.selectedDate.value = newDate;
    //                     },
    //                     datetext: (home.selectedFilter.value == "year")
    //                         ? home.selectedDate.value.year.toString()
    //                         : DateFormat("dd-MM-yyyy")
    //                             .format(home.selectedDate.value),
    //                     yearonly: home.selectedFilter.value == "year",
    //                   ),
    //                 ),
    //               ],
    //             ),

    //             /// end Filter section
    //             SizedBox(
    //               height: 3,
    //               // width: 5,
    //               child: Container(color: Colors.black.withOpacity(0.3)),
    //             ),
    //             const SizedBox(height: 10),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Radio<String>(
    //                   value: "all",
    //                   groupValue: home.filenamegroupvalue.value,
    //                   onChanged: (data) {
    //                     home.filenamegroupvalue.value = data!;
    //                     debugPrint(home.filevalue.toString());
    //                   },
    //                   activeColor: home.filenamegroupvalue.value == "all"
    //                       ? Colors.green
    //                       : Colors.red,
    //                 ),
    //                 const Text("All"),
    //                 Radio<String>(
    //                   value: "income",
    //                   groupValue: home.filenamegroupvalue.value,
    //                   onChanged: (data) async {
    //                     home.filenamegroupvalue.value = data!;
    //                     debugPrint(home.filenamegroupvalue.toString());
    //                     // await home.filterDataIncome(data);
    //                   },
    //                   activeColor: home.filenamegroupvalue.value == "all"
    //                       ? Colors.green
    //                       : Colors.red,
    //                 ),
    //                 const Text("Income"),
    //                 Radio<String>(
    //                   value: "outcome",
    //                   groupValue: home.filenamegroupvalue.value,
    //                   onChanged: (data) async {
    //                     home.filenamegroupvalue.value = data!;
    //                     debugPrint(home.filevalue.toString());
    //                     // await home.filterDataIncome(data);
    //                   },
    //                   activeColor: home.filenamegroupvalue.value == "all"
    //                       ? Colors.green
    //                       : Colors.red,
    //                 ),
    //                 const Text("Expense"),
    //               ],
    //             ),

    //             FutureBuilder<List<String>>(
    //               future: () {
    //                 if (home.selectedFilter.value == "date") {
    //                   return home.filterDataByDateAndTitle(
    //                     home.selectedDate.value,
    //                     home.filenamegroupvalue
    //                         .value, // Pass the selected title here
    //                   );
    //                 } else if (home.selectedFilter.value == "week") {
    //                   return home.filterDataByWeekAndTitle(
    //                     home.selectedDate.value,
    //                     home.filenamegroupvalue
    //                         .value, // Pass the selected title here
    //                   );
    //                 } else if (home.selectedFilter.value == "month") {
    //                   return home.filterDataByMonthAndTitle(
    //                     home.selectedDate.value,
    //                     home.filenamegroupvalue.value,
    //                   );
    //                   // return home.filterDataByMonth(home.selectedDate.value);
    //                 } else if (home.selectedFilter.value == "custom") {
    //                   return home.filterDataByCustomRangeAndTitle(
    //                     home.selectedstartDate.value,
    //                     home.selectedEndDate.value,
    //                     home.filenamegroupvalue.value,
    //                   );
    //                   // return home.filterDataByCustom(
    //                   //   home.selectedstartDate.value,
    //                   //   home.selectedEndDate.value,
    //                   // );
    //                 } else if (home.selectedFilter.value == "year") {
    //                   return home.filterDataByYear(home.selectedDate.value);
    //                 } else if (home.selectedFilter.value == "all") {
    //                   if (home.filenamegroupvalue.value == "income" ||
    //                       home.filenamegroupvalue.value == "outcome") {
    //                     return home.filterDataIncomeAndExpense(
    //                       home.filenamegroupvalue.value,
    //                     );
    //                   } else {
    //                     return home.readAllFilesInFolder(
    //                       "/storage/emulated/0/Download/Money/Outcome",
    //                     );
    //                   }
    //                 } else if (home.filenamegroupvalue.value == "income") {
    //                   // return home.filterDataIncome("income");
    //                   return home
    //                       .filterDataIncome(home.filenamegroupvalue.value);
    //                 } else if (home.filenamegroupvalue.value == "outcome") {
    //                   // return home.filterDataIncome("outcome");
    //                   return home
    //                       .filterDataIncome(home.filenamegroupvalue.value);
    //                 } else {
    //                   return home.readAllFilesInFolder(
    //                     "/storage/emulated/0/Download/Money/Outcome",
    //                   );
    //                 }
    //               }(),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                   return const CircularProgressIndicator();
    //                 } else if (snapshot.hasError) {
    //                   return Text("Error: ${snapshot.error}");
    //                 } else {
    //                   final List<String> filteredData = snapshot.data ?? [];
    //                   debugPrint(filteredData.toString());
    //                   if (filteredData.isEmpty) {
    //                     return const Text("No data Found !");
    //                   }

    //                   final Map<String, List<DataListItem>> groupedData =
    //                       {}; // Map to group data by date

    //                   for (final String content in filteredData) {
    //                     final List<String> lines = content.split("\n");
    //                     final String dateLine = lines.firstWhere(
    //                       (line) => line.startsWith("Date:"),
    //                       orElse: () => "Date:",
    //                     );
    //                     final String date = dateLine.substring("Date: ".length);

    //                     final String moneyLine = lines.firstWhere(
    //                       (line) => line.startsWith("Money:"),
    //                       orElse: () => "Money:",
    //                     );
    //                     final String titleLine = lines.firstWhere(
    //                       (line) => line.startsWith("Title:"),
    //                       orElse: () => "Title:",
    //                     );
    //                     final String CategoryLine = lines.firstWhere(
    //                       (line) => line.startsWith("Category:"),
    //                       orElse: () => "Category:",
    //                     );
    //                     final String descriptionLine = lines.firstWhere(
    //                       (line) => line.startsWith("Description:"),
    //                       orElse: () => "Description:",
    //                     );
    //                     final String fileLine = lines.firstWhere(
    //                       (line) => line.startsWith("Filename:"),
    //                       orElse: () => "Filename:",
    //                     );

    //                     final String money =
    //                         moneyLine.substring("Money: ".length);
    //                     final String description =
    //                         descriptionLine.substring("Description: ".length);
    //                     final String category =
    //                         CategoryLine.substring("Category: ".length);
    //                     final String filename =
    //                         fileLine.substring("Filename: ".length);
    //                     final String title =
    //                         titleLine.substring("Title: ".length);

    //                     final DataListItem item = DataListItem(
    //                       iconaction: () async {
    //                         await home.deleteFile(
    //                           "/storage/emulated/0/Download/Money/Outcome/$filename.txt",
    //                         );
    //                         Get.find<HomeController>().update();
    //                       },
    //                       filename: filename,
    //                       about: category,
    //                       money: money,
    //                       title: title,
    //                     );

    //                     if (groupedData.containsKey(date)) {
    //                       groupedData[date]!.add(item);
    //                     } else {
    //                       groupedData[date] = [item];
    //                     }
    //                   }

    //                   final List<Widget> groupWidgets = [];

    //                   groupedData.forEach((date, dataItems) {
    //                     final List<Widget> rowChildren = dataItems
    //                         .map(
    //                           (dataItem) => Column(
    //                             children: [
    //                               DataListItem(
    //                                 iconaction: () async {
    //                                   final String content =
    //                                       await home.readFileContent(
    //                                     "/storage/emulated/0/Download/Money/Outcome/${dataItem.filename}.txt",
    //                                   );

    //                                   debugPrint(content);

    //                                   await Get.toNamed(
    //                                     DetailPage.name,
    //                                     id: Get.find<
    //                                             NavigationScreenController>()
    //                                         .currentPage
    //                                         .value,
    //                                   );
    //                                 },
    //                                 filename: dataItem.filename,
    //                                 about: dataItem.about,
    //                                 money: dataItem.money,
    //                                 title: dataItem.title,
    //                               ),
    //                             ],
    //                           ),
    //                         )
    //                         .toList();

    //                     groupWidgets.add(
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Center(
    //                             child: Text(
    //                               date,
    //                               style: const TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ),
    //                           Column(
    //                             children: rowChildren,
    //                           ),
    //                           const SizedBox(height: 20),
    //                         ],
    //                       ),
    //                     );
    //                   });

    //                   return Column(
    //                     children: [
    //                       ...groupWidgets,
    //                     ],
    //                   );
    //                 }
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );

    /// -----------------  new design ----------------------
    return Scaffold(
      // backgroundColor: const Color(0xffEEEEEE),
      backgroundColor: const Color(0xff6633CC),
      appBar: AppBar(
        backgroundColor: const Color(0xff6633CC),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 170,
              // color: const Color(0xff6633CC),
              decoration: const BoxDecoration(
                color: Color(0xff6633CC),
              ),
              child: Column(
                children: [
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            home.totalMoney.toString(),
                            // home.total.toString(),
                            style: const TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            " MMK",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const Center(
                    child: Text(
                      "Total balance",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height,
              decoration: const BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            debugPrint("income");

                            home.showincome();
                          },
                          child: Text(
                            "Income",
                            style: TextStyle(
                              fontSize: 20,
                              color: controller.isincome.value != true
                                  ? const Color(0xff707070)
                                  : const Color(0xFFFF6633),
                              fontWeight: FontWeight.w400,
                              decoration: controller.isincome.value != true
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                              decorationColor: const Color(0xFFFF6633),
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            debugPrint("expense");

                            home.showexpense();
                          },
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              fontSize: 20,
                              color: controller.isincome.value
                                  ? const Color(0xff707070)
                                  : const Color(0xFFFF6633),
                              fontWeight: FontWeight.w400,
                              decoration: controller.isincome.value
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                              decorationColor: const Color(0xFFFF6633),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  Obx(() {
                    if (home.isincome.value) {
                      return Form(
                        key: income.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16.0),
                                  AuthTextField(
                                    filledColor: Colors.white,
                                    textColor: const Color(0xff707070),
                                    hintText: "Money",
                                    labeltext: "Money",
                                    controller: income.getmoneyController,
                                    // validator: ReuseableFunction.validatenumber,
                                    validator: (data) {
                                      if (data!.isEmpty) {
                                        return "Need To Fill This Field";
                                      }
                                      if (int.tryParse(data) == null) {
                                        return "Please enter a valid integer amount";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                        ),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month + 1,
                                          DateTime.now().day,
                                        ),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          final formattedDate =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(selectedDate);

                                          // Update the date of birth field
                                          income.getdateController.text =
                                              formattedDate;
                                        }
                                      });
                                    },
                                    child: AbsorbPointer(
                                      child: AuthTextField(
                                        // filledColor: const Color(0xff0A4D68),
                                        filledColor: Colors.white,
                                        textColor: const Color(0xff707070),
                                        isNormal: true,
                                        hintText: "Select Date",
                                        controller: income.getdateController,
                                        icon: Icons.date_range,
                                        // validator: ReuseableFunction.validateString,
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return "Need To Fill This Field";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            await income
                                                .openCategorySelectionBottomSheet(); // Call function to open bottom sheet
                                          },
                                          child: AbsorbPointer(
                                            child: AuthTextField(
                                              // filledColor: const Color(0xff0A4D68),
                                              filledColor: Colors.white,
                                              textColor:
                                                  const Color(0xff707070),
                                              inputcolor: Colors.black,
                                              isNormal: true,
                                              hintText: "Select Categories",
                                              icon: Icons
                                                  .arrow_drop_down_outlined,
                                              controller: income
                                                  .getcategoriesController,
                                              validator: (data) {
                                                if (data == null ||
                                                    data.isEmpty) {
                                                  return "Fillled To data";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  AuthTextField(
                                    // filledColor: const Color(0xff0A4D68),
                                    filledColor: Colors.white,
                                    textColor: const Color(0xff707070),
                                    isNormal: true,
                                    hintText: "Note",

                                    labeltext: "Note",
                                    maxline: 2,
                                    controller: income.getdescriptionController,
                                    validator: (data) {
                                      if (data == null || data.isEmpty) {
                                        return "Fillled To data";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  Obx(() {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          await income.showImagePickerDialog();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: (income.selectedImage
                                                          .value !=
                                                      null)
                                                  ? Image.file(
                                                      income
                                                          .selectedImage.value!,
                                                    ).image
                                                  : Image.asset(
                                                      Assets.icons.gallery.path,
                                                    ).image,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  cusbutton(
                                    title: "Save",
                                    onPressed: () async {
                                      debugPrint("Get database");

                                      await income.store();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Form(
                        key: expense.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16.0),
                                  AuthTextField(
                                    filledColor: Colors.white,
                                    textColor: const Color(0xff707070),
                                    hintText: "Money",
                                    labeltext: "Money",
                                    controller: expense.getmoneyController,
                                    validator: (data) {
                                      if (data!.isEmpty) {
                                        return "Need To Fill This Field";
                                      }
                                      if (int.tryParse(data) == null) {
                                        return "Please enter a valid integer amount";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                        ),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month + 1,
                                          DateTime.now().day,
                                        ),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          final formattedDate =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(selectedDate);

                                          // Update the date of birth field
                                          expense.getdateController.text =
                                              formattedDate;
                                        }
                                      });
                                    },
                                    child: AbsorbPointer(
                                      child: AuthTextField(
                                        // filledColor: const Color(0xff0A4D68),
                                        filledColor: Colors.white,
                                        textColor: const Color(0xff707070),
                                        isNormal: true,
                                        hintText: "Select Date",
                                        icon: Icons.date_range_outlined,
                                        controller: expense.getdateController,
                                        // validator: ReuseableFunction.validateString,
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return "Need To Fill This Field";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            await expense
                                                .openCategorySelectionBottomSheet(); // Call function to open bottom sheet
                                          },
                                          child: AbsorbPointer(
                                            child: AuthTextField(
                                              // filledColor: const Color(0xff0A4D68),
                                              filledColor: Colors.white,
                                              textColor:
                                                  const Color(0xff707070),
                                              inputcolor: Colors.black,
                                              isNormal: true,
                                              icon: Icons
                                                  .keyboard_arrow_down_sharp,
                                              hintText: "Select Categories",
                                              controller: expense
                                                  .getcategoriesController,
                                              validator: (data) {
                                                if (data == null ||
                                                    data.isEmpty) {
                                                  return "Fillled To data";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  AuthTextField(
                                    // filledColor: const Color(0xff0A4D68),
                                    filledColor: Colors.white,
                                    textColor: const Color(0xff707070),
                                    isNormal: true,
                                    hintText: "Note",
                                    labeltext: "Note",
                                    maxline: 2,
                                    controller:
                                        expense.getdescriptionController,
                                    validator: (data) {
                                      if (data == null || data.isEmpty) {
                                        return "Fillled To data";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  Obx(() {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          await expense.showImagePickerDialog();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: (expense.selectedImage
                                                          .value !=
                                                      null)
                                                  ? Image.file(
                                                      expense
                                                          .selectedImage.value!,
                                                    ).image
                                                  : Image.asset(
                                                      Assets.icons.gallery.path,
                                                    ).image,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  cusbutton(
                                    title: "Save",
                                    onPressed: () async {
                                      await expense.store();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    /// ----------------- end new design
  }
}
