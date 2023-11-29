import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({ super.key, });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<IconData> iconItems = [
    Icons.home,
    Icons.person,
    Icons.bar_chart,
    Icons.abc
  ];

  @override
  Widget build(BuildContext context) {

    void setSelected(int newIndex) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (newIndex != tabController.index) {
        tabController.animateTo(newIndex);
      }

      context.read<NavbarSelected>().setSelected(newIndex);
    }

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return AnimatedBottomNavigationBar(
      backgroundColor: colorScheme.surface,
      activeColor: colorScheme.primary,
      splashColor: colorScheme.onPrimary,
      inactiveColor: colorScheme.onSurface.withOpacity(0.5),
      icons: iconItems,
      activeIndex: context.watch<NavbarSelected>().index,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: setSelected
    );
  }
}