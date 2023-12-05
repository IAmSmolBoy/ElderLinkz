import 'package:elderlinkz/classes/colors.dart';
import 'package:elderlinkz/widgets/tab_manager.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Map<String, String> mockUsers = {
    'dribbble@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
    'near.huscarl@gmail.com': 'subscribe to pewdiepie',
    '@.com': '.',
  };

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;

    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return FlutterLogin(
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
            borderRadius: BorderRadius.all(const Radius.circular(10)),
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
        debugPrint('Email: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
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
        value != null ?
          value.contains("@") &&
          value.contains(".") &&
          value.indexOf("@") < value.indexOf(".") ?
          null :
          "Please enter a valid email" :
          "Please enter an email",
      passwordValidator: (value) =>
        value!.isEmpty ?
          'Password is empty' :
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