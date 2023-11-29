import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/widgets/bottom_navbar.dart';
import 'package:elderlinkz/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final Widget body;
  final bool bottomNavbar;

  const Layout({
    super.key,
    required this.body,
    this.bottomNavbar = true
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    // return Scaffold(
    //   body: TestContact(),
    // );

    return Scaffold(
      body: widget.body,
      appBar: const TopNavbar(title: "Home",),
      bottomNavigationBar: widget.bottomNavbar ?
        const BottomNavbar() :
        null,
      floatingActionButton: widget.bottomNavbar ?
        FloatingActionButton(
          backgroundColor: colorScheme.primary,
          onPressed: () {
            context.read<NavbarSelected>().setSelected(3);
          },
          child: const Icon(
            Icons.add,
            size: 25,
          )
        ) :
        null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}