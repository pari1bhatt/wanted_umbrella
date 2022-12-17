import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanted_umbrella/pages/dashboard.dart';
import 'package:wanted_umbrella/pages/onboarding/forgot_password.dart';
import 'package:wanted_umbrella/pages/onboarding/login.dart';
import 'package:wanted_umbrella/pages/onboarding/register.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: GetStrings.appName,
      theme: MyTheme.lightTheme(),
      darkTheme: MyTheme.darkTheme(),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.login,
      // theme: ThemeData(primarySwatch: Colors.blue),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot_password = '/forgot_password';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgot_password:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
    }
    return MaterialPageRoute(builder: (_) => Container());
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
