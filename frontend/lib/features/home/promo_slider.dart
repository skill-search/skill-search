import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';
import 'package:frontend/common/images/rounded_image.dart';
import 'package:frontend/features/home/controller/home_controller.dart';
import 'package:get/get.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              onPageChanged: (index, _) => controller.updatePageIndicator(index)
            ),
            items: banners.map((url) => RoundedImage(imageUrl: url, isNetworkImage: true,)).toList(),
            
            ),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                CircularContainer(
                  width: 20,
                  height: 4,
                  margin: EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouselCurrentIndex.value == i ? Color(0xFF333333) : Color(0xFFE0E0E0),
                ),
            ],
          ),
        )
      ],
    );
  }
}
