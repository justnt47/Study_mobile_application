import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/loginPage.dart';
import 'package:test_any_code/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class acc extends StatefulWidget {
  acc({super.key});

  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
              child: Image.asset(
            "images/Image_Not_found.jpg",
            height: 160,
          )),
          StreamBuilder(
              stream: userCollection
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
