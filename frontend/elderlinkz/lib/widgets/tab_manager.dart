import 'dart:convert';

import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/classes/screen_data.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/analytics_screen.dart';
import 'package:elderlinkz/screens/home.dart';
import 'package:elderlinkz/screens/patients_screen.dart';
import 'package:elderlinkz/screens/search_screen.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabManager extends StatefulWidget {
  const TabManager({ super.key });

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<ScreenData> tabs = [
    ScreenData(title: "Welcome, ${json.decode(prefs.getString('credentials') ?? '{}')['name']}", screen: const Home(),),
    const ScreenData(title: "Patients", screen: PatientsScreen(),),
    const ScreenData(title: "Analytics", screen: AnalyticsScreen(),),
    const ScreenData(title: "Search", screen: SearchScreen())
  ];

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this
    );

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    tabController.addListener(() { context.read<NavbarSelected>().setSelected(tabController.index); });

    return Layout(
      title: tabs[context.watch<NavbarSelected>().index].title,
      body: DefaultTabController(
        length: tabs.length,
        child: TabBarView(
          controller: tabController,
          children: tabs.map((screenData) => screenData.screen).toList()
        ),
      )
    );
  }
}