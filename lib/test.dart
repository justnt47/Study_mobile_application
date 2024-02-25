import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  CollectionReference topicCollection =
      FirebaseFirestore.instance.collection("Users");
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  ShowUserEmail() {
    if (FirebaseAuth.instance.currentUser != null) {
      return Column(
        children: [
          Text("${user?.email}"),
          // Text("${user?.uid}"),
        ],
      );
    } else {
      return Text("ThisIsDemoEmail@test.com");
    }
  }

  int screenIndex = 0;

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Create Better',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 25.0)),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0)),
                      const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0)),
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Example.mail.com",
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0)),
                      const Text(
                        "Password",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "",
                          hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0)),
                      MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        color: Colors.black,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0)),
                      const Center(child: Text("Forgot Password")),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0)),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        onTap: () {
                          // signUserOut();
                          Navigator.pop(context);
                        },
                        // onTap: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Center(child: Text("Create new account")),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
