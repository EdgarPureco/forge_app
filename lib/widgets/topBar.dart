import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forge_app/shared/env.dart';

class TopBar extends StatelessWidget {
final storage = const FlutterSecureStorage();
  Future logOut() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/Cart');
            },
            child: const Badge(
              label: Text("0"),
              child: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            ),
          ),
          Text('Iron Works Mexico', style: GlobalData.textBlack16Ht, ),
          GestureDetector(
            onTap: () {
              logOut();
              Navigator.pushReplacementNamed(context, "/Login");
            },
            child: const Icon(
              Icons.exit_to_app,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
