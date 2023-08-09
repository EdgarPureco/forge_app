import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forge_app/models/product.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:forge_app/screens/detailScreen.dart';
import 'package:forge_app/shared/env.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    List products = productProvider.products;

    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(product: Product.fromJson(products[index]));
          },
        ),
    );
  }
}




class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(4.0),
              ),
              child: Image.memory(base64.decode(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(product.name, style: GlobalData.textBlack18Ht),
                  SizedBox(height: 15),
                  Text("\$${product.price.toStringAsFixed(2)}",
                      style: GlobalData.textBlack16Ht),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.icon(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => DetailScreen(id: product.id,)));
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add to cart')),
                      SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(id: product.id,)));
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      label: const Text('Details')
                    ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}