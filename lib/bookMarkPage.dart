import 'package:flutter/material.dart';
import 'package:study_application/loginPage.dart';

class bookmark extends StatefulWidget {
  bookmark({super.key});

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
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
                "This is bookmark Page",
                style: TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
