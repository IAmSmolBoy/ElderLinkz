import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({ super.key, });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<IconData> iconItems = [
    Icons.home,
    Icons.warning,
    // Icons.person,
    // Icons.bar_chart,
    FontAwesomeIcons.listCheck,
    Icons.search
  ];

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    void setSelected(int newIndex) {

      if (newIndex != 0) {

        tabController
          .animateTo(newIndex - 1);

      }

      context
        .read<NavbarSelected>()
        .setSelected(newIndex);

    }

    return AnimatedBottomNavigationBar(
      backgroundColor: colorScheme.surface,
      activeColor: colorScheme.onSurface,
      splashColor: colorScheme.onSurface,
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