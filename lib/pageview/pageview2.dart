// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PageView2 extends StatefulWidget {
  const PageView2({super.key});

  @override
  State<PageView2> createState() => _PageView2State();
}

class _PageView2State extends State<PageView2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 550,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/pageview (1).png'),
                    fit: BoxFit.cover)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 285,
          child: Text(
            'The one stop shop for all cosmetic needs!',
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
              'Look no further than our one stop shop for all your cosmetic needs.',
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
          width: 300,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            color: Color(0xFFB738B7),
                            fontSize: 17,
                            fontFamily: 'Quicksand'),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB738B7),
                            foregroundColor: Colors.white,
                            minimumSize: Size(150, 50)),
                        onPressed: () {},
                        child: Text('NEXT')),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
