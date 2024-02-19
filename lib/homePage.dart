import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './bookMarkPage.dart';
import './loginPage.dart';
import './main.dart';
import './home.dart';
import './accPage.dart';
import './lessonPage.dart';

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
      body: mobileScreens[screenIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 134, 91, 73),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
                  //------ ถ้า Index = 0 ให้ไอคอนสีเหลือง ถ้าไม่ใช้ไอคอนสีขาว ------
                  color: screenIndex == 0
                      ? Color.fromRGBO(238, 224, 201, 1)
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
                  color: screenIndex == 1
                      ? Color.fromRGBO(238, 224, 201, 1)
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
                  Icons.book,
                  color: screenIndex == 2
                      ? Color.fromRGBO(238, 224, 201, 1)
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
                  color: screenIndex == 3
                      ? Color.fromRGBO(238, 224, 201, 1)
                      : Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
