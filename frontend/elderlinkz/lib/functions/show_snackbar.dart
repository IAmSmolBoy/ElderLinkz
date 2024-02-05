import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String e) {
  debugPrint(e.toString());

  ScaffoldMessenger
    .of(context)
    .showSnackBar(
      SnackBar(
        content: Text(
          e.toString()
        )
      )
    );
}