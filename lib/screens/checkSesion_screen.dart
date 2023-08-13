import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forge_app/providers/util_provider.dart';
import 'package:flutter/material.dart';

class CheckSesionScreen extends StatelessWidget {
  const CheckSesionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: UtilProvider.rtp.checkSession(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            Future.microtask(
                () => Navigator.pushReplacementNamed(context, "/Login"));
          }

          if (snapshot.data == 1) {
            if(storage.read(key: 'role') == 'customer'){
              Future.microtask(
                () => Navigator.pushReplacementNamed(context, "/Home"));
            }else{
              Future.microtask(
                () => Navigator.pushReplacementNamed(context, "/Admin/Products"));
            }
          } else {
            Future.microtask(
                () => Navigator.pushReplacementNamed(context, "/Login"));
          }

          return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/logo.png'),
            );
        },
      ),
    );
  }
}
