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
  final String name, ic, race, emergencyContact, gender;
  final DateTime dateOfBirth;
  final int ward, age;
  final double oxygen, heartRate, gsr, humidity, temperature;

  const Patient({
    required this.name,
    required this.ic,
    required this.race,
    required this.emergencyContact,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.ward,
    required this.oxygen,
    required this.heartRate,
    required this.gsr,
    required this.humidity,
    required this.temperature
  });
}