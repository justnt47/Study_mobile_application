import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_image_slider/indicator/Circle.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('LEARNING FUTURE', style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: size.height * 0.35,
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
                        child: Image.asset('images/anime1.jpg', fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('images/anime2.jpg', fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('images/anime3.jpg', fit: BoxFit.cover,),
                      ),
                    ),                   
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('แนะนำคอร์สเรียน', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
