import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/outcome/controller/outcomecontroller.dart";

class CategoryPage extends GetView<CategoryController> {
  CategoryPage({super.key});
  static const String name = "/category";
  final CategoryController categoryController = Get.put(CategoryController());
  final HomeController homecontroller = Get.put(HomeController());
  final IncomeController incomecontroller = Get.put(IncomeController());
  // final IncomeController incomecontroller = Get.find<IncomeController>();
  final OutcomeController outcomecontroller = Get.put(OutcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Center(child: Text("Category")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF088395)),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.showincome();
                              },
                              child: Container(
                                width: 171,
                                decoration: BoxDecoration(
                                  color: controller.isincome.value != true
                                      ? Colors.white
                                      : const Color(0xFF0A4D68),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Income",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: controller.isincome.value != true
                                          ? const Color(0xFF088395)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.showexpense();
                              },
                              child: Container(
                                width: 171,
                                decoration: BoxDecoration(
                                  color: controller.isincome.value
                                      ? Colors.white
                                      : const Color(0xFF0A4D68),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Expense",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: controller.isincome.value
                                          ? const Color(0xFF088395)
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (controller.isincome.value) {
                      debugPrint(
                        incomecontroller.categories.length.toString(),
                      );
                      debugPrint(
                        categoryController.incomecategories.length.toString(),
                      );
                      return Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: incomecontroller.categories.length,
                            // itemCount:
                            // categoryController.incomecategories.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      incomecontroller.categories[index],
                                      // categoryController
                                      //     .incomecategories[index],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              debugPrint(
                                "============== Income page ================",
                              );
                              await incomecontroller.addcategory();
                              await incomecontroller.getCategoriesFromStorage();
                              controller.showincome();
                            },
                            child: Container(
                              width: Get.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                child: Text("Add income category"),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      debugPrint(
                        outcomecontroller.outcomecategories.length.toString(),
                      );
                      debugPrint(
                        categoryController.expensecategories.length.toString(),
                      );
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              debugPrint(
                                "============== Expense page ================",
                              );
                              await outcomecontroller.addcategory();
                              await outcomecontroller
                                  .getCategoriesFromStorage();
                              controller.showexpense();
                            },
                            child: Container(
                              width: Get.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                child: Text("Add expense category"),
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                outcomecontroller.outcomecategories.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  outcomecontroller.outcomecategories[index],
                                ),
                              );
                            },
                          ),
                        ],
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
  }
}
