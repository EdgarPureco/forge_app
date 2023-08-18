import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/user.dart';
import '../providers/util_provider.dart';

class UsersProvider extends ChangeNotifier {
  final String _urlBase = 'http://192.168.100.24:5088/api/';

  UsersProvider() {
    getUsers();
  }

  List<dynamic> users = [];
  dynamic user;
  List<dynamic> doors = [];
  List<dynamic> windows = [];
  List<dynamic> pots = [];

  Future getUsers() async {
    final String url = '${_urlBase}users';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      users = jResponse;
      notifyListeners();
    }
  }

  Future getUser(String id) async {
    final String url = '${_urlBase}users/$id';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      user = User.fromJson(jResponse);
      notifyListeners();
    }
  }

  Future deleteUser(String id) async {
    final String url = '${_urlBase}users/$id';
    final response = await UtilProvider.rtp.deleteHttp(urlBase: url);
    if (response.statusCode == 204) {

      getUsers();
      notifyListeners();
      return true;
    }

    return false;
  }
  
  Future updateUser(String id, User user) async {
    final String url = '${_urlBase}users/$id';
    var roleId = 0;
    switch (user.role) {
      case 'admin':
        roleId = 1;
        break;
      case 'seller':
        roleId = 2;
        break;
      case 'stocker':
        roleId = 3;
        break;
    }

    var data = {
      'email': user.email,
      'roleId': roleId
    };
    
    final response = await UtilProvider.rtp.puttHttp(urlBase: url, data: data);
    print(response.statusCode);
    if (response.statusCode == 204) {

      getUsers();
      notifyListeners();
      return true;
    }

    return false;
  }
}
