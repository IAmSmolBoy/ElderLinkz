import 'package:elderlinkz/classes/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

const List<Patient> patients = [
  Patient(name: "Hong Rui", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  Patient(name: "Rui Dong", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  Patient(name: "Xing Xiao", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  Patient(name: "James", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  Patient(name: "Robby", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  Patient(name: "Frederick", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
];