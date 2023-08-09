import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/product.dart';
import '../providers/util_provider.dart';

class ProductsProvider extends ChangeNotifier {
  final String _urlBase = 'http://localhost:5088/api/';

  ProductsProvider() {
    getProducts();
  }

  List<dynamic> products = [];
  dynamic product;
  List<dynamic> doors = [];
  List<dynamic> windows = [];
  List<dynamic> pots = [];

  Future getProducts() async {
    final String url = '${_urlBase}products';
    final response = await UtilProvider.rtp.responseHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      products = jResponse;
      notifyListeners();
    }
    products.forEach((element) {
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
  
  Future getProduct(String id) async {
    final String url = '${_urlBase}products/$id';
    final response = await UtilProvider.rtp.responseHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      product = Product.fromJson(jResponse);
      notifyListeners();
    }

  }

  Future deleteProduct(String id) async {
    final String url = '${_urlBase}products/$id';
    await UtilProvider.rtp.deleteHttp(urlBase: url);

    getProducts();
    notifyListeners();
    return true;
  }
}
