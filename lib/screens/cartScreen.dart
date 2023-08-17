import 'package:flutter/material.dart';
import 'package:forge_app/providers/products_provider.dart';
import 'package:forge_app/shared/env.dart';
import 'package:forge_app/widgets/topBar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    List cartItems = [];

    if (cartItems.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 5, bottom: 15, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBar(),
                      // FIN TOPBAR

                      Center(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/cart.png'),
                              SizedBox(height: 20.0),
                              Text(
                                "Sorry, It looks like your cart is empty",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/Home');
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text('Go to Home'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    }
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TopBar(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 50),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x320E151B),
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Hero(
                                tag: 'ControllerImage',
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(base64.decode(cartItems[index]['image']),
                                    
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                      child: Text(
                                        cartItems[index]['name'],
                                        style: GlobalData.textWhite20,
                                      ),
                                    ),
                                    Text(
                                      '\$${cartItems[index]['price']}',
                                      style: GlobalData.textWhite18,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                      child: Text(
                                        'Quanity: ${cartItems[index]['quantity']}',
                                        style: GlobalData.textWhite16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xFFE86969),
                                  size: 20,
                                ),
                                onPressed: () {
                                  // Remove item
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
