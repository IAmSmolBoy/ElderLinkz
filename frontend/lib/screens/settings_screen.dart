import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
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

    return Layout(
      bottomNavbar: false,
      body: SettingsList(
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
            ],
          ),
        ],
      )
    );
  }
}