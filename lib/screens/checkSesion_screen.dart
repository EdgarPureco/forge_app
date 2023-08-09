import 'package:forge_app/providers/util_provider.dart';
// import 'package:forge_app/themes/app_theme.dart';
// import 'package:forge_app/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class CheckSesionScreen extends StatelessWidget {
  const CheckSesionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: UtilProvider.rtp.checkSession(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('assets/logo.png'),
            );
          }

          if (snapshot.data == 1) {
            Future.microtask(
                () => Navigator.pushReplacementNamed(context, "/Home"));
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
