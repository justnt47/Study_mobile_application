import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './homePage.dart';
import './loginPage.dart';
import './registerPage.dart';
import './authPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            'Welcome!',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 180,
          ),
          SizedBox(
            width: 385,
            child: TextFormField(
              maxLines: 1, //limit line to show data
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                icon: Icon(
                  Icons.email,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 385,
            child: TextFormField(
              maxLines: 1, //limit line to show data
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                icon: Icon(
                  Icons.lock,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            child: Text('Log in'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => authPage()));
            },
          ),
          ElevatedButton(
            child: Text('regisPage'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistPage()));
            },
          ),
          ElevatedButton(
            child: Text('Homepage'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homePage()));
            },
          ),
        ],
      )),
    );
  }
}
