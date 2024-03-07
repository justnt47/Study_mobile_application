import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_any_code/firebase.dart';
import 'package:google_fonts/google_fonts.dart';

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
  CollectionReference Users = FirebaseFirestore.instance.collection("Users");
  final auth = FirebaseAuth.instance;
  String? docID;
  String? subDocID;
  List<bool> isbookmark = []; // ลบการกำหนดขนาดเริ่มต้น

  void deleteBookMark(String title) async {
    try {
      await Users.doc(docID) // ใช้ docID ที่ได้มาก่อนหน้านี้
          .collection("MyBookMark")
          .where("title", isEqualTo: title)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (e) {
      print("Error deleting : $e");
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

      print("docID: ${docID}");
    } catch (e) {
      print(e.toString());
    }
  }

  getSubDocID(title) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection("Users")
          .doc(docID)
          .collection("MyBookMark")
          .where("title", isEqualTo: title);

      var doc = await collection.get();

      subDocID = doc.docs.first.id;
      print("lenght subDocID: ${doc.docs.length}");
      print("subDocID: $subDocID");
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
                  "MY BOOKMARK",
                  style:
                      GoogleFonts.exo2(fontSize: 30, color: Colors.blueAccent),
                )),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: docID != null
                      ? StreamBuilder(
                          stream: Users.doc(docID)
                              .collection("MyBookMark")
                              .where("isBooked", isEqualTo: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print("condition is true");
                              // กำหนดขนาดของ isbookmark ให้เท่ากับจำนวนรายการใหม่ที่มีใน snapshot
                              isbookmark = List<bool>.filled(
                                  snapshot.data!.docs.length, false);
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
                                            offset: const Offset(
                                              0.0,
                                              0.0,
                                            ),
                                            blurRadius: 3.0,
                                            spreadRadius: 0.2,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
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
                                        leading: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.bookmark_add,
                                              color: isbookmark.isNotEmpty &&
                                                      isbookmark[index]
                                                  ? Colors.grey
                                                  : Color.fromARGB(
                                                      255, 255, 204, 50),
                                            ),
                                            onPressed: () {
                                              deleteBookMark(
                                                  topicIndex["title"]);
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          topicIndex['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        trailing: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              saveLessons(topicIndex["title"],
                                                  topicIndex["description"]);
                                              print(
                                                'สมัครคอร์สเรียน: ${topicIndex['title']}',
                                              );
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Start Learning',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            } else {
                              print("condition is false");
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
