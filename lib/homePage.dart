import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:test_any_code/bookMarkPage.dart';
import 'package:test_any_code/home.dart';
import 'package:test_any_code/lessonPage.dart';
import 'package:test_any_code/settingPage.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _formKey = GlobalKey<FormState>();
  int screenIndex = 0;

  //------ หน้าจอแต่ละหน้า ------
  final mobileScreens = [
    home(),
    lesson(),
    bookmark(),
    sett(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 118, 200, 241),
        onPressed: () {
          _showFeedbackDialog(context);
        },
        child: Icon(
          Icons.feedback,
          color: Colors.yellow,
        ),
      ),
      body: mobileScreens[screenIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  //------ กำหนดค่า Index เมื่อมีการคลิก ------
                  screenIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                size: 35,
                color: screenIndex == 0
                    ? Color.fromRGBO(214, 214, 214, 1)
                    : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenIndex = 1;
                });
              },
              icon: Icon(
                Icons.menu_book_sharp,
                size: 35,
                color: screenIndex == 1
                    ? Color.fromRGBO(214, 214, 214, 1)
                    : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenIndex = 2;
                });
              },
              icon: Icon(
                Icons.bookmark,
                size: 35,
                color: screenIndex == 2
                    ? Color.fromRGBO(214, 214, 214, 1)
                    : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenIndex = 3;
                });
              },
              icon: Icon(
                Icons.settings,
                size: 35,
                color: screenIndex == 3
                    ? Color.fromRGBO(214, 214, 214, 1)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    TextEditingController topic_feedbackController = TextEditingController();
    TextEditingController des_feedbackController = TextEditingController();
    CollectionReference feedBackCollection =
        FirebaseFirestore.instance.collection("feedBacks");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Provide Feedback'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please provide your feedback here:'),
                TextFormField(
                  controller: topic_feedbackController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Topic',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter an Topic';
                  },
                ),
                TextFormField(
                  controller: des_feedbackController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter an Description';
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                feedBackCollection.add({
                  "topic": topic_feedbackController.text,
                  "description": des_feedbackController.text
                });
                topic_feedbackController.clear();
                des_feedbackController.clear();
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
