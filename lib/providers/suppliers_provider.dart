import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/supplier.dart';
import '../providers/util_provider.dart';

class SuppliersProvider extends ChangeNotifier {
  final String _urlBase = 'http://localhost:5088/api/';

  SuppliersProvider() {
    getSuppliers();
  }

  List<dynamic> suppliers = [];
  dynamic supplier;
  List<dynamic> doors = [];
  List<dynamic> windows = [];
  List<dynamic> pots = [];

  Future getSuppliers() async {
    final String url = '${_urlBase}suppliers';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      suppliers = jResponse;
      notifyListeners();
    }
    suppliers.forEach((element) {
      switch (element['category']) {
        case 'Window Frames':
          windows.add(element);
          break;
        case 'Door Frames':
          doors.add(element);
          break;
        case 'Pots':
          pots.add(element);
          break;
        default:
          null;
      }
    });
  }

  Future getSupplier(String id) async {
    final String url = '${_urlBase}suppliers/$id';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      supplier = Supplier.fromJson(jResponse);
      notifyListeners();
    }
  }

  Future deleteSupplier(String id) async {
    final String url = '${_urlBase}suppliers/$id';
    final response = await UtilProvider.rtp.deleteHttp(urlBase: url);
    if (response.statusCode == 204) {

      getSuppliers();
      notifyListeners();
      return true;
    }

    return false;
  }
  
  Future updateSupplier(String id, Supplier supplier) async {
    final String url = '${_urlBase}suppliers/$id';
    final response = await UtilProvider.rtp.puttHttp(urlBase: url, data: supplier);
    print(response.statusCode);
    if (response.statusCode == 204) {

      getSuppliers();
      notifyListeners();
      return true;
    }

    return false;
  }
}
