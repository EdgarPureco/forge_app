import 'package:flutter/material.dart';
import 'package:forge_app/screens/admin/productsAdminScreen.dart';
import 'package:forge_app/screens/admin/suppliersAdminScreen.dart';
import 'package:forge_app/screens/admin/suppliesAdminScreen.dart';
import 'package:forge_app/screens/admin/usersAdminScreen.dart';
import 'package:forge_app/screens/cartScreen.dart';
import 'package:forge_app/screens/checkSesion_screen.dart';
import 'package:forge_app/screens/productsScreen.dart';
import '../screens/screens_export.dart';

class AppRoutes {
  static String initialRoute = '/CheckSesion';
  static Map<String, Widget Function(BuildContext context)> routes = {
    '/Home': (BuildContext context) => const HomeScreen(),
    '/Error': (BuildContext context) => const ErrorScreen(),
    '/Login': (BuildContext context) => const LoginScreen(),
    '/CheckSesion': (BuildContext context) => const CheckSesionScreen(),
    '/Cart': (BuildContext context) => const CartScreen(),
    '/Products': (BuildContext context) => const ProductsScreen(),

    // ADMIN

    '/Admin/Products': (BuildContext context) => const ProductsAdminScreen(),
    '/Admin/Supplies': (BuildContext context) => const SuppliesAdminScreen(),
    '/Admin/Suppliers': (BuildContext context) => const SuppliersAdminScreen(),
    '/Admin/Users': (BuildContext context) => const UsersAdminScreen(),
    // '/Admin/Customers': (BuildContext context) => const CustomersAdminScreen(),
  };
  static onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }

  static final menuOptions = <MenuOption>[
    MenuOption(router: '/Admin/Products', icon: Icons.store, name: "Products"),
    MenuOption(router: '/Admin/Supplies', icon: Icons.assignment, name: "Supplies"),
    MenuOption(router: '/Admin/Suppliers', icon: Icons.airport_shuttle, name: "Suppliers"),
    MenuOption(router: '/Admin/Users', icon: Icons.person, name: "Users"),
    MenuOption(router: '/Admin/Customers', icon: Icons.account_box, name: "Customers"),
  ];

  
}

class MenuOption{
  final String router;
  final IconData icon;
  final String name;

MenuOption({required this.router, required this.icon, required this.name});
}