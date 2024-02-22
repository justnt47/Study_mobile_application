import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';

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
                height: 290,
              ),
              Text(
                "This is My lesson Page",
                style: TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
