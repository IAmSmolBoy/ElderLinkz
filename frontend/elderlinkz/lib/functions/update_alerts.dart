// Update alerts when data is received
import 'package:elderlinkz/classes/alerts.dart';
import 'package:elderlinkz/classes/notifications.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AlertList updateAlerts(
  BuildContext context,
  PatientList patients,
  AlertList? alertListClass
) {

  List<Patient> patientList = patients.patientList;

  alertListClass = alertListClass ??
    AlertList(alerts: {});
  Map<String, Alert> alertList = alertListClass.alerts;
    
  for (Patient patient in patientList) {

    String notifMsg = "${patient.name} ";
    List<String> notifList = [];

    if (patient.temperature > 37.5) { notifList.add("has high temperature"); }
    if (patient.gsr >= 35) { notifList.add("has intense emotional"); }
    if (patient.oxygen < 95) { notifList.add("is lacking oxygen"); }
    if (patient.humidity >= 100) { notifList.add("has defacted"); }

    notifMsg += notifList.join(", ");
    
    if (
      !alertList.containsKey(patient.name) ||
      (
        notifMsg != "${patient.name} " &&
        alertList.containsKey(patient.name) &&
        alertList[patient.name]!.alertMsg != notifMsg
      )
    ) {

      alertListClass
        .addAlert(
          patient.name,
          notifMsg
        );

      if (context.watch<SendNotifs>().sendNotifs) {
        
        notif
          .showNotification(
            title: patient.name,
            body: notifMsg
          );
          
      }

    }

  }

  return alertListClass;

}
