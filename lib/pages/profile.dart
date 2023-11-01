// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/profile/account_management.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile/notification.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final List<TextStyle> headerStyles = [
    TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
        color: Color(0xFF151A20))
  ];

  String? _imagePath;

  Future<void> _handleImageSelection() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  final List<TextStyle> miniText = [
    TextStyle(color: Colors.grey, fontSize: 10)
  ];

  final List<BoxDecoration> containerDecoration = [
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))
  ];

  final List<TextStyle> headerText = [
    TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        backgroundColor: Color(0xFFB738B7),
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: _imagePath != null
                                    ? AssetImage(
                                        _imagePath!) // Display the selected image
                                    : AssetImage(
                                        'images/profile_image.jpeg'), // Replace with your image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                _handleImageSelection();
                                // Handle image selection or camera capture here
                                // You can use a package like image_picker for this purpose.
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFB738B7),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //placeholders for name, phonenumber and email
                          Row(
                            children: [
                              Text(
                                'Name',
                                style: headerStyles.first,
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 10),
                              Text('phone number'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 10),
                              Text('email'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('MY ACCOUNT', style: headerText.first),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //padding: EdgeInsets.all(16),
                  decoration: containerDecoration[0],
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Orders',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'track, review and cancel orders',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/orders2.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notifications()));
                        },
                        title: Text(
                          'Notifications',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'inbox, promotions and alerts',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/notifications.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Vouchers',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'collect, redeem and apply vouchers',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/voucher2.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Follow Supplier',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'find and follow our verified suppliers',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/suppliers.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'ACCOUNT SETTINGS',
                  style: headerText.first,
                ),
                SizedBox(
                  height: 20,
                ),
                //Account settings listtile
                Container(
                    decoration: containerDecoration[0],
                    child: Column(children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountManagement(),
                          ));
                        },
                        title: Text(
                          'Account Management',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'Profile, Shipping, Card & Security settings.',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/account.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Help',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'FAQ, Live Chat & Contact customer support.',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/help2.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        title: Text(
                          'Switch Account',
                          style: headerStyles[0],
                        ),
                        subtitle: Text(
                          'Change app experience',
                          style: miniText.first,
                        ),
                        leading: Image.asset(
                          'images/switch.png',
                          height: 90,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red[300],
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
