import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({
    super.key,
    required this.patient
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Layout(
      title: patient.name,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            CircleAvatar(
              minRadius: 100,
              backgroundColor: colorScheme.onBackground,
              child: Icon(Icons.person,
                size: 100,
                color: colorScheme.background,
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                const SizedBox(width: 30,),
                Text("Status",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            ...List
              .filled(3, 0)
              .map((e) =>
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List
                          .filled(2, 0)
                          .map((e) => 
                            Stack(
                              children: [
                                SizedBox(
                                  height: screenSize.height * .45,
                                  width: screenSize.width * .45,
                                  child: Card(
                                    child: Image.asset(
                                      'assets/images/Launcher Icon.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * .45,
                                  width: screenSize.width * .45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: screenSize.height * .3,
                                        width: screenSize.width * .45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              colorScheme.onBackground.withOpacity(0),
                                              colorScheme.onBackground.withOpacity(.7),
                                            ],
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * .45,
                                  width: screenSize.width * .45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Test",
                                        style: TextStyle(
                                          fontSize: 36,
                                          color: colorScheme.background,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                )
                              ],
                            )
                          )
                          .toList()
                      ],
                    ),
                    const SizedBox(height: 20,)
                  ],
                )
              )
              .toList(),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}