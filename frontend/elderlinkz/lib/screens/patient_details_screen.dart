import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/widgets/details_card.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();

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

    return Layout(
      title: widget.patient.name,
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
                                ...displayValueWidget("NRIC", widget.patient.ic, textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Race", widget.patient.race, textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Emergency Contact", widget.patient.emergencyContact, textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Gender", widget.patient.gender, textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Age", widget.patient.age.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Date Of Birth",
                                  widget.patient.dateOfBirth
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
                                ...displayValueWidget("Ward", widget.patient.ward.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Heart Rate", widget.patient.heartRate.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Temperature", widget.patient.temperature.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Humidity", widget.patient.humidity.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("Oxygen", widget.patient.oxygen.toString(), textColor: colorScheme.onSecondary),
                                ...displayValueWidget("GSR", widget.patient.gsr.toString(), textColor: colorScheme.onSecondary),
                              ]
                            ),
                          ]
                        ),
                      ),
                      const SizedBox(height: 150,),
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








// -------------------------------------------------------------------- Functions --------------------------------------------------------------------
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