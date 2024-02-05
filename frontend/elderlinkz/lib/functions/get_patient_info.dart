import 'package:elderlinkz/classes/http.dart';

Future<String?> getPatientInfo({
  required Http httpClient,
  String? Function(Map<String, List<Map<String, dynamic>>>)? onSuccess,
  String? Function(Map<String, dynamic>)? onError,
  String? Function()? onUnknownError,
}) async {

  onUnknownError ??= () => "An error has occurred";

  try {

    final Map<String, dynamic> patientsBody = await httpClient.get(path: "/elderlinkz/patients",);

    if (patientsBody.containsKey("patients") && onSuccess != null) {

      // Convert patients list from dynamic to List<Map<String, dynamic>>
      List<Map<String, dynamic>> patientsList = (patientsBody["patients"] as List)
        .map((patientData) => patientData as Map<String, dynamic>)
        .toList();

      Map<String, List<Map<String, dynamic>>> parsedPatientsBody = {
        "patients": patientsList
      };

      return onSuccess(parsedPatientsBody);

    }
    else if (patientsBody.containsKey("error")) {
      onError ??= (patientsBody) => patientsBody["error"];

      return onError(patientsBody);
    }
    else {
      return onUnknownError();
    }

  } catch(e) {

    return onUnknownError();

  }

}