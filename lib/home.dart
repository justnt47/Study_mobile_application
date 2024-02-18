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
        child: Column(children: [Container(
          height: size.height * 0.35,
          width: size.width,
          child: Carousel(
            indicatorBarColor: Colors.black.withOpacity(0.2),
            autoScrollDuration: Duration(seconds: 2),
            animationPageDuration: Duration(milliseconds: 400),
            activateIndicatorColor: Colors.black,
            animationPageCurve: Curves.bounceInOut,
            indicatorBarHeight: 50,
            indicatorHeight: 20,
            indicatorWidth: 20,
            unActivatedIndicatorColor: Colors.grey,
            stopAtEnd: true,
            autoScroll: true,
            items: [
              Container(
                child: Image.asset('images/anime1.jpg', fit: BoxFit.cover,),
              ),
              Container(
                child: Image.asset('images/anime2.jpg',fit: BoxFit.cover,),
              ),
              Container(
                child: Image.asset('images/anime3.jpg',fit: BoxFit.cover,),
              )
            ],
          ),
        )]),
      ),
    );
  }
}
