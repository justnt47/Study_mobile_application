import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_any_code/firebase.dart';

final auth = FirebaseAuth.instance;
CollectionReference Users = FirebaseFirestore.instance.collection("Users");
var collection = FirebaseFirestore.instance
    .collection("Users")
    .where("uid", isEqualTo: auth.currentUser?.uid);

// var doc = await collection.get();
// var docID = doc.docs.first.id;

class bookmark extends StatefulWidget {
  bookmark({super.key});

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
  List<bool> isbookmark = [false, false, false];

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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder(
                    stream: Users.doc().collection('MyBookMark').snapshots(),
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
