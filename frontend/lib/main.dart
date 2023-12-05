import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/classes/ward_data.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/login_page.dart';
import 'package:elderlinkz/widgets/tab_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Initialisation
Future<void> init() async {
  prefs = await SharedPreferences.getInstance();
}

Future<void> main() async {
  // Freeze splash screen during initialisation
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialise dependencies
  await init();

  // Remove splash screen after initialisation
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

// ---------------- Themes ----------------
final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.primaryDarkBlue,
    onSecondary: Colors.white,
    error: Color.fromARGB(255, 102, 30, 30),
    onError: Colors.white,
    background: Colors.white,
    onBackground: AppColors.primaryBlack,
    surface: AppColors.primaryLightBlue,
    onSurface: AppColors.primaryDarkBlue,
  )
);
final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.primaryBlack,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.primaryDarkBlue,
    onSecondary: Colors.white,
    error: AppColors.primaryRed,
    onError: Colors.white,
    background: AppColors.primaryBlack,
    onBackground: Colors.white,
    surface: AppColors.primaryDarkBlue,
    onSurface: AppColors.primaryLightBlue,
  )
);


  const List<WardData> wards = [
    WardData(
      id: 1,
      patients: [
        Patient(name: "Rui Dong", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
        Patient(name: "Robby", room: 1, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
        Patient(name: "Hong Rui", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
      ]
    ),
    WardData(
      id: 2,
      patients: [
        Patient(name: "Xing Xiao", room: 2, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
        Patient(name: "Raphael", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
      ]
    ),
    WardData(
      id: 3,
      patients: [
        Patient(name: "James", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
        Patient(name: "Frederick", room: 3, oxygen: 0.0, heartRate: 0.0, gsr: 0.0, humidity: 0.0, temperature: 0.0),
      ]
    ),
  ];

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => NavbarSelected(), ),
        ChangeNotifierProvider( create: (context) => WardList(wardList: wards), ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeMode: (prefs.getBool("lightMode") ?? true) ?
              ThemeMode.light :
              ThemeMode.dark
            ),
        ),
      ],
      builder: (context, child) {

        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: context.watch<ThemeProvider>().themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          initialRoute: '/tabs',
          routes: {
            '/login': (context) => const LoginPage(),
            '/tabs': (context) => const TabManager(),
          },
        );
      },
    );
  }
}