import 'package:flutter/material.dart';

class WardList extends ChangeNotifier {
  WardList({ required this.wardList });

  List<WardData> wardList;

  void setSelected(List<WardData> newWardList) async {
    wardList = newWardList;
    notifyListeners();
  }

}

class WardData {

  const WardData({
    required this.id,
    required this.patients
  });

  final int id;
  final List<Patient> patients;

}

class Patient {
  final String name;
  final int room;
  final double oxygen, heartRate, gsr, humidity, temperature;

  const Patient({
    required this.name,
    required this.room,
    required this.oxygen,
    required this.heartRate,
    required this.gsr,
    required this.humidity,
    required this.temperature
  });
}