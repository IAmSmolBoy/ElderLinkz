import 'package:flutter/material.dart';

class AlertList extends ChangeNotifier {

  AlertList({ required this.alertList });

  List<Alert> alertList; 

}

class Alert {
  
  const Alert({
    required this.alertMsg,
    required this.alertDateTime
  });

  final String alertMsg;
  final DateTime alertDateTime;

}