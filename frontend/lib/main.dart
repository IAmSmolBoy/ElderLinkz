import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/classes/navbar_selected.dart';
import 'package:elderlinkz/classes/theme.dart';
import 'package:elderlinkz/screens/analytics_screen.dart';
import 'package:elderlinkz/screens/home%20copy%203.dart';
import 'package:elderlinkz/screens/patients_screen.dart';
import 'package:elderlinkz/screens/home.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
ThemeMode theme = ThemeMode.system;

// Initialisation
Future<void> init() async {
  prefs = await SharedPreferences.getInstance();

  theme = (prefs.getBool("lightMode") ?? true) ?
    ThemeMode.light :
    ThemeMode.dark;
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
final dark = ThemeData(
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

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context) => ThemeProvider(), ),
        ChangeNotifierProvider( create: (context) => NavbarSelected(), ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: context.watch<ThemeProvider>().themeMode,
          theme: light,
          darkTheme: dark,
          home: const TabManager(),
        );
      },
    );
  }
}
  
late TabController tabController;

class TabManager extends StatefulWidget {
  const TabManager({ super.key });

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<Widget> tabs = const [
    Home(),
    PatientsScreen(),
    AnalyticsScreen(),
    Screen4()
  ];

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    tabController.addListener(() { context.read<NavbarSelected>().setSelected(tabController.index); });

    // return Scaffold(
    //   body: TestContact(),
    // );

    return Layout(
      body: DefaultTabController(
        length: tabs.length,
        child: TabBarView(
          controller: tabController,
          children: tabs
        ),
      )
    );
  }
}