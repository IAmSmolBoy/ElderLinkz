import 'dart:convert';

// import 'package:provider/provider.dart';

// class PatientList extends StreamProvider {
//   PatientList({
//     super.key, 
//     required super.create,
//     required super.initialData,
//     required this.patientList,
//   });

//   final List<Patient> patientList;

//   void setPatientList(List<Patient> newPatientList) async {

//     patientList = newPatientList;

//   }

//   Patient updatePatientData(int index, Map<String, dynamic> patientData) {

//     patientList[index] = Patient
//       .fromMap({
//         ...patientList[index]
//           .toMap(),
//         ...patientData
//       });

//     return patientList[index];

//   }

//   void updateData(Map<String, dynamic> patientData) {

//     patientList = patientList
//       .map((patient) => Patient.fromMap({
//         ...patient
//           .toMap(),
//         ...patientData
//       }))
//       .toList();

//   }

  // static List<Patient> fromJsonObj(Map<String, dynamic> jsonObj) => 
  //   (jsonObj["patients"] as List)
  //     .map(
  //       (patient) =>
  //         Patient
  //           .fromMap(patient as Map<String, dynamic>)
  //     )
  //     .toList();

// }

class PatientList {

  PatientList({ required this.patientList, });

  List<Patient> patientList;

  static PatientList fromJsonObj(Map<String, dynamic> jsonObj) => 
    PatientList(
      patientList: (jsonObj["patients"] as List)
        .map(
          (patient) =>
            Patient
              .fromMap(patient as Map<String, dynamic>)
        )
        .toList()
    );

}

class Patient {
  final String name, ic, race, emergencyContact, gender;
  final int ward, age, status;
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
    this.status = -1
  });

  static Patient fromMap(Map<String, dynamic> patientData) {
    // for (MapEntry<String, dynamic> data in patientData.entries) {
    //   debugPrint("${data.key}: ${data.value}");
    // }

    return Patient(
      name: patientData["name"],
      ic: patientData["ic"],
      race: patientData["race"],
      emergencyContact: patientData["emergencyContact"],
      gender: patientData["gender"],
      age: dynamicToInt(patientData["age"]),
      ward: dynamicToInt(patientData["ward"]),
      dateOfBirth: dynamicToDateTime(patientData["dateOfBirth"]),
      oxygen: dynamicToDouble(patientData["OXY"]),
      heartRate: dynamicToDouble(patientData["heartRate"]),
      gsr: dynamicToDouble(patientData["HAPP"]),
      humidity: dynamicToDouble(patientData["HUMI"]),
      temperature: dynamicToDouble(patientData["TMP"]),
      status: dynamicToInt(patientData["status"])
    );
  }

  static Patient fromJson(String jsonData) {
    Map<String, dynamic> parsedData = json.decode(jsonData);

    return Patient.fromMap(parsedData);
  }

  Map<String, dynamic> toMap() =>
    {
      "name": name,
      "ic": ic,
      "race": race,
      "emergencyContact": emergencyContact,
      "gender": gender,
      "age": dynamicToInt(age),
      "ward": dynamicToInt(ward),
      "dateOfBirth": dynamicToDateTime(dateOfBirth),
      "oxygen": dynamicToDouble(oxygen),
      "heartRate": dynamicToDouble(heartRate),
      "gsr": dynamicToDouble(gsr),
      "humidity": dynamicToDouble(humidity),
      "temperature": dynamicToDouble(temperature),
      "status": dynamicToInt(status)
    };
}

DateTime dynamicToDateTime(dynamic value) =>
  value is DateTime ?
    value :
    value is String ?
      DateTime.tryParse(value) ??
        DateTime.now() :
      DateTime.now();

int dynamicToInt(dynamic value) =>
  value is int ?
    value :
    value is String ?
      int.tryParse(value) ??
        0 :
      0;

double dynamicToDouble(dynamic value) =>
  value is double ?
    value :
    value is String ?
      double.tryParse(value) ??
        0.0 :
      0.0;

