import 'package:elderlinkz/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
    print(ModalRoute.of(context)?.settings);

    final ThemeData  theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return AppBar(
      titleSpacing: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      title: Text(
        widget.title.toUpperCase(),
        style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
      ),
      leading: ModalRoute.of(context)?.settings.name != null ?
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(height: constraints.maxHeight, width: constraints.maxHeight);
          }
        ) :
        null,
      actions: ModalRoute.of(context)?.settings.name != null ?
        [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: colorScheme.onSurface
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const SettingsScreen(),
                  type: PageTransitionType.rightToLeft
                )
              );
            },
          )
        ] :
        [],
    );
  }
}