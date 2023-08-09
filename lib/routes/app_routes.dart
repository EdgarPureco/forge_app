import 'package:flutter/material.dart';
import 'package:forge_app/screens/checkSesion_screen.dart';
import '../screens/screens_export.dart';

class AppRoutes {
  static String initialRoute = '/CheckSesion';
  static Map<String, Widget Function(BuildContext context)> routes = {
    '/Home': (BuildContext context) => const HomeScreen(),
    '/Error': (BuildContext context) => const ErrorScreen(),
    '/Login': (BuildContext context) => const LoginScreen(),
    '/CheckSesion': (BuildContext context) => const CheckSesionScreen(),
  };
  static onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
