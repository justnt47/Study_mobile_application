import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/addLesson.dart';
import 'package:test_any_code/test.dart';

import './firebase.dart';
import './forgotPasswordPage.dart';
import './registerPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 20, right: 30, left: 30),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black),
                      color: Color.fromARGB(195, 0, 74, 135),
                      shape: BoxShape.circle),
                  child: Image.asset(
                    'images/swan.png',
                  ),
                ),
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 60),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        prefix: Icon(Icons.mail),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter your email';
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: _obscurePassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 60),
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        prefix: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: togglePasswordVisibility,
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter your Password';
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          forgotPasswordPage()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUserIn();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text('add lesson'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => addForm()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text('test page'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyTest()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text('Or continue with'),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                      child: Icon(Icons.mail_outline, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                    child: Icon(Icons.facebook, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(229, 217, 182, 1),
                    child: Icon(Icons.apple, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistPage()));
                      },
                      child: Text('Register now'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
