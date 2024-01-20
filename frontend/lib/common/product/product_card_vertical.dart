import 'package:flutter/material.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/images/rounded_image.dart';
import 'package:frontend/common/product/product_detail.dart';
import 'package:frontend/helper-function/image_helper.dart';
import 'package:get/get.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.entry,
    required this.docID,
    });

    final Map<String, dynamic> entry;
    final String docID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(entry: entry, docID: docID)),
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
                padding: EdgeInsets.all(8),
                backgrounColor: Color(0xFFF6F6F6),
                child: Stack(
                  children: [
                    //Thumbnail Image
                    RoundedImage(
                      imageUrl:
                          ImageHelper.getImagePath(entry['serviceCategory']),
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
                      entry['serviceName'],
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8 / 2),
                    RoundedContainer(
                      padding: EdgeInsets.only(right:4, left:4),
                      backgrounColor: Color(0xFF4b68ff),
                      child: Text(
                        entry['serviceCategory'],
                        style: Theme.of(context).textTheme.labelSmall!.apply(color: Color(0xFFFFFFFF)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 16 / 2),
                    Row(
                      children: [
                        Text(
                          '\$${entry['servicePrice']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall,
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