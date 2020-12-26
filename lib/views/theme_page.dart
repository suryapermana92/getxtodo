import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/auth/auth.controller.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
  );
}

class ThemePage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget _eventListItem(context, theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {
            print(theme);

            if (theme == 'light') {
              Get.changeThemeMode(ThemeMode.light);
            } else if (theme == 'dark') {
              Get.changeThemeMode(ThemeMode.dark);
            }
            Get.snackbar("Success", 'Changed to ${theme} theme',
                snackPosition: SnackPosition.BOTTOM);
          },
          child: Container(
            child: Column(
              children: [
                Text(
                  '${theme} theme',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all()),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _eventListItem(context, 'light'),
                _eventListItem(context, 'dark')
              ],
            )));
  }
}
