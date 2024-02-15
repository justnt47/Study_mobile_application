import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text('Loginned ${user!.email}')),
        IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: Icon(Icons.logout))
      ],
    );
  }
}
