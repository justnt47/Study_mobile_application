import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:test_any_code/firebase.dart';
import 'package:google_fonts/google_fonts.dart';

final auth = FirebaseAuth.instance;
CollectionReference Users = FirebaseFirestore.instance.collection("Users");
var collection = FirebaseFirestore.instance
    .collection("Users")
    .where("uid", isEqualTo: auth.currentUser?.uid);

class lesson extends StatefulWidget {
  lesson({super.key});

  @override
  State<lesson> createState() => _lessonState();
}

class _lessonState extends State<lesson> {
  CollectionReference Users = FirebaseFirestore.instance.collection("Users");
  final auth = FirebaseAuth.instance;
  String? docID;
  String? subDocID;
  List<bool> isbookmark = [false, false, false];

  

  void deleteLesson(String title) async {
    try {
      await Users.doc(docID) // ใช้ docID ที่ได้มาก่อนหน้านี้
          .collection("MyLessons")
          .where("title", isEqualTo: title)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (e) {
      print("Error deleting lesson: $e");
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getDocID();
  }

  getDocID() async {
    try {
      var collection = FirebaseFirestore.instance
          .collection("Users")
          .where("uid", isEqualTo: auth.currentUser?.uid);

      var doc = await collection.get();

      setState(() {
        docID = doc.docs.first.id;
      });

      print(docID);
    } catch (e) {
      print(e.toString());
    }
  }

  getSubDocID(title) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection("Users")
          .doc(docID)
          .collection("MyLessons")
          .where("title", isEqualTo: title);

      var doc = await collection.get();
      print(subDocID);

      subDocID = doc.docs.first.id;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "MY LEARNING",
                    style: GoogleFonts.exo2(
                        fontSize: 30, color: Colors.blueAccent),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: docID != null
                      ? StreamBuilder(
                          stream: Users.doc(docID)
                              .collection("MyLessons")
                              .where("isMylesson", isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
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
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 173, 173, 173),
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 3.0,
                                            spreadRadius: 0.2,
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            const Color.fromARGB(
                                                255, 71, 166, 244),
                                            const Color.fromARGB(
                                                255, 62, 39, 176),
                                          ],
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          topicIndex['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Confirm Delete'),
                                                        content: Text(
                                                            'Are you sure you want to delete?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              deleteLesson(
                                                                  topicIndex[
                                                                      'title']);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            } else {
                              return Center(child: Text('No data'));
                            }
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
