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
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();

    if (docSnapshot.exists) {
      username = docSnapshot['username'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good day! Ready to seize the day?',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: Color(0xFFE0E0E0))),
          FutureBuilder(
            future: getUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for data
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle error
                return Text('Error loading username');
              } else {
                // Display the username when available
                return Text(
                  username ??
                      'Loading...', // Show a placeholder if username is null
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Color(0xFFFFFFFF)),
                );
              }
            },
          ),
        ],
      ),
      actions: [
        //IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined, color: Color(0xFFFFFFFF)))
      ],
    );
  }
}
