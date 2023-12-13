import 'dart:convert';

import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/classes/http.dart';
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

// -------------------------------- Initialisation --------------------------------
// Set landing page
String initialRoute = "/login";

// Snackbar message to display
String? snackbarMsg;

// Patient Data
List<Patient> patients = [];

// Themes
final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.primaryGreen,
    onSecondary: Colors.white,
    error: AppColors.secondaryRed,
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
    primary: AppColors.secondaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryGreen,
    onSecondary: Colors.white,
    error: AppColors.primaryRed,
    onError: Colors.white,
    background: AppColors.primaryBlack,
    onBackground: Colors.white,
    surface: AppColors.primaryDarkBlue,
    onSurface: AppColors.primaryLightBlue,
  )
);

// Initialise and query data from backend
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
      Map<String, dynamic> loginBody = await Http.post(
        host,
        "/login",
        body: json.decode(credentials)
      );
      
      if (loginBody.containsKey("message") && loginBody["message"] == "Success") {
        initialRoute = "/tabs";

        Map<String, List<Map<String, dynamic>>> patientsBody = await Http.get(host, "/patients",);

        patients = patientsBody["patients"]
          ?.map((patient) => Patient.fromMap(patient))
          .toList() ??
          [];
      }
      else if (loginBody.containsKey("error") && loginBody["error"] != null) {
        snackbarMsg = loginBody["error"];
      }
      else {
        snackbarMsg = "User credentials no long valid";
      }
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
            '/login': (context) => Scaffold(body: LoginScreen(snackbarMsg: snackbarMsg,)),
            '/tabs': (context) => const TabManager(),
          },
        );
      },
    );
  }
}