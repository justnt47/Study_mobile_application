import 'package:flutter/material.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 290,
              ),
              Text(
                "This is Homepage",
                style: TextStyle(fontSize: 50),
              ),
              Icon(Icons.abc)
            ],
          ),
        ),
      ),
    );
  }
}
