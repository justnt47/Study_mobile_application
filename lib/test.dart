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
              stream: lessonCollection.where("title").snapshots(),
              builder: (context, snapshot) {
                // print(
                //     "${FirebaseFirestore.instance.collection("Users")} print is here ///////////////");
                // print(user?.uid.toString());
                // print(
                //     "${FirebaseFirestore.instance.collection("displayName").where("uid", isEqualTo: user?.uid).snapshots()} print is here ///////////////");
                // print(
                //     "${FirebaseFirestore.instance.collection("uid").where("uid", isEqualTo: "QEMYbhzDhqSIcviYCpVJ2Pq6B3H2").snapshots()} print is here ///////////////");
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      var topicIndex = snapshot.data!.docs[index];
                      return GestureDetector(
                          //--- เมื่อคลิกที่ข้อมูล title ที่ดึงมาให้แสดง popup เพื่อแสดงรายละเอียด ---
                          onTap: () {
                            //---- เรียกฟังก์ชันชื่อ showDetail ด้านล่าง ----
                            //showDetail(topicIndex);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.bookmark_add_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            title: Text(topicIndex['title']),
                            // subtitle: Text(topicIndex['description']),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  print(
                                      'สมัครคอร์สเรียน: ${topicIndex['title']}');
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
                                'เริ่มเรียน',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ));
                    }),
                  );

                  //-------- ถ้าไม่มีข้อมูลในฐานข้อมูลให้แสดงคำว่า 'No data' --------
                } else {
                  return Center(child: Text('No data'));
                }
              }),
        ],
      ),
    );
  }
}
