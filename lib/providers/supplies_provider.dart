import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/supply.dart';
import '../providers/util_provider.dart';

class SuppliesProvider extends ChangeNotifier {
  final String _urlBase = 'http://192.168.100.24:5088/api/';

  SuppliesProvider() {
    getSupplies();
  }

  List<dynamic> supplies = [];
  dynamic supply;
  List<dynamic> doors = [];
  List<dynamic> windows = [];
  List<dynamic> pots = [];

  Future getSupplies() async {
    final String url = '${_urlBase}supplies';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      supplies = jResponse;
      notifyListeners();
    }

  }

  Future getSupply(String id) async {
    final String url = '${_urlBase}supplies/$id';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      supply = Supply.fromJson(jResponse);
      notifyListeners();
    }
  }

  Future deleteSupply(String id) async {
    final String url = '${_urlBase}supplies/$id';
    final response = await UtilProvider.rtp.deleteHttp(urlBase: url);
    if (response.statusCode == 204) {

      getSupplies();
      notifyListeners();
      return true;
    }

    return false;
  }
  
  Future updateSupply(String id, Supply supply) async {
    final String url = '${_urlBase}supplies/$id';
    final response = await UtilProvider.rtp.puttHttp(urlBase: url, data: supply);
    print(response.statusCode);
    if (response.statusCode == 204) {

      getSupplies();
      notifyListeners();
      return true;
    }

    return false;
  }
}
