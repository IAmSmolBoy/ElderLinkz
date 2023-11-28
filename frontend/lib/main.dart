import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/screens/home%20copy%202.dart';
import 'package:elderlinkz/screens/home%20copy%203.dart';
import 'package:elderlinkz/screens/patients_screen.dart';
import 'package:elderlinkz/screens/home.dart';
import 'package:elderlinkz/widgets/bottom_navbar.dart';
import 'package:elderlinkz/widgets/top_navbar.dart';
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  List<Widget> tabs = const [
    Home(),
    PatientsScreen(),
    Screen3(),
    Screen4()
  ];

  setBottomBarIndex(int index) {
    if (index != _tabController.index) {
      _tabController.animateTo(index);
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() { setBottomBarIndex(_tabController.index); });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   body: TestContact(),
    // );

    return Scaffold(
      appBar: const TopNavbar(title: "Home",),
      bottomNavigationBar: BottomNavbar(currentIndex: currentIndex, setBottomBarIndex: setBottomBarIndex),
      body: DefaultTabController(
        length: tabs.length,
        child: TabBarView(
          controller: _tabController,
          children: tabs
        ),
      ),
    );
  }
}