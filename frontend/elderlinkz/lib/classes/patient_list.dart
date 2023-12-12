import 'dart:convert';

import 'package:flutter/material.dart';

class PatientList extends ChangeNotifier {
  PatientList({ required this.patientList });

  List<Patient> patientList;

  void setPatientList(List<Patient> newPatientList) async {
    patientList = newPatientList;
    notifyListeners();
  }

  Patient updatePatientData(int index, Map<String, dynamic> patientData) {
    patientList[index] = Patient(
      name: patientList[index].name,
      ic: patientList[index].ic,
      race: patientList[index].race,
      emergencyContact: patientList[index].emergencyContact,
      gender: patientList[index].gender,
      dateOfBirth: patientList[index].dateOfBirth,
      age: patientList[index].age,
      ward: patientList[index].ward,
      oxygen: double.tryParse(patientData["oxygen"] ?? "0.0") ?? 0.0,
      heartRate: double.tryParse(patientData["heartRate"] ?? "0.0") ?? 0.0,
      gsr: double.tryParse(patientData["gsr"] ?? "0.0") ?? 0.0,
      humidity: double.tryParse(patientData["humidity"] ?? "0.0") ?? 0.0,
      temperature: double.tryParse(patientData["temperature"] ?? "0.0") ?? 0.0,
    );

    return patientList[index];
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

  static Patient fromJson(String jsonData) {
    Map<String, dynamic> parsedData = json.decode(jsonData);

    return Patient(
      name: parsedData["name"],
      ic: parsedData["ic"],
      race: parsedData["race"],
      emergencyContact: parsedData["emergencyContact"],
      gender: parsedData["gender"],
      dateOfBirth: parsedData["dateOfBirth"],
      age: parsedData["age"],
      ward: parsedData["ward"],
      oxygen: parsedData["oxygen"],
      heartRate: parsedData["heartRate"],
      gsr: parsedData["gsr"],
      humidity: parsedData["humidity"],
      temperature: parsedData["temperature"],
    );
  }
}