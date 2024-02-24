import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: Image.asset(
            "images/Image_Not_found.jpg",
            height: 160,
          )),
          StreamBuilder(
              stream: topicCollection
                  .where("uid", isEqualTo: user?.uid.toString())
                  .snapshots(),
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
                          child: Column(
                            children: [
                              Text(topicIndex['displayName']),
                              ShowUserEmail(),
                            ],
                          ));
                    }),
                  );

                  //-------- ถ้าไม่มีข้อมูลในฐานข้อมูลให้แสดงคำว่า 'No data' --------
                } else {
                  return Center(child: Text('No data'));
                }
              }),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Setting",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () => true,
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
              signUserOut();
              // Navigator.pop(context);
            },
            // onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
