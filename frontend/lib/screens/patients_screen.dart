import 'package:elderlinkz/classes/patient.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({ super.key });
  
  final List<Patient> patients = const [
    Patient(name: "Hong Rui", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Rui Dong", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Xing Xiao", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "James", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Robby", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
    Patient(name: "Frederick", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
  ];

  @override
  Widget build(BuildContext context) {
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
                    leading: const CircleAvatar(
                      radius: 25,
                      // backgroundImage: AssetImage('assets/person_1.png'),
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