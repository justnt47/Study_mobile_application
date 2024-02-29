import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/firebase.dart';

import 'package:test_any_code/controller.dart';
import './home.dart';
import './lessonPage.dart';
import './bookMarkPage.dart';
import './accPage.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int screenIndex = 0;

  //------ หน้าจอแต่ละหน้า ------
  final mobileScreens = [
    home(),
    lesson(),
    bookmark(),
    acc(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 118, 200, 241),
        child: IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            setState(() {
              printDoc();
            });
          },
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
                  //------ ถ้า Index = 0 ให้ไอคอนสีเหลือง ถ้าไม่ใช้ไอคอนสีขาว ------
                  color: screenIndex == 0
                      ? Color.fromRGBO(214, 214, 214, 1)
                      : Colors.white,
                  // color: Colors.white,
                )),
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
                  // color: Colors.white,
                )),
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
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    screenIndex = 3;
                  });
                },
                icon: Icon(
                  Icons.person,
                  size: 35,
                  color: screenIndex == 3
                      ? Color.fromRGBO(214, 214, 214, 1)
                      : Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
