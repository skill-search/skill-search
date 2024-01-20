import 'package:flutter/material.dart';
import 'package:frontend/common/image-texts/vertical_image_text.dart';

class HomeCategories extends StatelessWidget {
  // List of service categories and corresponding image paths
  final List<Map<String, String>> serviceData = [
    {'title': 'Event Planning', 'image': 'images/Event Planning.png'},
    {
      'title': 'Administrative Support',
      'image': 'images/Administrative Support.png'
    },
    {'title': 'Design & Creative', 'image': 'images/Design & Creative.png'},
    {
      'title': 'Education & Training',
      'image': 'images/Education & Training.png'
    },
    {
      'title': 'Engineering & Architecture',
      'image': 'images/Engineering & Architecture.png'
    },
    {
      'title': 'Finance & Accounting',
      'image': 'images/Finance & Accounting.png'
    },
    {'title': 'Handyman Services', 'image': 'images/Handyman Services.png'},
    {'title': 'Health & Wellness', 'image': 'images/Health & Wellness.png'},
    {'title': 'Legal', 'image': 'images/Legal.png'},
    {'title': 'Marketing', 'image': 'images/Marketing.png'},
    {'title': 'Programming & Tech', 'image': 'images/Programming & Tech.png'},
    {'title': 'Sales & Business', 'image': 'images/Sales & Business.png'},
    {
      'title': 'Writing & Translation',
      'image': 'images/Writing & Translation.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: serviceData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          String title = serviceData[index]['title'] ?? '';
          String image = serviceData[index]['image'] ?? '';

          return VerticalImageText(
            image: image,
            title: title,
            onTap: () {
              // Handle onTap event if needed
            },
          );
        },
      ),
    );
  }
}
