import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forge_app/shared/env.dart';

import 'HomeScreen.dart';

import 'package:forge_app/providers/login_provider.dart';
import 'package:forge_app/providers/util_provider.dart';
import 'package:forge_app/themes/app_theme.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/util.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: Image.asset('assets/logo.png'),
        ),
        Text(
          'Iron Works Mexico',
          style: GlobalData.textBlack40,
        ),
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => LoginFormprovider(),
            ),
          ],
          child: const login(),
        ),
      ],
    )));
  }
}

class login extends StatelessWidget {
  const login({
    super.key,
  });
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final lfp = Provider.of<LoginFormprovider>(context);
    return SingleChildScrollView(
      child: Form(
          key: lfp.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            onChanged: (value) => lfp.user = value,
                            validator: (value) {
                              return (value != null && value.length > 3)
                                  ? null
                                  : 'El email necesita minimo 3 caracteres';
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => lfp.password = value,
                            validator: (value) {
                              return (value != null && value.length > 3)
                                  ? null
                                  : 'La contraseña necesita minimo 3 caracteres';
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            if (!lfp.isValidForm()) return;
                            lfp.isLoading = true;
                            await Future.delayed(const Duration(seconds: 1));

                            if (lfp.user != null && lfp.password != null) {
                              UtilProvider.rtp.saveStrorage(
                                  email: lfp.user, password: lfp.password);
                              final rest = await UtilProvider.rtp.saveStrorage(
                                  email: lfp.user, password: lfp.password);

                              if (rest == 1) {
                                SuccesDialog.msgDialog(
                                    context: context,
                                    texto: "Logged In",
                                    dgt: DialogType.success,
                                    onPress: () async {
                                      String? value = await storage.read(key: 'name');
                                       String? role = await storage.read(key: 'role');
                                      if (value != null) {
                                        NotificationsService.showSnackBar(
                                            message:
                                                'Good to see you again ${value}',
                                            type: 1);
                                      } else {
                                        NotificationsService.showSnackBar(
                                            message: 'Good to see you again',
                                            type: 1);
                                      }
                                      if(role!.contains('customer')){
                                        Navigator.pushReplacementNamed(
                                          context, '/Home');
                                      }else{
                                        Navigator.pushReplacementNamed(
                                          context, '/Admin/Products');
                                      }
                                    }).show();
                              } else {
                                ErrorDialog.msgDialog(
                                    context: context,
                                    texto: "Error",
                                    dgt: DialogType.error,
                                    onPress: () async {
                                      String? value =
                                          await storage.read(key: 'message');
                                      if (value != null) {
                                        NotificationsService.showSnackBar(
                                            message: value, type: 0);
                                      }
                                    }).show();
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  ' Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
