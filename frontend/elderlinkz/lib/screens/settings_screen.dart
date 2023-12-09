import 'package:elderlinkz/classes/socket_address.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/login_screen.dart';
import 'package:elderlinkz/screens/settings_form_screen.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({
    super.key,
    this.loginSettings = false
  });

  final bool loginSettings;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String currIp = context.watch<SocketAddress>().socketAddress;

    return Layout(
      title: "Settings",
      bottomNavbar: false,
      settingsButton: false,
      backButton: true,
      body: SettingsList(
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
            ],
          ),
          SettingsSection(
            title: const Text('Technical'),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.wifi),
                title: const Text('Socket Address'),
                value: Text(currIp),
                onPressed: (context) =>
                  Navigator.push(context,
                    PageTransition(
                      child: SettingsFormScreen(
                        settingName: 'Socket Address',
                        initialVal: currIp,
                        save: (newIp) {
                          context.read<SocketAddress>().setNewSocketAddress(newIp);
      
                          prefs.setString("socketAddress", newIp);
                        },
                      ),
                      childCurrent: Layout(
                        title: "Settings",
                        body: widget
                      ),
                      type: PageTransitionType.rightToLeftJoined,
                    )
                  ),
              ),
              if (!widget.loginSettings) SettingsTile.navigation(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        prefs.remove("credentials");
      
                        Navigator.pushReplacement(context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: const LoginScreen(),
                          )
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colorScheme.error),
                      ),
                      child: Text("SIGN OUT",
                        style: TextStyle(
                          color: colorScheme.error
                        ),
                      )
                    )
                  ],
                )
              ),
              if (widget.loginSettings) SettingsTile.navigation(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        http
                          .get(
                            Uri
                              .http(
                                currIp,
                                "/ping"
                              )
                          )
                          .then((res) => print(res.body));
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colorScheme.error),
                      ),
                      child: Text("PING TEST",
                        style: TextStyle(
                          color: colorScheme.error
                        ),
                      )
                    )
                  ],
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}