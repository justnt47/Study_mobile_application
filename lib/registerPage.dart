import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registPage extends StatefulWidget {
  const registPage({super.key});

  @override
  State<registPage> createState() => _registPageState();
}

class _registPageState extends State<registPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } else {
        print("Passwords doesn't match");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child:
              Text('Example Firebase', style: TextStyle(color: Colors.white)),
        ),
        actions: [Icon(Icons.help, color: Colors.white)],
        backgroundColor: Color.fromRGBO(40, 84, 48, 1),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text(
                'Create accout',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอก email';
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสยืนยัน';
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        signUserUp();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(164, 190, 123, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
