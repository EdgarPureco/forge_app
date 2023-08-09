import 'package:flutter/material.dart';

class LoginFormprovider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String user = '';
  String password = '';
  String role = '';
  String name = '';
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }

  
}
