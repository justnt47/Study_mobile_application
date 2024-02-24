import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/home.dart';
import 'package:test_any_code/test.dart';

import './homePage.dart';
import './loginPage.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Learning Future', style: TextStyle(color: Colors.black)),
        ),
        actions: [Icon(Icons.help, color: Colors.blue)],
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Login
          if (snapshot.hasData) {
            return homePage() /* MyTest() */;
          } else {
            // Not logged in
            return loginPage();
          }
        },
      ),
    );
  }
}
