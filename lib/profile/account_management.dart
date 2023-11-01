// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AccountManagement extends StatelessWidget {
  const AccountManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
        backgroundColor: Color(0xFFB738B7),
        title: Text('Profile'),
      ),
    );
  }
}
