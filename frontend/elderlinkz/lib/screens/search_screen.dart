import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/screens/patient_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../widgets/searchbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ super.key });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController textEditingController = TextEditingController();

  // The text inside the searchbar
  String query = "";

  // List of widgets inside the ListView
  List<Widget> listViewWidgetList = [];

  @override
  Widget build(BuildContext context) {

    // Filtered patient list
    Map<int, List<Patient>> results = {};

    // Get Screen Size
    Size screenSize = MediaQuery.of(context).size;

    // Get Screen Size
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Original ward list
    List<Patient> patients = context.read<PatientList>().patientList;

    // If nothing is in the searchbar, results show all patients
    if (query == "") {
      results = categorisePatients(patients);
    }
    else {
      // Filters all patients with names that contain the query (Case Insensitive)
      List<Patient> filteredList = patients
        .where(
          (patient) =>
            patient.name
              .toLowerCase()
              .contains(query.toLowerCase())
        )
        .toList();
      
      results = categorisePatients(filteredList);
    }

    // List of Widgets to be added into the ListView
    listViewWidgetList = [
      const SizedBox(height: 5,),
      SearchField(
        controller: textEditingController,
        onChanged: (String newQuery) {
          setState(() {
            query = newQuery;
          });
        },
      ),
      SizedBox(
        width: screenSize.width - 16,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text("Results",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            )
          ],
        ),
      ),
      ...generateListTiles(
        results: results,
        tileColor: colorScheme.surface,
        avatarColor: colorScheme.onBackground,
        context: context
      ) // Uses patient list to sort into different wards and display in different catagories based on ward number
    ];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
            itemCount: listViewWidgetList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20,),
            itemBuilder: (context, index) => listViewWidgetList[index],
          ),
        ),
      ),
    );
  }
}








// -------------------------------------------------------------------- Functions --------------------------------------------------------------------
// Sort Patients into different lists
Map<int, List<Patient>> categorisePatients(List<Patient> patients) {
  Map<int, List<Patient>> results = {};

  for (Patient patient in patients) {
    if (results[patient.ward] == null) {
      results[patient.ward] = [];
    }

    results[patient.ward]!.add(patient);
  }

  return results;
}

// Generate the results of the query and returns a list of the widgets in the results
List<Widget> generateListTiles({
   required Color tileColor,
   required Color avatarColor,
   required Map<int, List<Patient>> results,
   required BuildContext context
}) {
  return results
    .map((index, result) {
      return MapEntry(
        index,
        [
          Center(
            child: Text("Ward $index",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Column(
            children: results[index]
              !.map((patient) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: tileColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: avatarColor
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${patient.name} (Ward ${patient.ward})",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text("IC No.: ${patient.ic} Age: ${patient.age}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: PatientDetailsScreen(patient: patient,),
                      ),
                    );
                  },
                ),
              ))
              .toList(),
          ),
          const SizedBox(height: 10,)
        ]
      );
    }).values
    .expand((e) => e) // Flatten list from 3d to 2d
    .toList();
}
