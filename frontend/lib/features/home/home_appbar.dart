import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/appbar/appbar.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
  });

  String? username;

  Future<void> getUsername() async {
    
    await FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.email.toString())
    .get()
    .then((value) => username = value['username']);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Good day! Ready to seize the day?',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Color(0xFFE0E0E0))),
        FutureBuilder( 
            future: getUsername(),
            builder: (context, snapshot) => Text(username!,             style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Color(0xFFFFFFFF)))),

      ]),
      actions: [
        //IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined, color: Color(0xFFFFFFFF)))
      ],
    );
  }
}
