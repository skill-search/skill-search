// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Color _backgroundColor = Color(0xFF4b68ff);
Color _buttonColor = Color.fromARGB(255, 204, 229, 228);
Color _textColor = Color.fromARGB(255, 204, 229, 228);
Color _textFieldColor = const Color.fromARGB(255, 242, 212, 146);
Color _textFieldTextColor = Color.fromARGB(255, 204, 229, 228);

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // These are the variables that will be used to store the user's input for backend authentication
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // This is the future that will be used to control the submit button's behavior

  void signIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException {
      // WRONG EMAIL OR PASSWORD
      Navigator.pop(context);
      wrongCredentialMessage();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // wrong email message popup
  void wrongCredentialMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wrong Email or Password'),
      ),
    );
  }

  // This method is rerun every time setState is called
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
                    'SkillSearch',
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
                        TextButton(
                          onPressed: () {
                            // Add your logic here for forgot password
                          },
                          child: const Text('Forgot password?'),
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
                            signIn();
                          },
                          child: const Text('Log In'),
                        ),
                        // Button to Register
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(130, 40)),
                            backgroundColor:
                                MaterialStateProperty.all(_buttonColor),
                          ),
                          onPressed: widget.showRegisterPage,
                          child: const Text('Register'),
                        ),
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
