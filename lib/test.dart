import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  CollectionReference topicCollection =
      FirebaseFirestore.instance.collection("Users");
  final user = FirebaseAuth.instance.currentUser;
  List<bool> isbookmark = [false, false, false];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  ShowUserEmail() {
    if (FirebaseAuth.instance.currentUser != null) {
      return Column(
        children: [
          Text("${user?.email}"),
          // Text("${user?.uid}"),
        ],
      );
    } else {
      return Text("ThisIsDemoEmail@test.com");
    }
  }

  int screenIndex = 0;
  CollectionReference lessonCollection =
      FirebaseFirestore.instance.collection("lessons");
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 50,
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
              // signUserOut();
              Navigator.pop(context);
            },
            // onTap: () => Navigator.pop(context),
          ),
          StreamBuilder(
            stream: lessonCollection.snapshots(),
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
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color.fromARGB(255, 71, 166, 244),
                              const Color.fromARGB(255, 62, 39, 176),
                            ],
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            child: IconButton(
                              icon: Icon(
                                Icons.bookmark_add,
                                color: isbookmark[index]
                                    ? Color.fromARGB(255, 255, 204, 50)
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isbookmark[index] = !isbookmark[index];
                                });
                              },
                            ),
                          ),
                          title: Text(
                            topicIndex['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                print(
                                  'สมัครคอร์สเรียน: ${topicIndex['title']}',
                                );
                                lessonCollection.doc(topicIndex.id).update({
                                  'start_learning': true,
                                }).then((value) {
                                  print(
                                      'การเรียน ${topicIndex['title']} เริ่มแล้ว');
                                }).catchError((error) {
                                  print(
                                      'เกิดข้อผิดพลาดในการเพิ่มข้อมูล: $error');
                                });
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
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
                return Center(child: Text('No data'));
              }
            },
          ),
        ],
      ),
    );
  }
}
