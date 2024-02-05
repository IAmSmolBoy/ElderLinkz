import 'dart:convert';

import 'package:flutter/material.dart';

class AlertList extends ChangeNotifier {

  AlertList({ required this.alerts });

  Map<String, Alert> alerts; 

  void addAlert(String patient, String alertMsg) {

    alerts[patient] = Alert(
      alertMsg: alertMsg,
      alertDateTime: DateTime.now()
    );

    notifyListeners();

  }

  Map<String, Map<String, dynamic>> toMap() =>
    alerts
      .map(
        (key, value) =>
          MapEntry(
            key,
            value.toMap()
          )
      );

    String toJson() =>
      json.encode(toMap());

}

class Alert {
  
  const Alert({
    required this.alertMsg,
    required this.alertDateTime
  });

  final String alertMsg;
  final DateTime alertDateTime;

  Map<String, dynamic> toMap() =>
    {
      "alertMsg": alertMsg,
      "alertDateTime": alertDateTime
    };

  String toJson() =>
    json
      .encode(toMap());

}