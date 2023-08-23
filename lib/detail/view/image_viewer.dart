import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/componements/appbar.dart";
import "package:money_budget/gen/assets.gen.dart";
import "package:money_budget/home/controllers/homecontroller.dart";
import "package:money_budget/z_application/navigation/controller/navigation_controller.dart";
import "package:photo_view/photo_view.dart";

class FullScreenImageViewer extends GetView<HomeController> {
  FullScreenImageViewer({super.key});

  static const String name = "/view_image";
  HomeController home = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AllAppBar(
        // color: Colors.transparent,
        title: "Image View",
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
          },
          icon: const Icon(
            Icons.pending_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: PhotoView(
        // imageProvider: FileImage(File(home.imagepath.value)),
        imageProvider: FileImage(File(home.imagepath.value)),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      ),
    );
  }
}
