import 'package:flutter/material.dart';

class PatientList extends ChangeNotifier {
  PatientList({ required this.patientList });

  List<Patient> patientList;

  void setSelected(List<Patient> newPatientList) async {
    patientList = newPatientList;
    notifyListeners();
  }

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