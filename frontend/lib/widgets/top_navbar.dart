import 'package:elderlinkz/classes/colors.dart';
import 'package:flutter/material.dart';

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
    final ThemeData  theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return AppBar(
      titleSpacing: 0,
      backgroundColor: colorScheme.surface,
      leading: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(height: constraints.maxHeight, width: constraints.maxHeight);
        }
      ),
      title: Text(
        widget.title.toUpperCase(),
        style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: colorScheme.onSurface
          ),
          onPressed: () {
          
          },
        )
      ],
      // leading: IconB 
    );
  }
}