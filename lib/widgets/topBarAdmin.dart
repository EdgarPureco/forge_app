
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forge_app/widgets/drawer_widget.dart';

class TopBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
final storage = const FlutterSecureStorage();
  Future logOut() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Image.asset(
            "assets/logo.png", // Ruta de la imagen del logo de la empresa
            width: 32,
            height: 32,
          ),
          SizedBox(width: 8),
          
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
            GestureDetector(
            onTap: () {
              logOut();
              Navigator.pushReplacementNamed(context, "/Login");
            },
            child:  const Icon(
              Icons.exit_to_app,
              size: 30,
            ),
          ),
          ],
        ),
        
      ],
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerWidget();
  }
}