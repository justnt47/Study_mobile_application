import 'package:flutter/material.dart';
import 'package:test_any_code/changePasswordPage.dart';
import 'package:test_any_code/changeUsernamePage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class acc extends StatefulWidget {
  const acc({super.key});

  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
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
      backgroundColor: Color.fromRGBO(236, 239, 240, 1),
      appBar: AppBar(
        title: Text("Account Setting"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                    height: 800,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
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
                    child: ListView(
                      children: ListTile.divideTiles(
                          //          <-- ListTile.divideTiles
                          context: context,
                          tiles: [
                            ListTile(
                              leading: Icon(
                                Icons.settings,
                                size: 35,
                              ),
                              title: Text('Update Username'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            changeUsernamePage()));
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.key,
                                size: 35,
                              ),
                              title: Text('Change Password'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            changePasswordPage()));
                              },
                            ),
                          ]).toList(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
