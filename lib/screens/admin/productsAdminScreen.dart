import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forge_app/models/product.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:forge_app/screens/detailScreen.dart';
import 'package:forge_app/shared/env.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class ProductsAdminScreen extends StatefulWidget {
  const ProductsAdminScreen({super.key});

  @override
  State<ProductsAdminScreen> createState() => _ProductsAdminScreenState();
}

class _ProductsAdminScreenState extends State<ProductsAdminScreen> {
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
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    _productNameController.text = product.name; // Set default value
    _productPriceController.text = product.price.toString(); // Set default value

    return Card(
      elevation: 3.0,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
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
                  Text(product.name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text("\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showEditProductModal(context);
                        },
                        child: Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showAddFieldsModal(context);
                        },
                        child: Text('Add Supply'),
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

  void _showEditProductModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Build and return the edit product modal
        return AlertDialog(
          title: Text('Edit Product'),
          content: Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
                onChanged: (value) {
                  // Perform validation or other actions if needed
                },
              ),
                  SizedBox(height: 10),
              TextField(
                controller: _productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                ),
              ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedProductName = _productNameController.text;
                double updatedProductPrice =
                    double.tryParse(_productPriceController.text) ?? 0.0;

                if (updatedProductName.length >= 3 &&
                    updatedProductPrice > 0) {
                  // Perform edit product logic
                  Navigator.pop(context);
                } else {
                  // Show an error message or handle invalid input
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddFieldsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Build and return the add fields modal
        return AlertDialog(
          title: Text('Add Fields'),
          content: Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text("\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform add fields logic
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
