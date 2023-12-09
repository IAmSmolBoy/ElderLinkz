import 'dart:convert';

import 'package:elderlinkz/classes/socket_address.dart';
import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/screens/settings_screen.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;

import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/widgets/tab_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Map<String, String> mockUsers = {
    'dribbble@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
    'near.huscarl@gmail.com': 'subscribe to pewdiepie',
    '@.com': '.',
  };

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data, String host) async {

    Map<String, String> reqBody = { "name": data.name.toLowerCase(), "password": data.password };
    
    http.Response response = await http.post(
      Uri.http(host, "/login"),
      body: reqBody
    );

    String message = json.decode(response.body)["message"];

    if (message == "Success") {
      prefs.setString("credentials", json.encode(reqBody));

      return null;
    }

    return message;
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User does not exist';
      }
      return null;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String socketAddress = context.watch<SocketAddress>().socketAddress;

    return Stack(
      children: [
        FlutterLogin(
          userType: LoginUserType.name,
          navigateBackAfterRecovery: true,
          logo: const AssetImage('assets/images/Elderlinkz Logo.png'),
          theme: LoginTheme(
            primaryColor: colorScheme.background,
            cardTheme: CardTheme(
              color: colorScheme.surface
            ),
            titleStyle: TextStyle(
              color: colorScheme.onSurface
            ),
            buttonTheme: LoginButtonTheme(
              backgroundColor: colorScheme.primary,
            ),
            inputTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.onSurface, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryRed, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            )
          ),
          onLogin: (loginData) {
            debugPrint('Login info');
            debugPrint('NurseId: ${loginData.name}');
            debugPrint('Password: ${loginData.password}');
            return _loginUser(loginData, socketAddress);
          },
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacementNamed(
              "/tabs",
              result: FadePageRoute(
                builder: (context) => const TabManager(),
              ),
            );
          },
          onRecoverPassword: (email) {
            debugPrint('Recover password info');
            debugPrint('Name: $email');
            return _recoverPassword(email);
            // Show new password dialog
          },
          userValidator: (value) =>
            value?.isEmpty ?? true ?
              "Please enter your nurseId" :
              null,
          passwordValidator: (value) =>
            value?.isEmpty ?? true ?
              'Please enter your password' :
              null,
          headerWidget: const Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 25,
          right: 25,
          child: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                PageTransition(
                  child: const SettingsScreen(loginSettings: true,),
                  type: PageTransitionType.rightToLeft,
                )
              );
            },
          )
        ),
      ],
    );
  }

}

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) :
  super(
    builder: builder,
    settings: settings,
  );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}