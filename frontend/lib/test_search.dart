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
  String query = "";

  @override
  Widget build(BuildContext context) {

    // Get Screen Size
    Size screenSize = MediaQuery.of(context).size;

    // Get Screen Size
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Original ward list
    List<WardData> wardList = context.read<WardList>().wardList;

    // Filtered patient list
    List<List<Patient>> results = [];

    if (query == "") {
      results = wardList.map((ward) => ward.patients).toList();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView.separated(
            itemCount: results.length + 1,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Divider(color: colorScheme.onBackground, thickness: 4,),
            ),
            itemBuilder: (context, index) {
              
            // SearchField(
            //   controller: textEditingController,
            //   onChanged: (newQuery) {
            //     setState(() {
            //       query = newQuery;
            //     });
            //   },
            // ),
            // SizedBox(
            //   width: screenSize.width - 16,
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 12.0),
            //         child: Text("Results",
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 25
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
        
              int i = 0;
        
              return Column(
                children: results[index]
                  .map((patient){
                    List<Widget> widgetList = [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: colorScheme.onBackground
                        ),
                        title: Text(
                          patient.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      )
                    ];
        
                    i++;
        
                    if (i == 1) {
                      widgetList.insert(0,
                        Text("Ward ${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        )
                      );
                    }
        
                    if (i < results[index].length) {
                      widgetList.add(
                        Divider(color: colorScheme.onBackground, thickness: 2,),
                      );
                    }
        
                    return Column(
                      children: widgetList,
                    );
                  })
                  .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
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

    return SearchBar(
      controller: controller,
      leading: Icon(Icons.search, color: colorScheme.primary,),
      textStyle: MaterialStatePropertyAll(TextStyle(color: colorScheme.background)),
      shadowColor: MaterialStatePropertyAll(colorScheme.onBackground),
      padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 20)),
      backgroundColor: MaterialStatePropertyAll(colorScheme.onBackground),
      onChanged: onChanged,
    );
  }
}