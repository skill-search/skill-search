import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/listings/listings.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  //Firebase document IDs
  List<Map<String, dynamic>> listData = [];
  int counter = 0;

  Future getDocID() async {
    counter++;
    await FirebaseFirestore.instance
        .collection('listing')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // counter++;
              if (document.data().containsValue(
                  FirebaseAuth.instance.currentUser!.email.toString())) {
                listData.add(document.data());
                //counter++;
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getDocID(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) => ListingCard(
                  entry: listData[index],
                ));
      },
    ));
  }
}
