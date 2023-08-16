import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:money_budget/componements/appbar.dart";
import "package:money_budget/detail/controller/editcontroller.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/util/cusbutton.dart";
import "package:money_budget/util/text_filed.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class Editpage extends GetView<EditController> {
  Editpage({super.key});
  @override
  final EditController controller = Get.put(EditController());
  final HomeController home = Get.put(HomeController());

  static const String name = "/edit_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AllAppBar(
        title: "Edit Page",
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
          onPressed: () {
            debugPrint("Edit");
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        controller.getmoneyController.text =
            controller.moneyedit.value.isNotEmpty
                ? controller.moneyedit.value
                : home.money.value.toString();
        controller.getcategoriesController.text =
            controller.categoryedit.value.isNotEmpty
                ? controller.categoryedit.value
                : home.category.value.toString();
        controller.getdateController.text = controller.dateedit.value.isNotEmpty
            ? controller.dateedit.value
            : home.date.value.toString();
        controller.getdescriptionController.text =
            controller.descriptionedit.value.isNotEmpty
                ? controller.descriptionedit.value
                : home.description.value.toString();

        // controller.getcategoriesController.text = home.category.value ?? " ";
        // controller.getdateController.text = home.date.value ?? " ";
        // controller.getdescriptionController.text =
        //     home.description.value ?? " ";

        return SafeArea(
          child: SingleChildScrollView(
            child: DecoratedBox(
              // padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.cyan,

                // gradient: CusThemeData.gradientColor,
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 16.0),
                          AuthTextField(
                            // filledColor: const Color(0xff0A4D68),
                            filledColor: Colors.cyan,
                            textColor: const Color(0xffFFFFFF),
                            hintText: home.money.toString(),
                            // labeltext: home.money.toString(),
                            controller: controller.getmoneyController,
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
                                // initialDate: DateTime(DateTime.now().year - 1,
                                //     DateTime.now().month, DateTime.now().day),
                                initialDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                                firstDate: DateTime(1900),
                                // lastDate: DateTime(DateTime.now().year - 20,
                                //     DateTime.now().month, DateTime.now().day),
                                lastDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month + 1,
                                  DateTime.now().day,
                                ),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  final formattedDate = DateFormat("yyyy-MM-dd")
                                      .format(selectedDate);

                                  // Update the date of birth field
                                  controller.getdateController.text =
                                      formattedDate;
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: AuthTextField(
                                // filledColor: const Color(0xff0A4D68),
                                filledColor: Colors.cyan,
                                textColor: const Color(0xffFFFFFF),
                                isNormal: true,

                                hintText: "Date",
                                controller: controller.getdateController,
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
                          GestureDetector(
                            onTap: () async {
                              await controller
                                  .openCategorySelectionBottomSheet(); // Call function to open bottom sheet
                            },
                            child: AbsorbPointer(
                              child: AuthTextField(
                                // filledColor: const Color(0xff0A4D68),
                                filledColor: Colors.cyan,
                                textColor: const Color(0xffFFFFFF),
                                inputcolor: Colors.black,
                                isNormal: true,
                                // labeltext: "Category",
                                hintText: home.category.toString(),
                                controller: controller.getcategoriesController,
                                validator: (data) {
                                  if (data == null || data.isEmpty) {
                                    return "Fillled To data";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          AuthTextField(
                            // filledColor: const Color(0xff0A4D68),
                            filledColor: Colors.cyan,
                            textColor: const Color(0xffFFFFFF),
                            isNormal: true,
                            labeltext: "Description",
                            hintText: "Description",
                            controller: controller.getdescriptionController,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return "Fillled To data";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),
                          cusbutton(
                            title: "Update Data",
                            onPressed: () async {
                              debugPrint("Get database");

                              await controller.store();

                              // Call the method to update the money lists
                              await home.readIncomeFromFilesAndAddToMoneyList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
