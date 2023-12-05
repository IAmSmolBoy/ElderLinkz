import 'package:elderlinkz/classes/ward_data.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({ super.key });

  

  @override
  Widget build(BuildContext context) {

    // Get Screen Size
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Get patient list from all wards
    List<List<Patient>> wardPatientList = context.read<WardList>().wardList.map((ward) => ward.patients).toList();

    // Flatten list to be a list of all patients
    List<Patient> patients = wardPatientList.expand((e) => e,).toList();

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Patients',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          GroupedListView<Patient, String>(
            shrinkWrap: true,
            elements: patients,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            order: GroupedListOrder.ASC,
            groupBy: (element) => element.name.toString().substring(0, 1),
            itemComparator: (item1, item2) =>
              item1.name.compareTo(item2.name),
            groupSeparatorBuilder: (String groupByValue) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  groupByValue.substring(0, 1),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            itemBuilder: (context, Patient element) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      // Navigator.push(context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return ContactDettailsView(
                      //       contact: contact,
                      //     );
                      //   })
                      // );
                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: colorScheme.onBackground
                    ),
                    title: Text(
                      '${element.name}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Room ${element.room}'),
                  ),
                  const Divider(
                    indent: 25,
                    thickness: 2,
                  )
                ],
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}