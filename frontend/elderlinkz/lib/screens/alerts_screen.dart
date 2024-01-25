import 'package:elderlinkz/classes/alerts.dart';
// import 'package:elderlinkz/classes/http.dart';
// import 'package:elderlinkz/classes/patient_list.dart';
// import 'package:elderlinkz/classes/socket_address.dart';
// import 'package:elderlinkz/functions/get_patient_info.dart';
// import 'package:elderlinkz/screens/patient_details_screen.dart';
import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({ super.key });

  @override
  Widget build(BuildContext context) {

    // getPatientData(
    //   httpClient: Http(socketAddress: context.watch<SocketAddress>().socketAddress),
    //   onSuccess: (patientBody) {
    //     context
    //       .read<PatientList>()
    //       .setPatientList(
    //         patientBody["patients"]
    //           ?.map(
    //             (patient) =>
    //               Patient
    //                 .fromMap(patient)
    //           )
    //           .toList() ??
    //           []
    //       );

    //     return null;
    //   }
    // );

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text("Alerts",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...context
            .read<AlertList>().alertList
            .map(
              (e) =>
                Container(
                  color: Colors.red,
                )
            )
        ],
      ),
      // child: ListView(
      //   children: [
      //     const SizedBox(height: 30),
      //     const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //       child: Text(
      //         'Patients',
      //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      //       ),
      //     ),
      //     GroupedListView<Patient, String>(
      //       shrinkWrap: true,
      //       elements: context.read<PatientList>().patientList,
      //       useStickyGroupSeparators: true,
      //       floatingHeader: true,
      //       order: GroupedListOrder.ASC,
      //       groupBy: (element) => element.name.toString().substring(0, 1),
      //       itemComparator: (item1, item2) =>
      //         item1.name.compareTo(item2.name),
      //       groupSeparatorBuilder: (String groupByValue) => SizedBox(
      //         width: MediaQuery.of(context).size.width,
      //         child: Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 16),
      //           child: Text(
      //             groupByValue.substring(0, 1),
      //             textAlign: TextAlign.right,
      //             style: const TextStyle(
      //                 fontWeight: FontWeight.w600, fontSize: 18),
      //           ),
      //         ),
      //       ),
      //       itemBuilder: (context, Patient patient) {
      //         return Column(
      //           children: [
      //             ListTile(
      //               onTap: () {
      //                 Navigator.push(context,
      //                   PageTransition(
      //                     type: PageTransitionType.rightToLeft,
      //                     child: PatientDetailsScreen(patient: patient),
      //                   )
      //                 );
      //               },
      //               leading: CircleAvatar(
      //                 radius: 25,
      //                 backgroundColor: colorScheme.onBackground
      //               ),
      //               title: Text(
      //                 patient.name,
      //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      //               ),
      //               subtitle: Text('Ward ${patient.ward}'),
      //             ),
      //             const Divider(
      //               indent: 25,
      //               thickness: 2,
      //             )
      //           ],
      //         );
      //       },
      //     ),
      //     const SizedBox(height: 20),
      //   ],
      // ),
    );
  }
}