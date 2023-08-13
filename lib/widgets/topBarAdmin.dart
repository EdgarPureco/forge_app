
import 'package:flutter/material.dart';
import 'package:forge_app/widgets/drawer_widget.dart';

class TopBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

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
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
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