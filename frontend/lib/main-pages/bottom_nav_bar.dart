import 'package:flutter/material.dart';
import 'package:frontend/main-pages/chat_page.dart';
import 'package:frontend/main-pages/home_page.dart';
import 'package:frontend/main-pages/listing_page.dart';
import 'package:frontend/main-pages/post_page.dart';
import 'package:frontend/main-pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [
    const HomePage(),
    const ChatPage(),
    const PostPage(),
    const ListingPage(),
    ProfilePage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.cottage_outlined),
                activeIcon: Icon(
                  Icons.cottage,
                  color: Colors.black54,
                )),
            BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(Icons.mail_outline),
                activeIcon: Icon(
                  Icons.mail,
                  color: Colors.black54,
                )),
            BottomNavigationBarItem(
                label: 'Post',
                icon: Icon(Icons.add_box_outlined),
                activeIcon: Icon(
                  Icons.add_box,
                  color: Colors.black54,
                )),
            BottomNavigationBarItem(
                label: 'Listing',
                icon: Icon(Icons.note_alt_outlined),
                activeIcon: Icon(
                  Icons.note_alt,
                  color: Colors.black54,
                )),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.black54,
                )),
          ]),
    );
  }
}
