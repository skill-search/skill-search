import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';

// dropdown category values
final List<dynamic> _dropdownCategoryValues = [
  'Handyman Services',
  'Design & Creative',
  'Writing & Translation',
  'Programming & Tech',
  'Marketing',
  'Administrative Support',
  'Finance & Accounting',
  'Legal',
  'Sales & Business',
  'Engineering & Architecture',
  'Education & Training',
  'Health & Wellness',
  'Event Planning',
];

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String? _dropdownCategoryValue;
  final _formKey = GlobalKey<FormState>();
  final _userEmail = FirebaseAuth.instance.currentUser!.email;
  final _serviceName = TextEditingController();
  final _serviceDescription = TextEditingController();
  final _servicePrice = TextEditingController();
  final _userQualification = TextEditingController();

  final successSnackBar = SnackBar(
      content: Text(
        'Service posted!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3));

  final errorSnackBar = SnackBar(
      content: Text('Please fill in all the fields!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _serviceName.dispose();
    _serviceDescription.dispose();
    _servicePrice.dispose();
    _userQualification.dispose();
    super.dispose();
  }

  void dropdownCategoryValueCallback(String? selectedCategory) {
    setState(() {
      _dropdownCategoryValue = selectedCategory;
    });
  }

  Future postService(
    String userEmail,
    String serviceName,
    String serviceCategory,
    String serviceDescription,
    int servicePrice,
    String userQualification,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('listing').add({
        'userEmail': userEmail,
        'serviceName': serviceName,
        'serviceCategory': serviceCategory,
        'serviceDescription': serviceDescription,
        'servicePrice': servicePrice,
        'userQualification': userQualification,
        'hasClient': false,
        'completed': false
      });
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Positioned(
          top: 400,
          left: -175,
          child: CircularContainer(
            width: 750,
            height: 600,
            radius: 300,
            backgroundColor: Color(0xFF4b68ff),
          )),
      Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Service Name',
                    ),
                    controller: _serviceName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Service name cannot be empty!';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  items: _dropdownCategoryValues
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: dropdownCategoryValueCallback,
                  menuMaxHeight: 350,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Service Category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Service Category cannot be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Service Description',
                    ),
                    controller: _serviceDescription,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Service Description cannot be empty!';
                      }
                      return null;
                    }),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Service Price',
                  ),
                  controller: _servicePrice,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Service Price cannot be empty!';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'User Qualification',
                    ),
                    controller: _userQualification,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'User Qualification cannot be empty!';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postService(
                          _userEmail!,
                          _serviceName.text,
                          _dropdownCategoryValue!,
                          _serviceDescription.text,
                          int.parse(_servicePrice.text),
                          _userQualification.text);

                      // Clear the form fields
                      _serviceName.clear();
                      _serviceDescription.clear();
                      _servicePrice.clear();
                      _userQualification.clear();
                      setState(() {
                        _dropdownCategoryValue = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                    }
                  },
                  child: Text('Post Service'),
                )
              ],
            ),
          )),
    ]));
  }
}
