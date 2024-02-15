import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isObscureConfirmPassword = !_isObscureConfirmPassword;
    });
  }

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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      } else {
        print('Passwords don\'t match');
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
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        if (value!.isEmpty) return 'Please enter your email';
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscurePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(
                            _isObscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter a password';
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: _isObscureConfirmPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: _toggleConfirmPasswordVisibility,
                          icon: Icon(
                            _isObscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please confirm your password';
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUserUp();
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Black to Log in',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
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
