import 'package:forge_app/models/product.dart';
import 'package:forge_app/shared/env.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).getProduct('1');
    super.initState();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    Product product = productProvider.product;

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.asset('assets/images/main_image.png'),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.id.toString(),
                          style: GlobalData.textGrey18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: GlobalData.textBlack30,
                            ),
                            Text(
                              '\$${product.price}',
                              style: GlobalData.textBlack24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          product.category,
                          style: GlobalData.textBlack22,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          product.description,
                          style: GlobalData.textBlack22,
                        ),
                        const SizedBox(height: 15),
                        FilledButton.icon(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('Modal BottomSheet'),
                                          ElevatedButton(
                                              child: const Text('Accept'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Flushbar(
                                                  title: "Success",
                                                  message:
                                                      "Product Was Deleted",
                                                  backgroundGradient:
                                                      LinearGradient(colors: [
                                                    Colors.blue,
                                                    Colors.teal
                                                  ]),
                                                  backgroundColor: Colors.red,
                                                  boxShadows: [
                                                    BoxShadow(
                                                      color: Colors.red,
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 3.0,
                                                    )
                                                  ],
                                                )..show(context);
                                              }),
                                          ElevatedButton(
                                            child:
                                                const Text('Close BottomSheet'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.remove_red_eye_outlined),
                            label: Text('Delete')),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
