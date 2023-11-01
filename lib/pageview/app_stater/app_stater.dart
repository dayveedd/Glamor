// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/authentication/buyers_auth/create_account.dart';
import 'package:flutter/material.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/pageview (3).png'), fit: BoxFit.cover)),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                height: 330,
                width: 370,
                padding: EdgeInsetsDirectional.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    SizedBox(
                      width: 271,
                      child: Text(
                        'Choose your experience!',
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
                      height: 10,
                    ),
                    SizedBox(
                      width: 271,
                      child: Opacity(
                        opacity: 0.70,
                        child: Text(
                          'For better experience, select how you will be using this app. You can always change it any time.',
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
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFB738B7),
                              foregroundColor: Colors.white,
                              minimumSize: Size(250, 60)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                          },
                          child: Text('AS A BUYER')),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFB738B7), width: 1.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFFB738B7),
                                minimumSize: Size(250, 60)),
                            onPressed: () {},
                            child: Text('AS A SUPPLIER')),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
