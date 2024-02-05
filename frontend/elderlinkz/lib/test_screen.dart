import 'dart:math';

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
                title: "test ${Random().nextInt(20)}",
                body: "test2",
                payload: "{test3: test4}"
              );

          },
          child: const Text("Test")
        ),
      ),
    );
  }
}