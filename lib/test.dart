import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:test_any_code/firebase.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  CollectionReference Users = FirebaseFirestore.instance.collection("Users");
  final auth = FirebaseAuth.instance;
  String? docID;
  List<bool> isbookmark = [false, false, false];
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  printDoc() async {
    var collection = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: auth.currentUser?.uid);

    var doc = await collection.get();
    docID = doc.docs.first.id;
    var result = await FirebaseFirestore.instance
        .collection("Users")
        .doc(docID)
        .collection("MyBookMark")
        .where("isBooked", isEqualTo: true)
        .get();

    print("result: ${result.docs.length}");
  }

  @override
  void initState() {
    super.initState();
    // Call the async method in initState
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Call the printDoc function when the widget is initialized
    await printDoc();

    // After printDoc is completed, you can perform additional tasks if needed
    // Example: setState, update UI, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Container(
          padding: EdgeInsets.all(60),
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
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
          child: Center(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 35,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 25.0,
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
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 35,
                  ),
                  title: Text(
                    "Trigger func",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                  onTap: () {
                    printDoc();
                    print(docID);
                  },
                  // onTap: () => Navigator.pop(context),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder(
                    stream:
                        Users.doc(docID).collection("MyBookMark").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("condition is true");
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            var topicIndex = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                //---- เรียกฟังก์ชันชื่อ showDetail ด้านล่าง ----
                                //showDetail(topicIndex);
                              },
                              child: Text(topicIndex["title"]),
                            );
                          }),
                        );
                      } else {
                        print("condition is false");
                        return Center(child: Text('No data'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
