// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<TextStyle> headerStyles = [
    TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Quicksand',
        color: Color(0xFF151A20))
  ];

  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFB738B7),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 isNotificationOn ? Text('turn on notifications', style: headerStyles[0],) : Text('turn off notifications', style: headerStyles[0],),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isNotificationOn = !isNotificationOn;
                      });
                    },
                    icon: isNotificationOn
                        ? Icon(Icons.toggle_off_outlined)
                        : Icon(Icons.toggle_on),
                    color: isNotificationOn ? Colors.grey : Color(0xFFB738B7),
                    iconSize: isNotificationOn ? 45 : 45,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
