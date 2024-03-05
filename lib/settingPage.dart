import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_any_code/addLesson.dart';
import 'package:test_any_code/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_any_code/test.dart';

import 'package:test_any_code/accPage.dart';

class sett extends StatefulWidget {
  const sett({super.key});

  @override
  State<sett> createState() => _settState();
}

class _settState extends State<sett> {
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  // CollectionReference userName = FirebaseFirestore.instance.collection("Users").where("uid", isEqualTo: user.uid);
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  ShowUserEmail() {
    if (FirebaseAuth.instance.currentUser != null) {
      return Text("${user!.email}");
    } else {
      return Text("ThisIsDemoEmail@test.com");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 0, 80, 146),
              Color.fromARGB(255, 240, 25, 175),
            ],
          )),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: 130,
                height: 150,
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 5,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  color: Color.fromARGB(195, 0, 74, 135),
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage("images/avatar2.jpg")),
                ),
              ),
              StreamBuilder(
                  stream: userCollection
                      .where("uid", isEqualTo: user?.uid.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    // print(
                    //     "${FirebaseFirestore.instance.collection("Users")} print is here ///////////////");
                    // print(user?.uid.toString());
                    // print(
                    //     "${FirebaseFirestore.instance.collection("displayName").where("uid", isEqualTo: user?.uid).snapshots()} print is here ///////////////");
                    // print(
                    //     "${FirebaseFirestore.instance.collection("uid").where("uid", isEqualTo: "QEMYbhzDhqSIcviYCpVJ2Pq6B3H2").snapshots()} print is here ///////////////");
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          var topicIndex = snapshot.data!.docs[index];
                          return GestureDetector(
                              //--- เมื่อคลิกที่ข้อมูล title ที่ดึงมาให้แสดง popup เพื่อแสดงรายละเอียด ---
                              onTap: () {
                                //---- เรียกฟังก์ชันชื่อ showDetail ด้านล่าง ----
                                //showDetail(topicIndex);
                              },
                              child: Column(
                                children: [
                                  Text(
                                    topicIndex['displayName'],
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),

                                  // ShowUserEmail(),
                                ],
                              ));
                        }),
                      );

                      //-------- ถ้าไม่มีข้อมูลในฐานข้อมูลให้แสดงคำว่า 'No data' --------
                    } else {
                      return Center(child: Text('No data'));
                    }
                  }),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  height: 800,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 173, 173, 173),
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 35,
                        ),
                        title: Text(
                          "Account Setting",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => acc()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          size: 35,
                          color: const Color.fromARGB(255, 255, 52, 52),
                        ),
                        title: Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: const Color.fromARGB(255, 255, 52, 52),
                            letterSpacing: 0,
                          ),
                        ),
                        onTap: () {
                          signUserOut();
                          // Navigator.pop(context);
                        },
                        // onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          size: 35,
                        ),
                        title: Text(
                          "TestPage",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTest()));
                          // Navigator.pop(context);
                        },

                        // onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.add,
                          size: 35,
                        ),
                        title: Text(
                          "Add lesson",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addForm()));
                          // Navigator.pop(context);
                        },

                        // onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
