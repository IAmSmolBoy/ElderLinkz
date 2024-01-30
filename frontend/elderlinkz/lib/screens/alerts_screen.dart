import 'package:elderlinkz/classes/alerts.dart';
// import 'package:elderlinkz/classes/http.dart';
// import 'package:elderlinkz/classes/patient_list.dart';
// import 'package:elderlinkz/classes/socket_address.dart';
// import 'package:elderlinkz/functions/get_patient_info.dart';
// import 'package:elderlinkz/screens/patient_details_screen.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AlertsScreen extends StatefulWidget {

  const AlertsScreen({ super.key });

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {

  // final GlobalKey tileKey = GlobalKey();

  // Size tileSize = const Size(0, 0);

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    Map<String, Alert> alertList = context
      .watch<AlertList>().alerts;

    return SafeArea(
      child: SingleChildScrollView(
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
            ...alertList.entries
              .map(
                (alertEntry) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: screenSize.width - 60,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(alertEntry.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                                Text(alertEntry.value.alertMsg,
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -15,
                          top: -15,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: colorScheme.background,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: colorScheme.error,
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              )
          ],
        ),
      ),
    );
  }
}