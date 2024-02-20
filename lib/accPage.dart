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
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Container(
                    child: Image.asset(
                  "images/Image_Not_found.jpg",
                  height: 160,
                )),
                Text("FirstName LastName",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
            Text(
              "This is Account Page",
              style: TextStyle(fontSize: 50),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }
}
