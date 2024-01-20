import 'package:flutter/material.dart';
import 'package:frontend/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/auth/register_page.dart';
import 'package:frontend/main-pages/bottom_nav_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //logged in
            if (snapshot.hasData) {
              return BottomNavBar();
            }
            //not logged in
            else {
              if (showLoginPage) {
                return LoginPage(showRegisterPage: toggleScreens);
              } else {
                return RegisterPage(showLoginPage: toggleScreens);
              }
            }
          }),
    );
  }
}
