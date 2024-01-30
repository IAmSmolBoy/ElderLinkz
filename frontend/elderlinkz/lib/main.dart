import 'dart:convert';

import 'package:elderlinkz/classes/alerts.dart';
import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/classes/floor_plan.dart';
import 'package:elderlinkz/classes/http.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/classes/notifications.dart';
import 'package:elderlinkz/classes/socket_address.dart';
import 'package:elderlinkz/classes/task_list.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/classes/patient_list.dart';
import 'package:elderlinkz/functions/get_patient_data.dart';
import 'package:elderlinkz/functions/get_patient_info.dart';
import 'package:elderlinkz/functions/login.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/login_screen.dart';
// import 'package:elderlinkz/screens/chatgpt_screen.dart';
// import 'package:elderlinkz/test_pin_login.dart';
// import 'package:elderlinkz/test_screen.dart';
import 'package:elderlinkz/widgets/tab_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// -------------------------------- Initialisation --------------------------------
// Set landing page
String initialRoute = "/login";

// Snackbar message to display
String? snackbarMsg;

// Patient Data
PatientList patients = PatientList(patientList: []);

// Tasks
List<Task> tasks = [];

// Alert Data
Map<String, Alert> alerts = {};

// Themes
final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.primaryGreen,
    onSecondary: AppColors.primaryLightGreen,
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
    onSecondary: AppColors.secondaryDarkGreen,
    error: AppColors.primaryRed,
    onError: Colors.white,
    background: AppColors.primaryBlack,
    onBackground: Colors.white,
    surface: AppColors.primaryDarkBlue,
    onSurface: AppColors.primaryLightBlue,
  )
);

late Http httpClient;

// Initialise and query data from backend
Future<void> init() async {
  // Initialise Timezone
  Intl.defaultLocale = 'en-SG';
  initializeDateFormatting();

  // Initialise Notifications
  notif = NotificationService()
    ..init();

  // Gets data from phon storage
  prefs = await SharedPreferences.getInstance();

  // Get environment Variables
  await dotenv.load(fileName: ".env");

  // Host name will be prefs ip, if unavilable use environment variable, if unavailable use 10.0.2.2:3000
  String host = prefs.getString("socketAddress") ?? dotenv.env['SOCKET_ADDRESS'] ?? "10.0.2.2:3000";

  // Get Http client
  httpClient = Http(socketAddress: host);

  // Get credentials to autologin
  String? credentialsJson = prefs.getString("credentials");

  // Get Tasks
  List<String>? taskListJson = prefs.getStringList("tasks");
  tasks = TaskList.fromStringList(taskListJson ?? []);

  if (credentialsJson != null) {
    Map<String, dynamic> credentials = json.decode(credentialsJson);

    if (credentials.containsKey("name") && credentials.containsKey("password")) {
      String name = credentials["name"] as String;
      String password = credentials["password"] as String;

      snackbarMsg = await login(
        httpClient: httpClient,
        credentials: LoginData(
          name: name,
          password: password
        ),
        onSuccess: (loginBody) {

          // initialRoute = "/pin";
          initialRoute = "/tabs";

          return getPatientInfo(
            httpClient: httpClient,
            onUnknownError: () => "Something went wrong",
            onSuccess: (patientsBody) {

              patients = PatientList.fromJsonObj(patientsBody);

              return null;
              
            },
          );

        },
      );
    }
    else {
      snackbarMsg = "Saved credentials are invalid";
    }
  }
}

// Update alerts when data is received
AlertList updateAlerts(BuildContext context, PatientList patients, AlertList? alertListClass) {

  List<Patient> patientList = patients.patientList;

  alertListClass = alertListClass ?? AlertList(alerts: alerts);
  Map<String, Alert> alertList = alertListClass.alerts;
    
  for (Patient patient in patientList) {

    String notifMsg = "${patient.name} ";
    List<String> notifList = [];

    if (patient.temperature > 37.5) { notifList.add("has high temperature"); }
    if (patient.gsr >= 35) { notifList.add("has intense emotional"); }
    if (patient.oxygen < 95) { notifList.add("is lacking oxygen"); }
    if (patient.humidity >= 100) { notifList.add("has defacted"); }

    notifMsg += notifList.join(", ");
    
    if (
      !alertList.containsKey(patient.name) ||
      (
        notifMsg != "${patient.name} " &&
        alertList.containsKey(patient.name) &&
        alertList[patient.name]!.alertMsg != notifMsg
      )
    ) {

      alertListClass.addAlert(patient.name, notifMsg);
      // notif.showNotification(title: patient.name, body: notifMsg);

    }

  }

  return alertListClass;

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
    // debugPrint(initialRoute);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => NavbarSelected(), ),
        ChangeNotifierProvider( create: (context) => FloorPlanModel(), ),
        ChangeNotifierProvider( create: (context) => TaskList(taskList: tasks), ),
        ChangeNotifierProvider( create: (context) => AlertList(alerts: alerts), ),
        // ChangeNotifierProvider( create: (context) => PatientList(patientList: patients), ),
        ChangeNotifierProvider(
          create: (context) => SocketAddress(
            socketAddress: prefs.getString("socketAddress") ??
              dotenv.env['SOCKET_ADDRESS'] ??
                "10.0.2.2:3000"
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeMode: (prefs.getBool("lightMode") ?? true) ?
              ThemeMode.light :
              ThemeMode.dark
          ),
        ),
        StreamProvider<PatientList>
          .value(
            value: getData(httpClient),
            initialData: patients,
            updateShouldNotify: (previous, current) => true,
            catchError: (context, error) => PatientList(patientList: []),
          ),
        ListenableProxyProvider<PatientList, AlertList>(
          create: (context) => AlertList(alerts: alerts),
          update: updateAlerts,
        )
      ],
      builder: (context, child) {

        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: context.watch<ThemeProvider>().themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
        
          // home: const ChatGPTTest(),
          initialRoute: initialRoute,
          // initialRoute: "/test",
          routes: {
            '/login': (context) => Scaffold(body: LoginScreen(snackbarMsg: snackbarMsg,)),
            // '/pin': (context) => const Scaffold(body: PinLogin()),
            '/tabs': (context) => const TabManager(),
            // '/test': (context) => StatsPage(),
          },
        );

      },
    );
  }
}