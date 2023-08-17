import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
              label: Text("1"),
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
          ),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.65,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          GestureDetector(
            onTap: () {
              logOut();
              Navigator.pushReplacementNamed(context, "/Login");
            },
            child: const Badge(
              child: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
