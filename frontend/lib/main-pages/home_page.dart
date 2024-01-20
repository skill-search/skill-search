import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/common/custom-shapes/primary_header_container.dart';
import 'package:frontend/common/custom-shapes/search_container.dart';
import 'package:frontend/common/texts/section_heading.dart';
import 'package:frontend/features/home/home_appbar.dart';
import 'package:frontend/features/home/home_categories.dart';
import 'package:frontend/features/home/promo_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //head
            PrimaryHeaderContainer(
              child: Column(children: [
                const HomeAppBar(),
                const SizedBox(height: 16),
                const SearchContainer(text: 'Search Service'),
                const SizedBox(height: 24),
                PromoSlider(banners: [
                  'https://static01.nyt.com/images/2023/07/20/multimedia/18barbie-review-ftwc/18barbie-review-ftwc-superJumbo.jpg?quality=75&auto=webp',
                  'https://media.gq.com/photos/645956c367d4264086a5d77f/16:9/w_1920,c_limit/Screen%20Shot%202023-05-08%20at%204.07.48%20PM.png',
                  'https://www.denofgeek.com/wp-content/uploads/2022/02/spaceship-and-black-hole-in-Interstellar.jpeg?resize=768%2C432',
                ]),
              ]),
            ),

            //body
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: const SectionHeading(
                    title: 'Popular Categories',
                    showActionButton: false,
                    textColor: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                HomeCategories()
              ],
            )
          ],
        ),
      ),
    );
  }
}
