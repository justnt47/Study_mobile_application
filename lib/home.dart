import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_any_code/firebase.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String? selectedCourse;
  String? learningCourse;
  List<bool> isbookmark = [false, false, false];

  int screenIndex = 0;
  CollectionReference lessonCollection =
      FirebaseFirestore.instance.collection("lessons");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0, left: 10, right: 10),
        decoration: BoxDecoration(
            /* gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ), */
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Container(
              height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Carousel(
                indicatorBarColor: Colors.black.withOpacity(0.2),
                autoScrollDuration: Duration(seconds: 2),
                animationPageDuration: Duration(milliseconds: 400),
                activateIndicatorColor: Colors.white,
                animationPageCurve: Curves.easeInOut,
                indicatorBarHeight: 50,
                indicatorHeight: 20,
                indicatorWidth: 20,
                unActivatedIndicatorColor: Colors.grey.withOpacity(0.5),
                stopAtEnd: true,
                autoScroll: false,
                items: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/anime1.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/anime2.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'images/anime3.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Container(
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
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
                    SizedBox(height: 10),
                    Text(
                      'LEARNING FUTURE',
                      style: GoogleFonts.permanentMarker(fontSize: 30,  color: Colors.blueAccent),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: StreamBuilder(
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
                                            color: isbookmark[index]
                                                ? Color.fromARGB(
                                                    255, 255, 204, 50)
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              saveBookmark(topicIndex["title"],
                                                  topicIndex["description"]);
                                              isbookmark[index] =
                                                  !isbookmark[index];
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
<<<<<<< HEAD
                                            lessonCollection
                                                .doc(topicIndex.id)
                                                .update({
                                              'start_learning': true,
                                            }).then((value) {
                                              print(
                                                  'การเรียน ${topicIndex['title']} เริ่มแล้ว');
                                            }).catchError((error) {
                                              print(
                                                  'เกิดข้อผิดพลาดในการเพิ่มข้อมูล: $error');
                                            });
=======
>>>>>>> main
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
                            return Center(child: Text('No data'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
