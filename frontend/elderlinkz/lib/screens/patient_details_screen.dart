import 'package:elderlinkz/classes/http.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/classes/socket_address.dart';
import 'package:elderlinkz/widgets/details_card.dart';
import 'package:elderlinkz/widgets/layout.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({
    super.key,
    required this.patient
  });

  final Patient patient;

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> with TickerProviderStateMixin {

  late TabController _tabController;
  late Patient _patient;
  @override
  void initState() {
    super.initState();

    _patient = widget.patient;

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return StreamBuilder<Map<String, dynamic>>(
      stream: getData(context.watch<SocketAddress>().socketAddress),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          print(snapshot.error);

          ScaffoldMessenger
            .of(context)
            .showSnackBar(
              SnackBar(
                content: Text(snapshot.error.toString())
              )
            );

          return Layout(
            title: "Error",
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.active || !snapshot.hasData) {
          return const Layout(
            title: "Loading...",
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        print(snapshot.data);

        _patient = context.read<PatientList>().updatePatientData(0, snapshot.data!);

        return Layout(
          title: widget.patient.name,
          bottomNavbar: false,
          backButton: true,
          body: Stack(
            children: [
              Positioned(
                width: screenSize.width,
                top: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 75,
                      backgroundColor: colorScheme.onBackground,
                      child: Icon(Icons.person,
                        size: 100,
                        color: colorScheme.background,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 250,),
                    Container(
                      color: colorScheme.surface,
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: screenSize.height * .65,),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                DetailsCard(
                                  sectionTitle: "Personal",
                                  sectionWidgets: [
                                    ...displayValueWidget("NRIC", _patient.ic, textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Race", _patient.race, textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Emergency Contact", _patient.emergencyContact, textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Gender", _patient.gender, textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Age", _patient.age.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Date Of Birth",
                                      _patient.dateOfBirth
                                        .toString()
                                        .split(" ")[0]
                                        .split("-")
                                        .reversed
                                        .join("/"),
                                      textColor: colorScheme.onSecondary
                                    ),
                                  ]
                                ),
                                DetailsCard(
                                  sectionTitle: "Health",
                                  sectionWidgets: [
                                    ...displayValueWidget("Ward", _patient.ward.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Heart Rate", _patient.heartRate.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Temperature", _patient.temperature.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Humidity", _patient.humidity.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("Oxygen", _patient.oxygen.toString(), textColor: colorScheme.onSecondary),
                                    ...displayValueWidget("GSR", _patient.gsr.toString(), textColor: colorScheme.onSecondary),
                                  ]
                                ),
                              ]
                            ),
                          ),
                          const SizedBox(height: 200,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}








// -------------------------------------------------------------------- Functions --------------------------------------------------------------------
Stream<Map<String, dynamic>> getData(String socketAddress) async* {
  while (true) {
    Map<String, dynamic> resBody = await Http.get(socketAddress, "/data");

    if (resBody.containsKey("error")) {
      throw Exception(resBody["error"]);
    }

    yield resBody;

    await Future.delayed(const Duration(seconds: 1));
  }
}

List<Widget> displayValueWidget(String name, String value, { Color? textColor }) =>
  [
    const SizedBox(height: 15,),
    Text(name,
      style: TextStyle(
        fontSize: 15,
        color: textColor
      ),
    ),
    const SizedBox(height: 2,),
    Text(value,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor
      ),
    ),
  ];