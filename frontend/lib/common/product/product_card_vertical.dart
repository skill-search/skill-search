import 'package:flutter/material.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/images/rounded_image.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFF232323).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: 7,
            offset: const Offset(0, 2),
          )
        ], borderRadius: BorderRadius.circular(16), color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            //Thumbnail
            RoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(8),
                backgrounColor: Color(0xFFF6F6F6),
                child: Stack(
                  children: [
                    //Thumbnail Image
                    RoundedImage(
                      imageUrl:
                          'https://www.daylightelectrician.com/wp-content/uploads/2016/06/3.jpg',
                      applyImageRadius: true,
                    ),
                  ],
                )),

            const SizedBox(height: 16 / 2),

            //Details
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Electrician Services',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16 / 2),
                    Row(
                      children: [
                        Text(
                          '\$40.5',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
