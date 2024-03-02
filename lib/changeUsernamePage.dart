import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class changeUsernamePage extends StatefulWidget {
  const changeUsernamePage({super.key});

  @override
  State<changeUsernamePage> createState() => _changeUsernamePageState();
}

class _changeUsernamePageState extends State<changeUsernamePage> {
  var _formKey = GlobalKey<FormState>();
  final newUsername = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  String? docID;
  @override
  void initState() {
    super.initState();
    // Call the async method in initState
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Call the printDoc function when the widget is initialized
    await getDocID();

    // After printDoc is completed, you can perform additional tasks if needed
    // Example: setState, update UI, etc.
  }

  getDocID() async {
    var collection = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: auth.currentUser?.uid);

    var doc = await collection.get();
    setState(() {
      docID = doc.docs.first.id;
    });
  }

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
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: newUsername,
                          decoration: new InputDecoration(
                              labelText: "Username  ",
                              labelStyle: new TextStyle(
                                  color: const Color(0xFF424242))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter new username";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancle"),
                            style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    Color.fromARGB(255, 156, 150, 150),
                                backgroundColor:
                                    Color.fromARGB(255, 243, 243, 243),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                fixedSize: Size(180, 20)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  userCollection.doc(docID).update(
                                      {"displayName": newUsername.text});

                                  print("${newUsername.text} $docID");
                                  print("Update username success");
                                  Navigator.pop(context);
                                }
                                newUsername.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
            ],
          ),
        ),
      ),
    );
  }
}
