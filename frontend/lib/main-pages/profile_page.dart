import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _bioController = TextEditingController();
  final _userContactController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser?.email.toString();

  final successSnackBar = SnackBar(
      content: Text(
        'Profile Updated!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3));

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void updateProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(currentUser).set({
      'age': _ageController.text,
      'gender': _genderController.text,
      'bio': _bioController.text,
      'contact': _userContactController.text,
    }, SetOptions(merge: true));
  }

  void getProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .snapshots()
        .forEach((element) {
      _ageController.text = element.get('age');
      _genderController.text = element.get('gender');
      _bioController.text = element.get('bio');
      _userContactController.text = element.get('contact');
    });
  }

  @override
  Widget build(BuildContext context) {
    getProfile();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Logout':
                  signOut();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.all(20),
                child: RoundedContainer(
                  padding: EdgeInsets.all(20),
                  showBorder: true,
                  backgrounColor: Color.fromARGB(255, 169, 183, 255),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Age',
                            hintText: 'Please enter your age.'),
                      ),
                      TextFormField(
                        controller: _genderController,
                        decoration: InputDecoration(
                            labelText: 'Gender',
                            hintText: 'Please enter your gender.'),
                      ),
                      TextFormField(
                        controller: _bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: 'Bio',
                            hintText: 'Tell us more about yourself.'),
                      ),
                      TextFormField(
                        controller: _userContactController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Contact',
                            hintText: 'How should other users contact you?'),
                      ),
                      SizedBox(height: 180),
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle the form submission logic here
                            updateProfile();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successSnackBar);
                          },
                          child: Text('Update Profile'),
                        ),
                      )
                    ],
                  )),
                ))),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _genderController.dispose();
    _bioController.dispose();
    _userContactController.dispose();
    super.dispose();
  }
}
