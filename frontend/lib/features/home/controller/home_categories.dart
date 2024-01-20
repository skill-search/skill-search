import 'package:flutter/material.dart';
import 'package:frontend/common/image-texts/vertical_image_text.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return VerticalImageText(
            image: '',
            title: 'Servicessss',
            onTap: () {},
          );
        },
      ),
    );
  }
}
