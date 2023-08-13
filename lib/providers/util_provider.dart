import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UtilProvider extends ChangeNotifier {
  static final UtilProvider rtp = UtilProvider._();
  UtilProvider._();
  final storage = const FlutterSecureStorage();
  String token = '';

  Future getToken() async {
    String? value = await storage.read(key: 'token');
    if(value!=null){
      token = value;
    }
  }


  Future getHttp({required String urlBase}) async {
    await getToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token' 
    };
    var response = await http.get(Uri.parse(urlBase), headers: headers);
    return response;
  }

  Future deleteHttp({required String urlBase}) async {
    await getToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token' 
    };

    var response = await http.delete(
      Uri.parse(urlBase),
      headers: headers,
    );
    
    return response;
  }
  
  Future postHttp({required String urlBase, required dynamic data}) async {
  await getToken();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token' 
  };
  var jsonData = jsonEncode(data);
  var response = await http.post(
    Uri.parse(urlBase),
    headers: headers,
    body: jsonData,
  );

  print(jsonData);

  return response;
}
  
  
  Future puttHttp({required String urlBase, required dynamic data}) async {
  await getToken();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token' 
  };
  var jsonData = jsonEncode(data);
  var response = await http.put(
    Uri.parse(urlBase),
    headers: headers,
    body: jsonData,
  );

  print(jsonData);

  return response;
}


  Future login(
      {required String urlBase,
      required String email,
      required String password}) async {
    final body = {'email': email, 'password': password};

    var response = await http.post(
      Uri.parse(urlBase),
      body: jsonEncode(body),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future checkSession() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues['inSesion'] == 'true') {
      return 1;
    } else {
      return 0;
    }
  }

  Future saveStrorage({required String email, required String password}) async {
    var response = await login(
        urlBase: 'http://localhost:5088/api/login/',
        email: email,
        password: password);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      await storage.write(key: 'token', value: data['token']);
      await storage.write(key: 'role', value: data['role']);
      await storage.write(key: 'name', value: data['name']);
      await storage.write(key: 'inSesion', value: data['authenticated'].toString());

      if(data['authenticated']!=true){
        await storage.write(key: 'message', value: data['message']);
        return 0;
      }else{
        return 1;
      }
    }
  }

  Future clearSesion() async {
    await storage.deleteAll();
  }
}
