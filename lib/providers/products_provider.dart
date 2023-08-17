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
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      products = jResponse;
      notifyListeners();
    }
    products.forEach((element) {
      switch (element['category']) {
        case 'Marcos de Ventana':
          windows.add(element);
          break;
        case 'Marcos de Puerta':
          doors.add(element);
          break;
        case 'Accesorios para Plantas':
          pots.add(element);
          break;
        default:
          null;
      }
    });
  }

  Future getProduct(String id) async {
    final String url = '${_urlBase}products/$id';
    final response = await UtilProvider.rtp.getHttp(urlBase: url);

    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      product = Product.fromJson(jResponse);
      notifyListeners();
    }
  }

  Future deleteProduct(String id) async {
    final String url = '${_urlBase}products/$id';
    final response = await UtilProvider.rtp.deleteHttp(urlBase: url);
    if (response.statusCode == 204) {

      getProducts();
      notifyListeners();
      return true;
    }

    return false;
  }
  
  Future updateProduct(String id, Product product) async {
    final String url = '${_urlBase}products/$id';
    final response = await UtilProvider.rtp.puttHttp(urlBase: url, data: product);
    print(response.statusCode);
    if (response.statusCode == 204) {

      getProducts();
      notifyListeners();
      return true;
    }

    return false;
  }
  
  Future insertProduct(Product product) async {
    final String url = '${_urlBase}products/';
    final response = await UtilProvider.rtp.postHttp(urlBase: url, data: product);
   
    if (response.statusCode == 204) {

      getProducts();
      notifyListeners();
      return true;
    }

    return false;
  }
}
