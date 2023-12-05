import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopNavbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const TopNavbar({
    super.key,
    required this.title
  });

  @override
  State<TopNavbar> createState() => _TopNavbarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopNavbarState extends State<TopNavbar> {
  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)?.settings.name);

    final ThemeData  theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    void setSelected(int newIndex) {
      if (newIndex != tabController.index) {
        tabController.animateTo(newIndex);
      }

      context.read<NavbarSelected>().setSelected(newIndex);
    }

    return AppBar(
      titleSpacing: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      title: Text(
        widget.title.toUpperCase(),
        style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
      ),
      leading: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(height: constraints.maxHeight, width: constraints.maxHeight);
        }
      ),
      actions: tabController.index != 4 ?
        [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: colorScheme.onSurface
            ),
            onPressed: () {
              setSelected(4);
            },
          )
        ] :
        [],
    );
  }
}