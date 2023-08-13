import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.person,
            size: 30,
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
              Navigator.pushReplacementNamed(context, '/Cart');
            },
            child: const Badge(
              label: Text("1"),
              child: Icon(
                Icons.shopping_bag,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
