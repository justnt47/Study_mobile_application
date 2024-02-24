import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> courses = [
    'เริ่มต้น Flutter',
    'ขั้นพื้นฐานการออกแบบ UI ด้วย Flutter',
    'การจัดสถานะใน Flutter',
  ];
  String? selectedCourse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('LEARNING FUTURE', style: TextStyle(color: Colors.black)),
        ),
      ), */
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Container(
              height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
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
                      child:
                          Image.asset('images/anime1.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          Image.asset('images/anime2.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          Image.asset('images/anime3.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Text(
              'แนะนำคอร์สเรียน',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        courses[index],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCourse = courses[index];
                            print('สมัครคอร์สเรียน: ${courses[index]}');
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
