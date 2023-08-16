import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/componements/appbar.dart";
import "package:money_budget/detail/controller/editcontroller.dart";
import "package:money_budget/detail/view/editpage.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class DetailPage extends GetView<HomeController> {
  DetailPage({super.key});
  static const String name = "/detail_page";
  final HomeController home = Get.put(HomeController());
  final EditController edit = Get.put(EditController());

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> arguments = Get.arguments;
    // final String content = arguments['content'];
    debugPrint(Get.arguments); //null
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AllAppBar(
        title: "Detail Page",
        leading: UnconstrainedBox(
          child: GestureDetector(
            onTap: () {
              Get.back(
                id: Get.find<NavigationScreenController>().currentPage.value,
              );
              // Get.back();
            },
            child: AppBarAction(
              data: Assets.icons.leftarrow.path,
            ),
          ),
        ),
        action: IconButton(
          padding: const EdgeInsets.all(10),
          onPressed: () async {
            debugPrint("Edit");
            await Get.toNamed(
              Editpage.name,
              id: Get.find<NavigationScreenController>().currentPage.value,
            );
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.all(16),
      //   child: Obx(() {
      //     return Text(home.Date.toString());
      //   }),
      //   // child: Text(content), // Display the content here
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Container(
            height: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Title  ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "     : ",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${home.title} ",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Money",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "     :",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        edit.moneyedit.isNotEmpty
                            ? edit.moneyedit.toString()
                            : home.money.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      child: Text(
                        "Category",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "     :",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        edit.categoryedit.isNotEmpty
                            ? edit.categoryedit.toString()
                            : home.category.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      child: Text(
                        "Date",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "     :",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        edit.dateedit.isNotEmpty
                            ? edit.dateedit.toString()
                            : home.date.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "     :",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        edit.descriptionedit.isNotEmpty
                            ? edit.descriptionedit.toString()
                            : home.description.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: () async {
                    debugPrint(
                      "/storage/emulated/0/Download/Money/Outcome/${home.filename}.txt",
                    );
                    await Get.dialog(
                      AlertDialog(
                        title: const Text("Alert!"),
                        content: const Text("Are you Sure delete"),
                        actions: [
                          TextButton(
                            child: const Text("Close"),
                            onPressed: () => Get.back(),
                          ),
                          TextButton(
                            onPressed: () async {
                              await edit.deleteFileAndRefreshUI(
                                "/storage/emulated/0/Download/Money/Outcome/${home.filename}.txt",
                              );
                              await Get.offAllNamed("/");
                            },
                            child: const Text("Yes"),
                          )
                        ],
                      ),
                    );
                  },
                  child: const Text("Delete "),
                ),
                // Text("Category: ${home.category}"),
                // Text("Date: ${home.date}"),
                // Text("Description: ${home.description}"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
