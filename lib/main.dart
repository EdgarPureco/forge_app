import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge_app/providers/suppliers_provider.dart';
import 'package:forge_app/providers/supplies_provider.dart';
import 'package:forge_app/providers/users_provider.dart';
import 'package:forge_app/routes/app_routes.dart';
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
        ChangeNotifierProvider(create: (context) => SuppliesProvider()),
        ChangeNotifierProvider(create: (context) => SuppliersProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
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
