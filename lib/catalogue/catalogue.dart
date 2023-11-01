// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/cart_items.dart';
import '../utils/cart_model.dart';

class Catalogue extends StatefulWidget {
  final String itemImage;
  final String productName;
  final String price;

  const Catalogue({
    super.key,
    required this.itemImage,
    required this.productName,
    required this.price,
  });

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  bool isFavorited = false;
  bool isAdded = false;

  final List<TextStyle> headStyles = [
    TextStyle(
      color: Color(0xFF87809A),
      fontSize: 14,
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.w500,
      height: 0,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 35,
                                color: Colors.grey,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Product Details',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search_outlined,
                                color: Colors.grey,
                                size: 35,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.grey,
                                size: 35,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                //the image container
                Container(
                  width: 350,
                  height: 272,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 125,
                        height: 156,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.itemImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: Text(
                        widget.productName,
                        style: TextStyle(
                          color: Color(0xFF151A20),
                          fontSize: 18,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_outlined,
                                size: 35,
                                color: Color(0xFFB738B7),
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavorited = !isFavorited;
                                });
                              },
                              icon: Icon(
                                isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isFavorited
                                    ? Color(0xFFB738B7)
                                    : Color(0xFFB738B7),
                                size: 35,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Brand:',
                          style: headStyles.first,
                        ),
                        Text(
                          'price:',
                          style: headStyles[0],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stock:',
                          style: headStyles.first,
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRODUCT DETAILS',
                        style: headStyles[0],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(0xFF87809A)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DESCRIPTION'),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_drop_down_outlined))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Nivea Body Milk Lotion with Deep Moisture is a luxurious, nourishing body lotion that provides intense hydration to the skin. Infused with the powerful antioxidant Q10, this lotion helps to improve skin firmness and smoothness, leaving the skin feeling soft, supple, and radiant. The lightweight formula absorbs quickly into the skin without leaving any sticky or greasy residue, making it suitable for all skin types, including sensitive skin.',
                          style: TextStyle(height: 1.5),
                        ),
                      )
                      // StreamBuilder<QuerySnapshot>(
                      //     stream: FirebaseFirestore.instance
                      //         .collection('popular')
                      //         .snapshots(),
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<QuerySnapshot> snapshot) {
                      //       if (snapshot.hasError) {
                      //         return Text('${snapshot.error}');
                      //       }
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return CircularProgressIndicator();
                      //       }
                      //       if (snapshot.hasData &&
                      //           snapshot.data!.docs.isNotEmpty) {
                      //         final List documents = snapshot.data!.docs;
                      //         return ListView.builder(
                      //           itemCount: documents.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             final List itemDescription =
                      //                 documents[index]['description'];
                      //             return SizedBox(
                      //               width: 200,
                      //               height: 200,
                      //               child: Text(
                      //                 itemDescription.toString(),
                      //                 style: TextStyle(
                      //                   color: Color(0xFF151A20),
                      //                   fontSize: 18,
                      //                   fontFamily: 'Quicksand',
                      //                   fontWeight: FontWeight.w500,
                      //                   height: 0,
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       } else {
                      //         return Text('no data found');
                      //       }
                      //     })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB738B7),
                      foregroundColor: Colors.white,
                      minimumSize: Size(270, 60)),
                  onPressed: () {
                    CartItem newItem = CartItem(
                        image: widget.itemImage,
                        productName: widget.productName,
                        price: widget.price);
                    Provider.of<CartModel>(context, listen: false)
                        .addToCart(newItem);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Cart()));
                  },
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Quicksand',
                        letterSpacing: 1.5),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFB738B7))),
              child: IconButton(
                  onPressed: () {
                    CartItem newItem = CartItem(
                        image: widget.itemImage,
                        productName: widget.productName,
                        price: widget.price);
                    Provider.of<CartModel>(context, listen: false)
                        .addToCart(newItem);
                    setState(() {
                      isAdded = !isAdded;
                    });
                  },
                  icon: Icon(
                    isAdded
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                    color: Color(0xFFB738B7),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
