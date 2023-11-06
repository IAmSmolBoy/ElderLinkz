import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/screens/home.dart';
import 'package:elderlinkz/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

// Initialisation
Future<void> init() async {
  
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
final light = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    secondary: AppColors.primaryDarkBlue,
    onSecondary: Colors.white,
    error: AppColors.primaryRed,
    onError: Colors.white,
    background: Colors.white,
    onBackground: AppColors.primaryBlack,
    surface: Colors.white,
    onSurface: AppColors.primaryBlack,
  )
);
final dark = ThemeData(
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
    surface: AppColors.primaryBlack,
    onSurface: Colors.white,
  )
);

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: light,
      darkTheme: dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestWidget(),
    );
  }
}