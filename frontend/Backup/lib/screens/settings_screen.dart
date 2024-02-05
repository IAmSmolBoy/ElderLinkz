import 'package:elderlinkz/classes/ip_address.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/screens/settings_form_screen.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({ super.key });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: colorScheme.background,
      ),
      darkTheme: SettingsThemeData(
        settingsListBackground: colorScheme.background,
      ),
      sections: [
        SettingsSection(
          title: const Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              initialValue: context.watch<ThemeProvider>().themeMode == ThemeMode.light,
              leading: const Icon(Icons.light_mode),
              title: const Text('Light Mode'),
              onToggle: (lightMode) {
                context.read<ThemeProvider>().setThemeMode(
                  newTheme: lightMode ?
                    ThemeMode.light :
                    ThemeMode.dark
                );
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.light_mode),
              title: const Text('Ip Address'),
              onPressed: (context) =>
                Navigator.push(context,
                  PageTransition(
                    child: SettingsFormScreen(
                      settingName: 'Ip Address',
                      initialVal: context.read<IpAddress>().ip,
                    ),
                    childCurrent: Layout(
                      title: "Settings",
                      body: widget
                    ),
                    type: PageTransitionType.rightToLeftJoined,
                  )
                ),
            ),
            SettingsTile.navigation(
              title: const Text(''),
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SIGN OUT")
                  )
                ],
              )
            ),
          ],
        ),
      ],
    );

    // return Layout(
    //   title: "Settings",
    //   bottomNavbar: false,
    //   body: SettingsList(
    //     lightTheme: SettingsThemeData(
    //       settingsListBackground: colorScheme.background,
    //     ),
    //     darkTheme: SettingsThemeData(
    //       settingsListBackground: colorScheme.background,
    //     ),
    //     sections: [
    //       SettingsSection(
    //         title: const Text('Common'),
    //         tiles: <SettingsTile>[
    //           SettingsTile.switchTile(
    //             initialValue: context.watch<ThemeProvider>().themeMode == ThemeMode.light,
    //             leading: const Icon(Icons.light_mode),
    //             title: const Text('Light Mode'),
    //             onToggle: (lightMode) {
    //               context.read<ThemeProvider>().setThemeMode(
    //                 newTheme: lightMode ?
    //                   ThemeMode.light :
    //                   ThemeMode.dark
    //               );
    //             },
    //           ),
    //           SettingsTile.navigation(
    //             leading: const Icon(Icons.light_mode),
    //             title: const Text('Ip Address'),
    //             onPressed:(context) {
                  
    //             },
    //           ),
    //         ],
    //       ),
    //     ],
    //   )
    // );
  }
}