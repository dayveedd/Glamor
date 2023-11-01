// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../utils/cart_items.dart';
import '../utils/cart_model.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<TextStyle> priceStyles = [
    TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'QuickSand')
  ];

  void increaseProductCount(CartItem item) {
    setState(() {
      item.count++;
    });
  }

  void decreaseProductCount(CartItem item) {
    setState(() {
      if (item.count > 1) {
        item.count--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartModel>(context).cartItems;
    CartModel cartModel = Provider.of<CartModel>(context);
    bool isCartEmpty = cartItems.isEmpty;
    double subTotal = 0;
    // for (final cartItem in cartItems) {
    //   double itemPrice = double.parse(cartItem.price);
    //   subTotal += itemPrice * cartItem.count;
    // }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Cart Summary',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[200],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SubTotal',
                              style: priceStyles[0],
                            ),
                            Text(
                              subTotal.toString(),
                              style: priceStyles.first,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Text(
                          'excluding delivery fee',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    //height: double.maxFinite,
                    height: 450,
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: 600,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 118,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF2F4F7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 38,
                                        height: 88,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 26,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    cartItem.image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 113,
                                          height: 45,
                                          child: Text(
                                            cartItem.productName,
                                            style: TextStyle(
                                              color: Color(0xFF151A20),
                                              fontSize: 11,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 31),
                                        Text(
                                          cartItem.price,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color(0xFF151A20),
                                            fontSize: 16,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('brand:'),
                                        SizedBox(
                                          width: 78,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFB738B7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      decreaseProductCount(
                                                          cartItem);
                                                    },
                                                    child: Icon(Icons.remove)),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(cartItem.count.toString()),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFB738B7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        increaseProductCount(
                                                            cartItem);
                                                      },
                                                      child: Icon(Icons.add))),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Delete item?'),
                                                            content: Text(
                                                                'do you want to delete this item?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                child:
                                                                    Text('No'),
                                                              ),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    final item =
                                                                        cartItem;
                                                                    cartModel
                                                                        .removeFromCart(
                                                                            item);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'Yes'))
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                              Text(
                                                'Remove',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 58,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Buy in bulk?'),
                                                    content: Text(
                                                        'Register as a supplier to buy in bulk'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text('OK'))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text(
                                            'BUY IN BULK',
                                            style: TextStyle(
                                              color: Color(0xFF151A20),
                                              fontSize: 12,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: isCartEmpty
                              ? Colors.grey[200]
                              : Color(0xFFB738B7),
                          foregroundColor: Colors.white,
                          minimumSize: Size(250, 60)),
                      onPressed: isCartEmpty
                          ? null
                          : () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UsePaypal(
                                      sandboxMode: true,
                                      clientId:
                                          "ATV0gwYdr9NIBE83ROg7QNW1yzqH4y8ayzXdheDKggwWMcvojD_HhPZe-P23LAJRylDo8wH4Ff2T8QvG",
                                      secretKey:
                                          "EHLOb9MMQYs13UUkfxF1pQ-oq_ed9PeZSPl1ma89pTssSTnCbP8XYIn086F-9VH6MoUjC9Mp37JktaVB",
                                      returnURL:
                                          "https://samplesite.com/return",
                                      cancelURL:
                                          "https://samplesite.com/cancel",
                                      transactions: const [
                                        {
                                          "amount": {
                                            "total": '10.12',
                                            "currency": "USD",
                                            "details": {
                                              "subtotal": '10.12',
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description":
                                              "The payment transaction description.",
                                          // "payment_options": {
                                          //   "allowed_payment_method":
                                          //       "INSTANT_FUNDING_SOURCE"
                                          // },
                                          "item_list": {
                                            "items": [
                                              {
                                                "name": "A demo product",
                                                "quantity": 1,
                                                "price": '10.12',
                                                "currency": "USD"
                                              }
                                            ],

                                            // shipping address is not required though
                                            // "shipping_address": {
                                            //   "recipient_name": "Jane Foster",
                                            //   "line1": "Travis County",
                                            //   "line2": "",
                                            //   "city": "Austin",
                                            //   "country_code": "US",
                                            //   "postal_code": "73301",
                                            //   "phone": "+00000000",
                                            //   "state": "Texas"
                                            // },
                                          }
                                        }
                                      ],
                                      note:
                                          "Contact us for any questions on your order.",
                                      onSuccess: (Map params) async {
                                        print("onSuccess: $params");
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                      },
                                      onCancel: (params) {
                                        print('cancelled: $params');
                                      })));
                            },
                      child: Text('PROCEED TO CHECKOUT'))
                ],
              ),
            ),
          ),
        ));
  }
}
