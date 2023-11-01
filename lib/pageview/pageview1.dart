// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PageView1 extends StatefulWidget {
  const PageView1({super.key});

  @override
  State<PageView1> createState() => _PageView1State();
}

class _PageView1State extends State<PageView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 550,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/pageview (2).png'),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 285,
            child: Text(
              'Cosmetics for everyone!',
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
          SizedBox(height: 17,),
          SizedBox(
            width: 283,
            child: Opacity(
              opacity: 0.70,
              child: Text(
                'Buy a wide range of cosmetics products that suits your needs from reliable suppliers.',
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
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: (){}, child: Text('SKIP', style: TextStyle(color: Color(0xFFB738B7),fontSize: 17, fontFamily: 'Quicksand'),)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB738B7), foregroundColor: Colors.white, minimumSize: Size(150, 50)),
                        onPressed: (){}, child: Text('NEXT')),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
