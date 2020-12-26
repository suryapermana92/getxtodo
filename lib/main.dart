import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/auth/auth.controller.dart';
import 'package:getxtodo/get_routes.dart';
import 'package:getxtodo/views/theme_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthController authController = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App with Get Package',
      defaultTransition: Transition.rightToLeft,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: "/splashscreen",
      getPages: AppRoutes.routes,
    );
  }
}
