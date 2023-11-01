// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../catalogue/catalogue.dart';
import '../utils/cart_items.dart';
import '../utils/cart_model.dart';
import '../utils/saved_utils/saved_items.dart';
import '../utils/saved_utils/saved_model.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  var searchName = '';
  final List<BoxDecoration> discountContainer = [
    BoxDecoration(
        color: Colors.greenAccent, borderRadius: BorderRadius.circular(8)),
    BoxDecoration(
        color: Color.fromARGB(255, 240, 214, 1),
        borderRadius: BorderRadius.circular(8)),
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    BoxDecoration(
        color: Colors.pink[200], borderRadius: BorderRadius.circular(8)),
    BoxDecoration(
        color: Color.fromARGB(255, 240, 214, 1),
        borderRadius: BorderRadius.circular(8)),
    BoxDecoration(
        color: Colors.greenAccent, borderRadius: BorderRadius.circular(8))
  ];

  bool isFavourited = false;
  bool isAdded = false;

  final List<TextStyle> textStyles = [
    TextStyle(
        color: Color(0xFFB738B7), fontSize: 25, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
  ];

  final discountText = [TextStyle(color: Colors.black, fontSize: 8)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFFB738B7),
        title: Text('Search'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Adjust the height as needed
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchName = value;
                              });
                            },
                            decoration: InputDecoration(
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
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    // final query = _searchController.text;
                                    // if (query.isNotEmpty) {
                                    //   _searchItems(query);
                                    // }
                                  },
                                  icon: Icon(Icons.search, size: 30)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      // The filter_list icon container
                      Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            Icon(Icons.filter_list, color: Colors.purple[400]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers:<Widget>[
           SliverToBoxAdapter(
             child: SafeArea(
                     child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Suggested items'),
                  SizedBox(height: 15,),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('popular').orderBy('product name'.toLowerCase()).startAt([searchName]).endAt(["$searchName\uf8ff"])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        //if an error occured
                        if (snapshot.hasError) {
                          return Text('${snapshot.error} there was an error');
                        }
                        //loading of the page
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        //to check if there is data in the firestore collection
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 1.5,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12),
                              itemCount: documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                String itemName =
                                    documents[index]['product name'];
                                String itemImage =
                                    documents[index]['product image'];
                                String itemPrice = documents[index]['price'];
                                String itemDiscount =
                                    documents[index]['discount'];
                                // String itemImage = documents[index]['product image'];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Catalogue(
                                                itemImage: itemImage,
                                                productName: itemName,
                                                price: itemPrice,
                                              ))),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x0C000000),
                                              blurRadius: 48,
                                              offset: Offset(0, 24),
                                              spreadRadius: -5)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                decoration:
                                                    discountContainer[index],
                                                child: Text(
                                                  itemDiscount,
                                                  style: discountText.first,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  SavedItem newItem = SavedItem(
                                                      productName: itemName,
                                                      price: itemPrice,
                                                      image: itemImage);
                                                  Provider.of<SavedModel>(context,
                                                          listen: false)
                                                      .addToSaved(newItem);
                                                  setState(() {
                                                    isFavourited = !isFavourited;
                                                  });
                                                },
                                                icon: Icon(
                                                  isFavourited
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_border_outlined,
                                                  color: isFavourited
                                                      ? Color(0xFFB738B7)
                                                      : Color.fromARGB(
                                                          255, 112, 112, 112),
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: itemImage,
                                          height: 100,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 113,
                                                  height: 45,
                                                  child: Text(
                                                    itemName,
                                                    style: TextStyle(
                                                      color: Color(0xFF151A20),
                                                      fontSize: 11,
                                                      fontFamily: 'Quicksand',
                                                      fontWeight: FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  itemPrice,
                                                  style: textStyles[1],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color(0x66E5A3E5),
                                                        blurRadius: 14,
                                                        offset: Offset(0, 7),
                                                        spreadRadius: 0)
                                                  ],
                                                  color: Colors.white),
                                              child: IconButton(
                                                  onPressed: () {
                                                    CartItem newItem = CartItem(
                                                        image: itemImage,
                                                        productName: itemName,
                                                        price: itemPrice);
                                                    Provider.of<CartModel>(
                                                            context,
                                                            listen: false)
                                                        .addToCart(newItem);
                                                    setState(() {
                                                      isAdded = !isAdded;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    isAdded
                                                        ? Icons
                                                            .remove_shopping_cart
                                                        : Icons.add_shopping_cart,
                                                    color: isAdded
                                                        ? Color(0xFFB738B7)
                                                        : Color.fromARGB(
                                                            255, 112, 112, 112),
                                                  )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(child: Text('item not available',style: textStyles.first,));
                        }
                      }),
                ],
              ),
                     ),
                   ),
           ),
        ]
      ),
    );
  }
}
