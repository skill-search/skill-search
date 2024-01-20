import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/common/custom-shapes/primary_header_container.dart';
import 'package:frontend/common/custom-shapes/search_container.dart';
import 'package:frontend/common/product/grid_layout.dart';
import 'package:frontend/common/product/product_card_vertical.dart';
import 'package:frontend/common/texts/section_heading.dart';
import 'package:frontend/features/home/home_appbar.dart';
import 'package:frontend/features/home/home_categories.dart';
import 'package:frontend/features/home/promo_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

    @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> listData = [];
  final List<String> listId = [];

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('listing')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              if (!document.data().containsValue(
                  FirebaseAuth.instance.currentUser!.email.toString())) {
                listData.add(document.data());
                listId.add(document.id);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getDocID(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            children: [
              //head
              PrimaryHeaderContainer(
                child: Column(children: [
                  HomeAppBar(),
                  SizedBox(height: 16),
                  SearchContainer(text: 'Search Service'),
                  SizedBox(height: 24),
                  const PromoSlider(banners: [
                    'https://static01.nyt.com/images/2023/07/20/multimedia/18barbie-review-ftwc/18barbie-review-ftwc-superJumbo.jpg?quality=75&auto=webp',
                    'https://media.gq.com/photos/645956c367d4264086a5d77f/16:9/w_1920,c_limit/Screen%20Shot%202023-05-08%20at%204.07.48%20PM.png',
                    'https://www.denofgeek.com/wp-content/uploads/2022/02/spaceship-and-black-hole-in-Interstellar.jpeg?resize=768%2C432',
                  ]),
                ]),
              ),

              //body
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: SectionHeading(
                      title: 'Popular Categories',
                      showActionButton: false,
                      textColor: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  HomeCategories(),
                  GridLayout(
                      itemCount: listData.length,
                      itemBuilder: (_, index) =>  ProductCardVertical(
                          entry: listData[index],
                          docID: listId[index],
                          ))
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}