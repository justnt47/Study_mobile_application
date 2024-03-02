import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_any_code/loginPage.dart';

class changePasswordPage extends StatefulWidget {
  const changePasswordPage({super.key});

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();

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

  changePassword({email, oldPassword, newPassword}) async {
    print("$email $oldPassword $newPasswordController/////////////////////");
    var credential =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await user!.reauthenticateWithCredential(credential).then((value) {
      user!.updatePassword(newPassword);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 239, 240, 1),
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 500,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: new InputDecoration(
                              labelText: "Password",
                              labelStyle: new TextStyle(
                                  color: const Color(0xFF424242))),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your Password';
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: new InputDecoration(
                              labelText: "New Password",
                              labelStyle: new TextStyle(
                                  color: const Color(0xFF424242))),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your Password';
                          },
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty &&
                                confirmPasswordController.text !=
                                    passwordController.text) {
                              return "Your password don't match";
                            }
                          },
                          decoration: new InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: new TextStyle(
                                  color: const Color(0xFF424242))),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("cancle"),
                              style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Color.fromARGB(255, 156, 150, 150),
                                  backgroundColor:
                                      Color.fromARGB(255, 243, 243, 243),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  fixedSize: Size(180, 20)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await changePassword(
                                        email: user!.email,
                                        oldPassword: passwordController.text,
                                        newPassword:
                                            newPasswordController.text);

                                    print("Change password succes");
                                    Navigator.pop(context);
                                  }
                                  passwordController.clear();
                                  newPasswordController.clear();
                                  confirmPasswordController.clear();
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    backgroundColor: Colors.blue,
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    fixedSize: Size(180, 20)),
                                child: Text("save")),
                          ],
                        ),
                      ],
                    ),
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
