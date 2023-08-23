import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/z_application/controller_binder.dart";
import "package:money_budget/z_application/router.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Instantiate the PermissionController

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Money Budget",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: ControllerBindings(),

      getPages: getRouteList,
      // home: const Homepage(),
      initialRoute: "/",
    );
  }
}
