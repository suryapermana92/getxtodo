import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/auth/auth.controller.dart';

class EventsPage extends StatelessWidget {
  final AuthController authController = AuthController.to;
  @override
  Widget _eventListItem(context, index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () {
            Get.snackbar("Success", 'this is event ${index + 1}',
                snackPosition: SnackPosition.BOTTOM);
          },
          child: Container(
            child: Column(
              children: [
                Text(
                  'Event Name ${index + 1}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Event Decscription ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _eventListItem(context, index);
              })),
    );
  }
}
