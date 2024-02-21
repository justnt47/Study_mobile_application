import 'package:flutter/material.dart';
import 'package:study_application/loginPage.dart';
import 'package:study_application/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class acc extends StatefulWidget {
  acc({super.key});

  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
  final user = FirebaseAuth.instance.currentUser;
  // var userEmail = "ThisIsdemoemail@test.com";
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
                Column(
                  children: [
                    Text("FirstName LastName",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    ShowUserEmail(),
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Setting",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  letterSpacing: 0,
                ),
              ),
              onTap: () => true,
            ),
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
                signUserOut();
                Navigator.pop(context);
              },
              // onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
