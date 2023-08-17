import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forge_app/models/product.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:forge_app/widgets/topBarAdmin.dart';
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
      appBar: TopBarAdmin(),
      endDrawer: SideMenu(),
      body: ProductList(
        products: products,
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  final List products;

  ProductList({required this.products});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Scroll vertical
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Scroll horizontal dentro del vertical
        child: DataTable(
          showBottomBorder: true,
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Mesures')),
            DataColumn(label: Text('Options')),
            DataColumn(label: Text('Image')),
          ],
          rows: widget.products.map((product) {
          return DataRow(
            cells: [
              DataCell(Text(product['id'].toString())),
              DataCell(Text(product['name'])),
              DataCell(Text('\$${product['price'].toStringAsFixed(2)}')),
              DataCell(Text(product['description'])),
              DataCell(Text(product['category'])),
              DataCell(Column(
                children: [
                  Text('Width: ' + product['width']),
                  Text('Length: ' + product['length']),
                  Text('Height: ' + product['height']),
                ],
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showEditProductModal(context, product);
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationModal(
                          context, product['id'].toString());
                    },
                  ),
                ],
              )),
              DataCell(Image.memory(base64.decode(product['image']))),
            ],
          );
        }).toList(),
        ),
      ),
    );
  }

  

  void _showEditProductModal(BuildContext context, product) {
    product = Product.fromJson(product);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditProductModal(
          product: product,
          context: context,
        );
      },
    );
  }

  void _showDeleteConfirmationModal(BuildContext context, String id) {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              label: Text('Accept'),
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                productProvider.deleteProduct(id).then((value) => {
                      if (value)
                        {
                          Flushbar(
                            message: "Deleted Successfuly",
                            icon: Icon(
                              Icons.error,
                              size: 28.0,
                              color: Colors.green,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.green,
                          )..show(context)
                        }
                      else
                        {
                          Flushbar(
                            message: "Error While Deleting",
                            icon: Icon(
                              Icons.error,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context)
                        }
                    });
              },
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.white70),
              ),
              label: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              icon: Icon(
                Icons.do_disturb,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

class EditProductModal extends StatefulWidget {
  final Product product;
  final BuildContext context;

  EditProductModal({required this.product, required this.context});

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  String newName = '';
  String newDescription = '';
  String newCategory = '';
  String newWidth = '';
  String newLength = '';
  String newHeight = '';
  double newPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductsProvider>(widget.context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Product Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.name,
              onChanged: (newValue) {
                setState(() {
                  newName = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.price.toString(),
              onChanged: (newValue) {
                setState(() {
                  newPrice = double.parse(newValue);
                });
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Precio'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.description,
              onChanged: (newValue) {
                setState(() {
                  newDescription = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
             TextFormField(
              readOnly: true,
              initialValue: widget.product.category,
              onChanged: (newValue) {
                setState(() {
                  newWidth = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.width,
              onChanged: (newValue) {
                setState(() {
                  newWidth = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Width'),
            ),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.length,
              onChanged: (newValue) {
                setState(() {
                  newLength = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Length'),
            ),
            TextFormField(
              readOnly: true,
              initialValue: widget.product.height,
              onChanged: (newValue) {
                setState(() {
                  newHeight = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Height'),
            ),
            const SizedBox(height: 16),
            ],
        ),
      ),
    );
  }

  bool _dataHasChanged() {
    return newName.isNotEmpty ||
        newDescription.isNotEmpty ||
        newCategory.isNotEmpty ||
        newWidth.isNotEmpty ||
        newLength.isNotEmpty ||
        newHeight.isNotEmpty ||
        newPrice != 0.0;
  }

  String _getSelectedCategory() {
  if (widget.product.category == 'Marcos de Puerta' ||
      widget.product.category == 'Marcos de Ventana' ||
      widget.product.category == 'Accesorios para Plantas') {
    return widget.product.category;
  } else {
    return 'Marcos de Puerta'; // Selecciona la primera categoría por defecto
  }
}

}
