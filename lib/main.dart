import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/accPage.dart';

import './homePage.dart';
import './loginPage.dart';
import './registerPage.dart';
import './authPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
    ),
    home: authPage(),
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
          /* SizedBox(height: 60),
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
          ), */
          /* ElevatedButton(
            child: Text('Homepage'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => homePage()));
            },
          ), */
        ],
      )),
    );
  }
}
