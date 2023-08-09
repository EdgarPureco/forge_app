import 'package:flutter/material.dart';
import 'package:forge_app/shared/env.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List cartItems = ['1', '2'];
    return Container(
      child: ListView.builder(
    padding: EdgeInsets.zero,
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
            color: Colors.red,
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
                    child: Image.network(
                      cartItems[index].image,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text(
                          cartItems[index].name,
                          style: GlobalData.textBlack24,
                        ),
                      ),
                      Text(
                        '\$${cartItems[index].price}',
                        style: GlobalData.textBlack22,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          'Quanity: ${cartItems[index].quantity}',
                          style: GlobalData.textBlack22,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
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
    );
  }
}