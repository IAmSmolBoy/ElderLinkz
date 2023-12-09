import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/widgets/bottom_navbar.dart';
import 'package:elderlinkz/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  const Layout({
    super.key,
    required this.body,
    required this.title,
    this.bottomNavbar = true,
    this.settingsButton = true,
    this.backButton = false,
  });

  final Widget body;
  final String title;
  final bool settingsButton, bottomNavbar, backButton;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    void setSelected(int newIndex) {
      if (newIndex != tabController.index) {
        tabController.animateTo(newIndex);
      }

      context.read<NavbarSelected>().setSelected(newIndex);
    }

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: widget.body,
      resizeToAvoidBottomInset: false,
      appBar: TopNavbar(
        title: widget.title,
        backButton: widget.backButton,
        settingsButton: widget.settingsButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: colorScheme.background,
      bottomNavigationBar: widget.bottomNavbar ?
        const BottomNavbar() :
        null,
      floatingActionButton: widget.bottomNavbar ?
        FloatingActionButton(
          backgroundColor: colorScheme.primary,
          onPressed: () {
            setSelected(4);
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.search,
            size: 25, 
          )) :
        null,
    );
  }
}