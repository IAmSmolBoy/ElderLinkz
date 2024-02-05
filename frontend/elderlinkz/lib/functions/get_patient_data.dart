// import 'dart:convert';

import 'package:elderlinkz/classes/http.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/functions/show_snackbar.dart';
import 'package:flutter/material.dart';

Stream<PatientList> getData(BuildContext context, Http httpClient) async* {
  while (true) {
    try {

      Map<String, dynamic> patients = await httpClient.get(path: "/elderlinkz/patients");
      Map<String, dynamic> data = await httpClient.get(path: "/elderlinkz/data");

      // debugPrint("test $data");

      if (data.containsKey("error")) { throw data["error"]; }
      else {

        List<Patient> patientList = (patients["patients"] as List)
          .map(
            (patient) =>
              Patient
                .fromMap({
                  ...patient,
                  ...data
                })
          )
          .toList();

        yield PatientList(patientList: patientList);

      }

    } catch(e) {

      debugPrint("$e");
      showSnackBar(context, e.toString());

    }

    await Future.delayed(const Duration(seconds: 1));
  }
}