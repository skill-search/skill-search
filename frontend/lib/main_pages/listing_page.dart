import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  //Firebase document IDs
  List<Map<String, dynamic>> listData = [];
  List<String> docIDList = [];
  String? docID;

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('listing')
        .get()
        .then((snapshot) {
      return snapshot.docs.forEach((document) {
        if (document.data().containsValue(
            FirebaseAuth.instance.currentUser!.email.toString())) {
          listData.add(document.data());
          docIDList.add(document.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getDocID(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) => Text(
                  listData[index].toString() + ", " +
                  docIDList[index]
                ));
      },
    ));
  }
}

