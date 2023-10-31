import 'package:elderlinkz/classes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}