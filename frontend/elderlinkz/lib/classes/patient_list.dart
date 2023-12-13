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
  final int ward, age;
  final double oxygen, heartRate, gsr, humidity, temperature;
  final DateTime dateOfBirth;

  const Patient({
    required this.name,
    required this.ic,
    required this.race,
    required this.emergencyContact,
    required this.gender,
    required this.age,
    required this.ward,
    required this.dateOfBirth,
    this.oxygen = 0.0,
    this.heartRate = 0.0,
    this.gsr = 0.0,
    this.humidity = 0.0,
    this.temperature = 0.0,
  });

  static Patient fromMap(Map<String, dynamic> patientData) {
    for (MapEntry<String, dynamic> data in patientData.entries) {
      debugPrint("${data.key}: ${data.value}");
    }

    return Patient(
      name: patientData["name"],
      ic: patientData["ic"],
      race: patientData["race"],
      emergencyContact: patientData["emergencyContact"],
      gender: patientData["gender"],
      age: dynamicToInt(patientData["age"]),
      ward: dynamicToInt(patientData["ward"]),
      dateOfBirth: dynamicToDateTime(patientData["dateOfBirth"]),
      oxygen: dynamicToDouble(patientData["oxygen"]),
      heartRate: dynamicToDouble(patientData["heartRate"]),
      gsr: dynamicToDouble(patientData["gsr"]),
      humidity: dynamicToDouble(patientData["humidity"]),
      temperature: dynamicToDouble( patientData["temperature"]),
    );
  }

  static Patient fromJson(String jsonData) {
    Map<String, dynamic> parsedData = json.decode(jsonData);

    return Patient.fromMap(parsedData);
  }
}

DateTime dynamicToDateTime(dynamic value) =>
  value is DateTime ?
    value :
    DateTime.tryParse(value) ??
    DateTime.now();

int dynamicToInt(dynamic value) =>
  value is int ?
    value :
    int.tryParse(value) ??
    0;

double dynamicToDouble(dynamic value) =>
  value is double ?
    value :
    double.tryParse(value ?? "0.0") ??
    0.0;