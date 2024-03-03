import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class lesson extends StatefulWidget {
  lesson({super.key});

  @override
  State<lesson> createState() => _lessonState();
}

class _lessonState extends State<lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "การเรียนของฉัน",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 30),
                  Icon(
                    Icons.school,
                    size: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'กำลังเรียนอยู่',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),            
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    height: 800,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 173, 173, 173),
                          offset: const Offset(0, 0),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0, 0),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),         
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
