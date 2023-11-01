// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/categories.dart';
import 'package:ecommerce/pages/profile.dart';
import 'package:ecommerce/pages/saved.dart';
import 'package:ecommerce/utils/cart_items.dart';
import 'package:ecommerce/utils/cart_model.dart';
import 'package:ecommerce/utils/saved_utils/saved_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../catalogue/catalogue.dart';
import '../search/search.dart';
import 'package:provider/provider.dart';

import '../utils/saved_utils/saved_items.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    Categories(),
    Cart(),
    SavedItems(),
    UserProfile()
  ];

  Widget _buildNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index
                  ? Color(0xFFB738B7)
                  : Colors.transparent,
            ),
            padding: EdgeInsets.all(12),
            child: Icon(
              icon,
              color: _currentIndex == index ? Colors.white : Colors.grey[400],
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color:
                    _currentIndex == index ? Colors.white : Colors.grey[400]),
          )
        ],
      ),
    );
  }

  // void getImageUrls() async{
  //   //querying the collection documents
  //   List<QueryDocumentSnapshot> documents = (await FirebaseFirestore.instance.collection('popular').get()).docs;

  //   //using a for in loop to iterate over the documents
  //   for(QueryDocumentSnapshot document in documents){
  //     String itemImage = document['product image'];
  //     //create a firebase reference from the gs:// images
  //     Reference storageReference = FirebaseStorage.instance.refFromURL(itemImage);
  //     //get the download url for the images
  //     String imageUrl = await storageReference.getDownloadURL();
  //     imageUrls.add(imageUrl);
  //   }
  // }

  //  @override
  // void initState() {
  //   super.initState();
  //   getImageUrls();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _pages[_currentIndex],

      //the bottom app bar
      bottomNavigationBar: BottomAppBar(
        height: 70,
        //elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Home'),
            _buildNavItem(1, Icons.category, 'Categories'),
            _buildNavItem(2, Icons.shopping_cart, 'Cart'),
            _buildNavItem(3, Icons.favorite, 'Saved'),
            _buildNavItem(4, Icons.person, 'profile'),
          ],
        ),
      ),

      //the menu drawer
      drawer: Drawer(
        // Add your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFB738B7),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            //Image.asset('images/All.png'),
            ListTile(
              title: Text('Categories'),
              leading: Image.asset(
                'images/all.png',
                color: Colors.purple[400],
              ),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Orders'),
              leading: Image.asset('images/orders.png'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: Text('Saved items'),
              leading: Image.asset('images/saved.png'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: Text('Voucher'),
              leading: Image.asset('images/vouchers.png'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: Text('Profile'),
              leading: Image.asset('images/profile.png'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: Text('Help'),
              leading: Image.asset('images/help.png'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            SizedBox(
              height: 100,
            ),
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(0, 60),
                          backgroundColor: Color(0xFFB738B7)),
                      onPressed: () {},
                      child: Text('BECOME A SUPPLIER')),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'LOG OUT',
                  style: TextStyle(color: Colors.red[300]),
                ))
            // Add more items as needed
          ],
        ),
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  Map<String, int> cartItems = {};
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final List<Map<String, dynamic>> carouselData = [
    {
      'image': 'images/Everyday_Makeup (1).png',
      'text': 'MARIA-X\nPRO ESA\nMAKEUP KIT',
      'backgroundColor': Color(0xFFFFE6FF),
    },
    {
      'image': 'images/Everyday_Makeup (2).png',
      'text': 'july Clearance\nSales on NOVAGE\nProducts',
      'backgroundColor': Color(0xFFFDC0C5),
    },
    {
      'image': 'images/Everyday_Makeup (3).png',
      'text': 'DISCOUNTED\nPRICES ON VERSED\nSKINCARE\nPRODUCTS',
      'backgroundColor': Color(0xFFB738B7),
    },
  ];

  final List<TextStyle> textStyles = [
    TextStyle(
        color: Color(0xFFB738B7), fontSize: 25, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)
  ];

  final List<Map<String, dynamic>> categoryData = [
    {'image': 'images/all.png', 'text': 'All', 'color': Color(0xFFB738B7)},
    {
      'image': 'images/skincare.png',
      'text': 'Skin care',
      'color': Colors.white
    },
    {
      'image': 'images/foundation.png',
      'text': 'Foundation',
      'color': Colors.white
    },
    {
      'image': 'images/lipstick.png',
      'text': 'Lip stick',
      'color': Colors.white
    },
    {'image': 'images/powders.png', 'text': 'Powder', 'color': Colors.white},
    {
      'image': 'images/fragrance.png',
      'text': 'Fragrance',
      'color': Colors.white
    },
    {'image': 'images/see_all.png', 'text': 'See all', 'color': Colors.white},
  ];

  final List<TextStyle> textStyling = [
    TextStyle(color: Colors.white, fontSize: 14),
    TextStyle(color: Colors.black, fontSize: 14),
    TextStyle(color: Colors.black, fontSize: 11),
    TextStyle(color: Colors.black, fontSize: 14),
    TextStyle(color: Colors.black, fontSize: 14),
    TextStyle(color: Colors.black, fontSize: 14),
    TextStyle(color: Colors.black, fontSize: 14),
  ];

  final headerStyling = [
    TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      fontFamily: 'Quicksand',
    ),
  ];

  final discountText = [TextStyle(color: Colors.black, fontSize: 8)];

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

  final List<BoxDecoration> carouselContainers = [
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))
  ];

  List<String> imageUrls = [
    'gs://ecommerce-271f8.appspot.com/clarins.png'
        'gs://ecommerce-271f8.appspot.com/chanelperfume.png'
        'gs://ecommerce-271f8.appspot.com/fixedpowder.png'
        'gs://ecommerce-271f8.appspot.com/nivea.png'
        'gs://ecommerce-271f8.appspot.com/mattelipstick.png'
        'gs://ecommerce-271f8.appspot.com/clinique.png'
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10), // Adjust the height as needed
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SearchProducts())),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search anything...',
                                    style: TextStyle(color: Color(0xFF87809A)),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Color(0xFF87809A),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      //the filter_list icon container
                      Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Color(0xFFB738B7),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(Icons.filter_list, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        controller: _scrollController,
        key: _scaffoldKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //the search row

                //the home sticky navbar row
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add a custom Drawer icon
                    GestureDetector(
                      onTap: _openDrawer,
                      child:
                          Icon(Icons.menu, size: 35, color: Color(0xFFB738B7)),
                    ),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Color(0xFFB738B7),
                          size: 35,
                        ))
                    // Add other items to your navbar here
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //PROMOTION CAROUSEL
                Container(
                  height: 150.0, // Set a fixed height for the carousel
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      for (int i = 0; i < carouselData.length; i++)
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 100),
                          opacity: _currentIndex == i ? 1.0 : 0.0,
                          child: Container(
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background Color
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: i == 0
                                        ? LinearGradient(
                                            begin: Alignment(-0.58, 0.81),
                                            end: Alignment(0.58, -0.81),
                                            colors: [
                                              Color(0x7CE5BFE5),
                                              Color(0xFFB799FF),
                                            ],
                                          )
                                        : i == 2
                                            ? LinearGradient(
                                                begin: Alignment(-0.61, 0.79),
                                                end: Alignment(0.61, -0.79),
                                                colors: [
                                                  Color(0xFFFFE5B4),
                                                  Color(0x9EC8A2C8),
                                                ],
                                              )
                                            : i == 1
                                                ? null // Remove the gradient for the second container
                                                : null,
                                    color: i == 1
                                        ? Color(
                                            0xFFFDC0C5) // Solid color for the second container
                                        : null,
                                  ),
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                // Text and Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        // Text
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //logo image
                                                Image.asset(
                                                    'images/Everyday_Makeup (4).png'),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  carouselData[i]['text'],
                                                  style: textStyles[i],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Image
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            carouselData[i]['image'],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 150.0, // Set the same height as the container
                          autoPlay: false,
                          enlargeCenterPage: false,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: carouselData
                            .map((item) => Container(
                                  color: Colors.transparent,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                // PageView Indicator
                Center(
                  child: DotsIndicator(
                    dotsCount: carouselData.length,
                    position: _currentIndex.toInt(),
                    decorator: DotsDecorator(
                      size: Size.square(6.0),
                      activeSize: Size(14.0, 6.0),
                      color:
                          Color.fromARGB(255, 244, 202, 251), // Inactive color
                      activeColor: Color(0xFFB738B7),
                      spacing: EdgeInsets.all(2.0), // Active color
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            4.0), // Set a border radius for active dots
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // categories listview

                CarouselSlider.builder(
                    itemCount: categoryData.length,
                    itemBuilder: (BuildContext context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 15),
                                  spreadRadius: -10)
                            ],
                            color: categoryData[index]['color'],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(categoryData[index]['image']),
                                    //SizedBox(width: 7,),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          categoryData[index]['text'],
                                          style: textStyling[index],
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        //aspectRatio: 30/5,
                        viewportFraction: 0.4,
                        height: 70,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false)),
                SizedBox(
                  height: 20,
                ),

                //popular category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: headerStyling.first,
                    ),
                    Text('see all')
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //streambuilder to create a carousel
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('popular')
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
                        return CarouselSlider.builder(
                            itemCount: documents.length,
                            itemBuilder:
                                (BuildContext context, index, int realIndex) {
                              //the carousel items will be built from the document[index]
                              String itemName =
                                  documents[index]['product name'];
                              String itemPrice = documents[index]['price'];
                              String itemDiscount =
                                  documents[index]['discount'];
                              String itemImage =
                                  documents[index]['product image']; 

                              return GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => Catalogue(
                                              itemImage: itemImage,
                                              productName: itemName,
                                              price: itemPrice,
                                            ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 250,
                                    padding: EdgeInsets.all(16),
                                    // decoration: carouselContainers[0],
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x0C000000),
                                              blurRadius: 48,
                                              offset: Offset(0, 24),
                                              spreadRadius: -5)
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                decoration:
                                                    discountContainer[index],
                                                child: Text(itemDiscount)),
                                            IconButton(
                                                onPressed: () {
                                                  SavedItem newItem = SavedItem(
                                                      productName: itemName,
                                                      price: itemPrice,
                                                      image: itemImage);
                                                  Provider.of<SavedModel>(
                                                          context,
                                                          listen: false)
                                                      .addToSaved(newItem);
                                                  //setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.grey,
                                                ))
                                          ],
                                        ),
                                        //
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: itemImage,
                                              height: 100,
                                              width: 80,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ],
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Color(0x66E5A3E5),
                                                          blurRadius: 14,
                                                          offset: Offset(0, 7),
                                                          spreadRadius: 0)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (!Provider.of<
                                                                  CartModel>(
                                                              context,
                                                              listen: false)
                                                          .cartItems
                                                          .any((existingItem) =>
                                                              existingItem
                                                                  .productName ==
                                                              itemName)) {
                                                        CartItem newItem =
                                                            CartItem(
                                                                image:
                                                                    itemImage,
                                                                productName:
                                                                    itemName,
                                                                price:
                                                                    itemPrice);
                                                        Provider.of<CartModel>(
                                                                context,
                                                                listen: false)
                                                            .addToCart(newItem);
                                                        //cartItems[itemName] = 1;
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            'item successfully added to cart',
                                                          ),
                                                          backgroundColor:
                                                              Color(0xFF00A991),
                                                          duration: Duration(
                                                              seconds: 5),
                                                          action: SnackBarAction(
                                                              label: 'ok',
                                                              textColor:
                                                                  Colors.white,
                                                              onPressed: () {}),
                                                        ));
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              'item already exist in cart!'),
                                                          duration: Duration(
                                                              seconds: 5),
                                                          backgroundColor:
                                                              Color(0xFF00A991),
                                                        ));
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.add_shopping_cart,
                                                      color: Color(0xFFB738B7),
                                                    )))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction: 0.6,
                              height: 290,
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: false,
                            ));
                      } else {
                        return Text('no data available');
                      }
                    }),
                SizedBox(
                  height: 40,
                ),
                //the best picks section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment(-0.58, 0.81),
                    end: Alignment(0.58, -0.81),
                    colors: [
                      Color.fromARGB(123, 249, 233, 249),
                      Color.fromARGB(255, 245, 243, 249)
                    ],
                  )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best picks for you',
                            style: headerStyling.first,
                          ),
                          Text('see all')
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //using stream  builder to fetch the details from the database
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('best picks')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return CarouselSlider.builder(
                                  itemCount: documents.length,
                                  itemBuilder: (BuildContext context, index,
                                      int realIndex) {
                                    String itemName =
                                        documents[index]['product name'];
                                    String itemPrice =
                                        documents[index]['price'];
                                    String itemImage =
                                        documents[index]['product image'];

                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Catalogue(itemImage: itemImage, productName: itemName, price: itemPrice))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: carouselContainers[0],
                                          child: Column(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: itemImage,
                                                height: 100,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    itemPrice,
                                                    style: textStyles[1],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 230,
                                    viewportFraction: 0.4,
                                    autoPlay: false,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: false,
                                  ));
                            } else {
                              return Text(
                                  'There was an error loading this page');
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending',
                      style: headerStyling.first,
                    ),
                    Text('view all')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //the trending section using gridview.builder and stream builder to generate data from cloudfirestore
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('trending')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 2,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount: documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                String itemName =
                                    documents[index]['product name'];
                                String price = documents[index]['price'];
                                String itemImage =
                                    documents[index]['product image'];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Catalogue(itemImage: itemImage, productName: itemName, price: price))),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    //height: 700,
                                    decoration: carouselContainers[0],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: itemImage,
                                          height: 100,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
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
                                          price,
                                          style: textStyles[1],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Text('no data available');
                        }
                      }),
                ),
                //recommended for you section using gridview.builder and stream builder to generate data from cloud firestore
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Recommended for you',
                  style: headerStyling.first,
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('recommended')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
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
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Catalogue(itemImage: itemImage, productName: itemName, price: itemPrice))),
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
                                              },
                                              icon: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.grey,
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
                                                  if (!Provider.of<CartModel>(
                                                          context,
                                                          listen: false)
                                                      .cartItems
                                                      .any((existingItem) =>
                                                          existingItem
                                                              .productName ==
                                                          itemName)) {
                                                    CartItem newItem = CartItem(
                                                        image: itemImage,
                                                        productName: itemName,
                                                        price: itemPrice);
                                                    Provider.of<CartModel>(
                                                            context,
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
                                                icon: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Color(0xFFB738B7))),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Text('no data available');
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () {
                              _scrollController.animateTo(0.0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            icon: Icon(
                              Icons.arrow_upward,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
