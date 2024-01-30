import 'package:elderlinkz/classes/http.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/widgets/details_widgets.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:elderlinkz/widgets/thermometer.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
  late Http httpClient;

  @override
  void initState() {
    super.initState();

    // _patient = widget.patient;

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

    _patient = context
      .watch<PatientList>().patientList
      .singleWhere(
        (patient) =>
          patient.name == widget.patient.name
      );

    // httpClient = Http(socketAddress: context.watch<SocketAddress>().socketAddress);

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
                                    rightArrow: true,
                                    sectionTitle: "Personal",
                                    patient: _patient,
                                    toNextTab: () { _tabController.animateTo(1); },
                                    child: TileBody(patient: _patient),
                                  ),
                                  DetailsCard(
                                    leftArrow: true,
                                    sectionTitle: "Health",
                                    patient: _patient,
                                    toPreviousTab: () { _tabController.animateTo(0); },
                                    child: ListBody(patient: _patient),
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
}













// -------------------------------------------------------------------- Bodies --------------------------------------------------------------------
class TileBody extends StatelessWidget {

  const TileBody({
    super.key,
    required this.patient
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * .6 - 60,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // debugPrint(constraints.maxHeight.toString());
          double boxHeight = constraints.maxHeight / 4;
          double rectangleWidth = constraints.maxWidth - boxHeight;

          return Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      DetailGridTile(
                        width: rectangleWidth,
                        height: boxHeight,
                        title: "NRIC",
                        value: patient.ic,
                        icon: FontAwesomeIcons.solidIdCard,
                      ),
                      DetailGridTile(
                        width: rectangleWidth,
                        height: boxHeight,
                        title: "Emergency Contact",
                        value: patient.emergencyContact,
                        icon: FontAwesomeIcons.phone,
                      ),
                      DetailGridTile(
                        width: rectangleWidth,
                        height: boxHeight,
                        title: "Race",
                        value: patient.race,
                        icon: FontAwesomeIcons.hand,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DetailGridTile(
                        width: boxHeight,
                        height: boxHeight,
                        title: "Sex",
                        value: patient.gender,
                        icon: FontAwesomeIcons.venusMars,
                      ),
                      DetailGridTile(
                        width: boxHeight,
                        height: boxHeight,
                        title: "Age",
                        value: patient.age.toString(),
                        icon: FontAwesomeIcons.cakeCandles,
                      ),
                      DetailGridTile(
                        width: boxHeight,
                        height: boxHeight,
                        title: "Ward",
                        value: patient.ward.toString(),
                        icon: FontAwesomeIcons.bed,
                      ),
                    ],
                  )
                ],
              ),
              DetailGridTile(
                width: constraints.maxWidth,
                height: boxHeight,
                title: "Date Of Birth",
                value: DateFormat.yMd("en_SG").add_Hms().format(patient.dateOfBirth),
                icon: FontAwesomeIcons.calendarDay,
              ),
            ],
          );
        }
      ),
    );

  }
  
}

class ListBody extends StatelessWidget {

  const ListBody({
    super.key,
    required this.patient
  });

  final Patient patient;
  final listStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15
  );

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // debugPrint((patient.status == 1).toString());

    return SizedBox(
      height: screenSize.height * .6 - 60,
      child: LayoutBuilder(
        builder: (context, constraints) {

          // debugPrint(constraints.maxHeight.toString());
          double boxHeight = constraints.maxHeight / 5;
          double rectangleWidth = constraints.maxWidth;

          return Row(
            children: [
              Column(
                children: [
                  DetailGridTile(
                    height: boxHeight,
                    width: rectangleWidth,
                    child: DetailListTile(
                      height: boxHeight,
                      width: rectangleWidth,
                      titleText: "Temp:\n${patient.temperature.toStringAsFixed(2)}°c",
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: ThermometerWidget(
                          value: (patient.temperature - 34) / 7,
                          color: patient.temperature < 37.5 ?
                            colorScheme.secondary :
                            colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                  DetailGridTile(
                    height: boxHeight,
                    width: rectangleWidth,
                    child: DetailListTile(
                      height: boxHeight,
                      width: rectangleWidth,
                      titleText: "GSR:\n${patient.gsr}S",
                      child: Slider(
                        min: 0,
                        max: 40,
                        value: patient.gsr,
                        onChanged: (double value) {  },
                        activeColor: patient.gsr < 35 ?
                          colorScheme.secondary :
                          colorScheme.error,
                      ),
                    ),
                  ),
                  DetailGridTile(
                    height: boxHeight,
                    width: rectangleWidth,
                    child: DetailListTile(
                      height: boxHeight,
                      width: rectangleWidth,
                      titleText: "Oxygen:\n${patient.oxygen}%",
                      child: Slider(
                        min: 87,
                        max: 100,
                        value: patient.oxygen,
                        onChanged: (double value) {  },
                        activeColor: patient.oxygen >= 95 ?
                          colorScheme.secondary  :
                          colorScheme.error,
                      ),
                    ),
                  ),
                  DetailGridTile(
                    height: boxHeight,
                    width: rectangleWidth,
                    child: DetailListTile(
                      height: boxHeight,
                      width: rectangleWidth,
                      titleText: "Humi:\n${patient.humidity}%",
                      child: Slider(
                        min: 90,
                        max: 120,
                        value: patient.humidity,
                        onChanged: (double value) {  },
                        activeColor: patient.humidity < 100 ?
                          Color.lerp(
                            colorScheme.onPrimary,
                            colorScheme.onSurface,
                            (patient.humidity - 90) / 30
                          )  :
                          colorScheme.error,
                      ),
                    ),
                  ),
                  DetailGridTile(
                    height: boxHeight,
                    width: rectangleWidth,
                    title: "Sick Prediction:",
                    value: patient.status == 2 ?
                      "Terminally Ill" :
                      patient.status == 1 ?
                        "Sick" :
                        patient.status == 0 ?
                          "Healthy" :
                          null,
                  ),
                ],
              ),
            ],
          );
          
        }
      ),
    );
    
  }
  
}