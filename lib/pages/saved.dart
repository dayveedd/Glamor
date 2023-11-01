// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/utils/saved_utils/saved_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/cart_items.dart';
import '../utils/cart_model.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({super.key});

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  @override
  Widget build(BuildContext context) {
    final savedItems = Provider.of<SavedModel>(context).savedItems;
    SavedModel savedModel = Provider.of<SavedModel>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          focusNode: FocusNode(),
                          decoration: InputDecoration(
                            hintText: 'search anything...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            suffixIcon: Icon(Icons.search, size: 30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    //the filter_list icon container
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFB738B7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //saved header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back,
                                size: 35,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Saved Items',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.grey,
                          size: 35,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 550,
                  child: ListView.builder(
                    itemCount: savedItems.length,
                    itemBuilder: (context, index) {
                      final savedItem = savedItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  savedItem.image,
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
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 113,
                                        height: 45,
                                        child: Text(
                                          savedItem.productName,
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
                                        savedItem.price,
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
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                final item = savedItem;
                                                savedModel
                                                    .removeFromSaved(item);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'REMOVE',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFFB738B7),
                                                foregroundColor: Colors.white),
                                            onPressed: () {
                                              if (!Provider.of<CartModel>(
                                                      context,
                                                      listen: false)
                                                  .cartItems
                                                  .any((existingItem) =>
                                                      existingItem
                                                          .productName ==
                                                      savedItem.productName)) {
                                                CartItem newItem = CartItem(
                                                    image: savedItem.image,
                                                    productName: savedItem.productName,
                                                    price: savedItem.price);
                                                Provider.of<CartModel>(context,
                                                        listen: false)
                                                    .addToCart(newItem);
                                                //cartItems[itemName] = 1;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'item successfully added to cart',
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFF00A991),
                                                  duration:
                                                      Duration(seconds: 5),
                                                  action: SnackBarAction(
                                                      label: 'ok',
                                                      textColor: Colors.white,
                                                      onPressed: () {}),
                                                ));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'item already exist in cart!'),
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor:
                                                      Color(0xFF00A991),
                                                ));
                                              }
                                            },
                                            child: Text('ADD TO CART')),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
