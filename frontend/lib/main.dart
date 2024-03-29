// ignore_for_file: unused_field

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/auth_page.dart';
import 'package:frontend/firebase_options.dart';
import 'package:get/get.dart';

// This is the main entry point of the application, which will direct to AuthPage
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skill Issue', // App Name
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 7, 152, 255)),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
