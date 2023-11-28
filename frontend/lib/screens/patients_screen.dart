import 'package:elderlinkz/classes/patient.dart';
import 'package:elderlinkz/widgets/patient_list.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({ super.key });

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  List<Patient> patients = const [
    Patient(name: "Hong Rui", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Rui Dong", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Xing Xiao", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "James", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Robby", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Frederick", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  ];

  @override
  Widget build(BuildContext context) {
    return PatientList(patients: patients);
  }
}