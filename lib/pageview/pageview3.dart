// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/pageview/app_stater/app_stater.dart';
import 'package:flutter/material.dart';

class PageView3 extends StatefulWidget {
  const PageView3({super.key});

  @override
  State<PageView3> createState() => _PageView3State();
}

class _PageView3State extends State<PageView3> {
  int currentPage = 2;
  int pageCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 550,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/pageview (4).png'),
                    fit: BoxFit.cover)),
          ),
        ),
        DotsIndicator(
          dotsCount: pageCount,
          position: currentPage.toInt(),
          decorator: DotsDecorator(
              size: Size(20, 8.0),
              color: Colors.grey,
              activeColor: Color(0xFFB738B7),
              spacing: EdgeInsets.all(2.0)),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 285,
          child: Text(
            'Sell your products to a wide market!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF151A20),
              fontSize: 20,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        SizedBox(
          height: 17,
        ),
        SizedBox(
          width: 283,
          child: Opacity(
            opacity: 0.70,
            child: Text(
              'Become a supplier, own a shop on the app and sell your products online.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF151A20),
                fontSize: 13,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                height: 1.7,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 130,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB738B7),
                        foregroundColor: Colors.white,
                        minimumSize: Size(300, 50)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AppStarter()));
                    },
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(fontFamily: 'Quicksand'),
                    )),
              )
            ],
          ),
        )
      ],
    ));
  }
}
