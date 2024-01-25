import 'package:elderlinkz/classes/notifications.dart';
import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({ super.key });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {

            debugPrint("test");

            notif
              .showNotification(
                title: "test",
                body: "test2",
                payload: "{test3: test4}"
              )
              .then((value) => debugPrint(value.toString()))
              .catchError((e) => debugPrint(e));

          },
          child: const Text("Test")
        ),
      ),
    );
  }
}