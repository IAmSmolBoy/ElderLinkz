// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';

// import 'dart:convert';

// class TestContact extends StatelessWidget {
//   TestContact({ super.key });

//   final ScrollController _scrollController = ScrollController();

//   final List<Map<String, String>> data = [
//     {
//       "name": "Maryam Christensen",
//       "phone": "(708) 401-1432",
//       "email": "aliquet.metus.urna@protonmail.ca",
//       "country": "United States",
//       "region": "Akwa Ibom"
//     },
//     {
//       "name": "A A",
//       "phone": "(708) 401-1432",
//       "email": "aliquet.metus.urna@protonmail.ca",
//       "country": "United States",
//       "region": "Akwa Ibom"
//     },
//     {
//       "name": "Conan Newton",
//       "phone": "1-245-615-3179",
//       "email": "ac.fermentum@outlook.edu",
//       "country": "Australia",
//       "region": "Xīběi"
//     },
//     {
//       "name": "Aphrodite Landry",
//       "phone": "(870) 863-5867",
//       "email": "magna@outlook.edu",
//       "country": "India",
//       "region": "Sachsen"
//     },
//     {
//       "name": "Eugenia Levine",
//       "phone": "(775) 735-8020",
//       "email": "vitae.semper@hotmail.com",
//       "country": "Russian Federation",
//       "region": "New Brunswick"
//     },
//     {
//       "name": "Fuller Ray",
//       "phone": "1-546-386-4878",
//       "email": "nunc@protonmail.ca",
//       "country": "Mexico",
//       "region": "Minnesota"
//     },
//     {
//       "name": "Quin Crane",
//       "phone": "1-500-381-7960",
//       "email": "purus@aol.org",
//       "country": "Germany",
//       "region": "Mecklenburg-Vorpommern"
//     },
//     {
//       "name": "Meredith Craig",
//       "phone": "1-618-723-2387",
//       "email": "orci.luctus.et@aol.org",
//       "country": "Austria",
//       "region": "Umbria"
//     },
//     {
//       "name": "Bareina Lindsey",
//       "phone": "1-638-212-4639",
//       "email": "imperdiet.nec@protonmail.couk",
//       "country": "South Korea",
//       "region": "Antwerpen"
//     },
//     {
//       "name": "Declan Mcmillan",
//       "phone": "(840) 478-8507",
//       "email": "interdum.libero@hotmail.net",
//       "country": "Germany",
//       "region": "Maranhão"
//     },
//     {
//       "name": "Phillip Charles",
//       "phone": "(626) 471-2874",
//       "email": "justo.eu.arcu@hotmail.org",
//       "country": "India",
//       "region": "Andalucía"
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ListView(
//         controller: _scrollController,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Recent',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//           ),
//           ListView.separated(
//             controller: _scrollController,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return ListTile(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                           return ContactDettailsView(
//                             contact: Contact(
//                               country: ' Ghana',
//                               name: 'Nengi Aberenika',
//                               phone: '+233 20 15 60 888',
//                               email: 'eddynancy@mail.com',
//                               region: 'Western Region'
//                             )
//                           );
//                         }
//                       )
//                     );
//                   },
//                   leading: const CircleAvatar(
//                     radius: 25,
//                     backgroundImage: AssetImage('assets/person_1.png'),
//                   ),
//                   title: const Text(
//                     'Nengi Aberenika',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   subtitle: const Text('+233 20 156 0888'),
//                   trailing: const IconButton(
//                     onPressed: null,
//                     icon: Icon(Icons.more_horiz),
//                   )
//               );
//             },
//             separatorBuilder: (context, index) {
//               return const Divider(
//                 indent: 25,
//                 thickness: 2,
//               );
//             },
//             itemCount: 3,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Patients',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//           ),
//           GroupedListView<Map<String, String>, String>(
//             shrinkWrap: true,
//             elements: data,
//             useStickyGroupSeparators: true,
//             floatingHeader: true,
//             order: GroupedListOrder.ASC,
//             groupBy: (element) => element['name'].toString().substring(0, 1),
//             itemComparator: (item1, item2) =>
//               item1['name']!.compareTo(item2['name']!),
//             groupSeparatorBuilder: (String groupByValue) => SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   groupByValue.substring(0, 1),
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 18),
//                 ),
//               ),
//             ),
//             itemBuilder: (context, Map<String, String> element) {
//               Contact contact = Contact.fromJson(element);

//               return Column(
//                 children: [
//                   ListTile(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return ContactDettailsView(
//                           contact: contact,
//                         );
//                       }));
//                     },
//                     leading: const CircleAvatar(
//                       radius: 25,
//                       backgroundImage: AssetImage('assets/person_1.png'),
//                     ),
//                     title: Text(
//                       '${element['name']}',
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     subtitle: Text('${element['phone']}'),
//                   ),
//                   const Divider(
//                     indent: 25,
//                     thickness: 2,
//                   )
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

// String contactToJson(Contact data) => json.encode(data.toJson());

// class Contact {
//   Contact({
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.country,
//     required this.region,
//   });

//   String name;
//   String phone;
//   String email;
//   String country;
//   String region;

//   factory Contact.fromJson(Map<String, dynamic> json) => Contact(
//         name: json["name"],
//         phone: json["phone"],
//         email: json["email"],
//         country: json["country"],
//         region: json["region"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "phone": phone,
//         "email": email,
//         "country": country,
//         "region": region,
//       };
// }

// class ContactDettailsView extends StatelessWidget {
//   const ContactDettailsView({Key? key, required this.contact})
//       : super(key: key);

//   final Contact contact;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           'Contact',
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
//         ),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
//         ],
//       ),
//       body: ListView(
//         children: [
//           const CircleAvatar(
//             radius: 70,
//             backgroundImage: AssetImage('assets/person5.png'),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           Center(
//               child: Text(
//             contact.name,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//           )),
//           Center(
//               child: Text(
//             '${contact.region},${contact.country}',
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
//           )),
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             color: const Color(0xff9AADBE),
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text(
//                     'Mobile',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                   ),
//                   subtitle: Text(
//                     contact.phone,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16,
//                         color: Color(0xff333333)),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: const Icon(
//                           Icons.message,
//                           color: Colors.black,
//                         ),
//                         style: TextButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             shape: const CircleBorder()),
//                       ),
//                       TextButton(
//                           onPressed: () {},
//                           child: const Icon(
//                             Icons.call,
//                             color: Colors.black,
//                           ),
//                           style: TextButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               shape: const CircleBorder()))
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text(
//                     'Email',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                   ),
//                   subtitle: Text(
//                     contact.email,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16,
//                         color: Color(0xff333333)),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: const Icon(
//                           Icons.email,
//                           color: Colors.black,
//                         ),
//                         style: TextButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             shape: const CircleBorder()),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const ListTile(
//                   title: Text(
//                     'Group',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                   ),
//                   subtitle: Text(
//                     'Uni Friends',
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 16,
//                         color: Color(0xff333333)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Account Linked',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//             ),
//           ),
//           Container(
//             color: const Color(0xff9AADBE),
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text(
//                     'Telegram',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   trailing: Image.asset('assets/telegram.png'),
//                 ),
//                 ListTile(
//                   title: const Text(
//                     'WhatsApp',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   trailing: Image.asset('assets/whatsapp.png'),
//                 )
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'More Options',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//             ),
//           ),
//           Container(
//             color: const Color(0xff9AADBE),
//             child: Column(
//               children: const [
//                 ListTile(
//                   title: Text(
//                     'Share Contact',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'QR Code',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }