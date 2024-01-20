import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _userEmail = FirebaseAuth.instance.currentUser!.email;
  final _serviceName = TextEditingController();
  final _serviceCategory = TextEditingController();
  final _serviceDescription = TextEditingController();
  final _servicePrice = TextEditingController();
  final _userQualification = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _serviceName.dispose();
    _serviceCategory.dispose();
    _serviceDescription.dispose();
    _servicePrice.dispose();
    _userQualification.dispose();
    super.dispose();
  }

  Future postService(
      String userEmail,
      String serviceName,
      String serviceCategory,
      String serviceDescription,
      int servicePrice,
      String userQualification) async {
    try {
      await FirebaseFirestore.instance.collection('listing').add({
        'userEmail': userEmail,
        'serviceName': serviceName,
        'serviceCategory': serviceCategory,
        'serviceDescription': serviceDescription,
        'servicePrice': servicePrice,
        'userQualification': userQualification,
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Service Name',
              ),
              controller: _serviceName,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Service Category',
              ),
              controller: _serviceCategory,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Service Description',
              ),
              controller: _serviceDescription,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Service Price',
              ),
              controller: _servicePrice,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'User Qualification',
              ),
              controller: _userQualification,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postService(
                    _userEmail!,
                    _serviceName.text,
                    _serviceCategory.text,
                    _serviceDescription.text,
                    int.parse(_servicePrice.text),
                    _userQualification.text);
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    ));
  }
}
