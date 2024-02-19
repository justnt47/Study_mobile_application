import 'package:flutter/material.dart';
import 'package:study_application/loginPage.dart';
import 'package:study_application/main.dart';

class acc extends StatefulWidget {
  acc({super.key});

  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
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
                "This is Account Page",
                style: TextStyle(fontSize: 50),
              ),
              IconButton(
                  onPressed: () {
                    main();
                  },
                  icon: Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
