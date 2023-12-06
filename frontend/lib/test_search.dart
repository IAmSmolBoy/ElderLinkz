import 'package:elderlinkz/classes/ward_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  // Filtered patient list
  List<List<Patient>> results = [];

  @override
  Widget build(BuildContext context) {

    // Get Screen Size
    Size screenSize = MediaQuery.of(context).size;

    // Get Screen Size
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Original ward list
    List<WardData> wardList = context.read<WardList>().wardList;

    // If nothing is in the searchbar, results show all patients
    if (query == "") {
      results = wardList.map((ward) => ward.patients).toList();
    }

    void searchBarOnChanged(String newQuery) {
      setState(() {
        query = newQuery;

        // Filters all patients with names that contain the query (Case Insensitive)
        results = wardList
          .map(
            (ward) =>
              ward.patients
                .where(
                  (patient) =>
                    patient.name
                      .toLowerCase()
                      .contains(query.toLowerCase())
                )
                .toList()
          )
          .toList();

        // Reset results and deletes all ListTiles
        listViewWidgetList = listViewWidgetList.sublist(0, 3);

        print(results);

        // Regenerates results and adds it back to ListView
        listViewWidgetList.addAll(
          generateListTiles(
            results: results,
            tileColor: colorScheme.surface,
            avatarColor: colorScheme.onBackground,
          )
        );
      });
  }

    listViewWidgetList = [
      const SizedBox(height: 5,),
      SearchField(
        controller: textEditingController,
        onChanged: searchBarOnChanged,
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








// -------------------------------------------------------------------- Functions & Classes --------------------------------------------------------------------
// Generate the results of the query and returns a list of the widgets in the results
List<Widget> generateListTiles({
   required Color tileColor,
   required Color avatarColor,
   required List<List<Patient>> results
}) {
  return results
    .asMap()
    .map((index, result) {
      return MapEntry(
        index,
        [
          Center(
            child: Text("Ward ${index + 1}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Column(
            children: results[index]
              .map((patient) => Padding(
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

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {

    // Colourscheme
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
        leading: Icon(Icons.search, color: colorScheme.primary,),
        textStyle: MaterialStatePropertyAll(TextStyle(color: colorScheme.background)),
        shadowColor: MaterialStatePropertyAll(colorScheme.onBackground),
        padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 20)),
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        side: MaterialStatePropertyAll(BorderSide(color: colorScheme.onBackground, width: .25)),
      ),
    );
  }
}