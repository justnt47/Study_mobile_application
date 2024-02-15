import 'package:study_application/homePage.dart';
import 'package:study_application/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Firebase Auth', style: TextStyle(color: Colors.white)),
        ),
        actions: [Icon(Icons.help, color: Colors.white)],
        backgroundColor: Color.fromRGBO(40, 84, 48, 1),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Login
          if (snapshot.hasData) {
            return homePage();
          } else {
            // Not logged in
            return loginPage();
          }
        },
      ),
    );
  }
}
