import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge_app/routes/app_routes.dart';
import 'package:forge_app/screens/homeScreen.dart';
import 'package:forge_app/screens/loginScreen.dart';
import 'package:forge_app/util/util.dart';
import 'package:provider/provider.dart';
import 'package:forge_app/providers/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'Forge App',
        theme: ThemeData(
        ),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        scaffoldMessengerKey: NotificationsService.messengerKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
