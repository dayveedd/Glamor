// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/pages/cart.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pageview/pageview1.dart';
import 'package:ecommerce/pageview/pageview2.dart';
import 'package:ecommerce/pageview/pageview3.dart';
import 'package:ecommerce/utils/cart_model.dart';
import 'package:ecommerce/utils/saved_utils/saved_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()), // Create an instance of CartModel
        ChangeNotifierProvider(create: (context) => SavedModel()), // Create an instance of SavedModel
      ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
      // home:PageView(
      //   children: [
      //     PageView1(),
      //     PageView2(),
      //     PageView3()
      //   ],
      // ),
    );
  }
}
