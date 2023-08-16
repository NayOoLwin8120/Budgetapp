import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:money_budget/componements/appbar.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/income/controllers/income_controller.dart";
import "package:money_budget/util/cusbutton.dart";
import "package:money_budget/util/text_filed.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";

class IncomePage extends GetView<IncomeController> {
  IncomePage({super.key});
  static const String name = "/income";
  @override
  final IncomeController controller = Get.put(IncomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AllAppBar(
        title: "Income",
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
            debugPrint("Add Category");
            await controller.addcategory();
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
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
                          hintText: "Money",
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
                                final formattedDate = DateFormat("dd-MM-yyyy")
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
                              hintText: "Select Date",
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
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
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
                                    hintText: "Select Categories",
                                    controller:
                                        controller.getcategoriesController,
                                    validator: (data) {
                                      if (data == null || data.isEmpty) {
                                        return "Fillled To data";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.all(10),
                              onPressed: () async {
                                debugPrint("Add Category");
                                await controller.addcategory();
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        AuthTextField(
                          // filledColor: const Color(0xff0A4D68),
                          filledColor: Colors.cyan,
                          textColor: const Color(0xffFFFFFF),
                          isNormal: true,
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

                        // Obx(() {
                        //   final appState = controller.appState.value;

                        //   if (appState == ApiState.loading) {
                        //     return const Center(
                        //       child: CircularProgressIndicator(
                        //         color: Colors.amber,
                        //       ),
                        //     );
                        //   } else if (appState == ApiState.error) {
                        //     return Cus_Button(
                        //       title: 'Regiester',
                        //       onPressed: () {
                        //         debugPrint(appState);
                        //         controller.register();
                        //       },
                        //     );
                        //   } else {
                        //     return Cus_Button(
                        //       title: 'Regiester',
                        //       onPressed: () {
                        //         debugPrint(appState);
                        //         debugPrint(controller
                        //             .getallergiesController.text.length);
                        //         // Get.to(OtpPage());
                        //         controller.register();
                        //         // Get.offAll(NavigationScreen());
                        //       },
                        //     );
                        //   }
                        // }),
                        cusbutton(
                          title: "Add",
                          onPressed: () async {
                            debugPrint("Get database");

                            await controller.store();
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
      ),
    );
  }
}
