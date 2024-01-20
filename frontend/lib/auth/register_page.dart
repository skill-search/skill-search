import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color _backgroundColor = const Color.fromARGB(255, 19, 16, 63);
Color _buttonColor = const Color.fromARGB(255, 202, 234, 255);
Color _textColor = const Color.fromARGB(255, 176, 102, 223);
Color _textFieldColor = const Color.fromARGB(255, 242, 212, 146);
Color _textFieldTextColor = const Color.fromARGB(255, 130, 145, 219);

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

                //after creating new user create document for chat
        _fireStore.collection('users').doc(_emailController.text).set({
          'email': _emailController.text,
          'username': _usernameController.text
          }
        );
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'The password provided must be at least 6 characters long.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is not valid.';
        } else {
          message = 'An unexpected error occurred. Please try again later.';
        }

        // Print e.code
        print(e.code);

        // Show the error message in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );


      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.all(50),
                  child: Image.asset(
                    'images/icon-template.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Skill Issue',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _textColor),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: _textFieldTextColor),
                            fillColor: _textFieldColor,
                            hintText: 'Enter username',
                            hintStyle: TextStyle(color: _textFieldTextColor),
                          ),
                          style: TextStyle(color: _textFieldTextColor),
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          controller: _usernameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: _textFieldTextColor),
                            fillColor: _textFieldColor,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: _textFieldTextColor),
                          ),
                          style: TextStyle(color: _textFieldTextColor),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          controller: _emailController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: _textFieldTextColor),
                            fillColor: _textFieldColor,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: _textFieldTextColor),
                          ),
                          style: TextStyle(color: _textFieldTextColor),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: _textFieldTextColor),
                            fillColor: _textFieldColor,
                            hintText: 'Re-enter your password',
                            hintStyle: TextStyle(color: _textFieldTextColor),
                          ),
                          style: TextStyle(color: _textFieldTextColor),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            }
                            return null;
                          },
                          controller: _confirmpasswordController,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            widget.showLoginPage();
                          },
                          child: const Text(
                            'Already a user?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 94, 144, 236),
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        // Button to Log In
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(130, 40)),
                            backgroundColor:
                                MaterialStateProperty.all(_buttonColor),
                          ),
                          onPressed: () {
                            signUp();
                          },
                          child: const Text('Register'),
                        ),
                        // Button to Register
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
