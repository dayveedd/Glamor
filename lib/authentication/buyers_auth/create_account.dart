// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: 35,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create an account',
                style: TextStyle(
                  color: Color(0xFF151A20),
                  fontSize: 20,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(height: 10,),
              Opacity(
                opacity: 0.70,
                child: Text(
                  'Let’s help you set up your account.',
                  style: TextStyle(
                    color: Color(0xFF151A20),
                    fontSize: 13,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                    height: 1.7,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
