import 'dart:convert';

import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/classes/socket_address.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/login_screen.dart';
import 'package:elderlinkz/widgets/tab_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Initialisation
// Set landing page
String initialRoute = "/login";
Future<void> init() async {
  // Gets data from phon storage
  prefs = await SharedPreferences.getInstance();

  // Get environment Variables
  await dotenv.load(fileName: ".env");

  // Host name will be prefs ip, if unavilable use environment variable, if unavailable use 10.0.2.2:3000
  String host = prefs.getString("socketAddress") ?? dotenv.env['SOCKET_ADDRESS'] ?? "10.0.2.2:3000";

  try {

    // Get credentials to autologin
    String? credentials = prefs.getString("credentials");

    if (credentials != null) {
      // Login with saved credentials
      http.post(
        Uri.http(host, "/login"),
        body: json.decode(credentials)
      )
      .timeout(
        const Duration(seconds: 1),
        onTimeout: () => http.Response('Error', 408)
      )
      .then((http.Response response) {
        if (json.decode(response.body)["message"] == "Success") {
          initialRoute = "/tabs";
        }
      });
    }
  } catch (e) {
    print(e);
  }
  
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
    secondary: AppColors.secondaryPurple,
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
    secondary: AppColors.secondaryPurple,
    onSecondary: Colors.white,
    error: AppColors.primaryRed,
    onError: Colors.white,
    background: AppColors.primaryBlack,
    onBackground: Colors.white,
    surface: AppColors.primaryDarkBlue,
    onSurface: AppColors.primaryLightBlue,
  )
);

  List<Patient> patients = [
    Patient(
      name: "Rui Dong",
      ic: "S0123456C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 60,
      ward: 1,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Robby",
      ic: "S1234567C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 61,
      ward: 1,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Hong Rui",
      ic: "S2345678C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 62,
      ward: 1,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Xing Xiao",
      ic: "S3456789C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Female",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 63,
      ward: 2,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Raphael",
      ic: "S4567890C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 64,
      ward: 2,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Jan Gabriel",
      ic: "S5678901C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 65,
      ward: 3,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
    Patient(
      name: "Frederick",
      ic: "S6789012C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: DateTime.parse("1940-12-07T00:00:00+0800"),
      age: 66,
      ward: 3,
      oxygen: 0.0,
      heartRate: 0.0,
      gsr: 0.0,
      humidity: 0.0,
      temperature: 0.0
    ),
  ];

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => NavbarSelected(), ),
        ChangeNotifierProvider( create: (context) => PatientList(patientList: patients), ),
        ChangeNotifierProvider( create: (context) => SocketAddress(socketAddress: prefs.getString("socketAddress") ?? dotenv.env['SOCKET_ADDRESS'] ?? "10.0.2.2:3000"), ),
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
          initialRoute: initialRoute,
          // initialRoute: "/test",
          routes: {
            '/login': (context) => const LoginScreen(),
            '/tabs': (context) => const TabManager(),
          },
        );
      },
    );
  }
}