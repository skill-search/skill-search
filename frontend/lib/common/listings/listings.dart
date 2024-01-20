import 'package:flutter/material.dart';
import 'package:frontend/common/product/product_detail.dart';
import 'package:frontend/common/product/product_detail_edit.dart';
import 'package:get/get.dart';

class ListingCard extends StatelessWidget {
  final Map<String, dynamic> entry;
  final String id;
  const ListingCard({super.key, required this.entry, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          child: Column(
        children: [
          ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(entry['serviceName'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  )),
              leading: Icon(Icons.work),
              subtitle: Text('${entry['serviceCategory']}'),
              children: [
                ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text('${entry['serviceDescription']}'),
                    subtitle:
                        Text('Qualifications: ${entry['userQualification']}')),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selling for: \$${entry['servicePrice']}',
                        textAlign: TextAlign.left),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          child: const Text('View'),
                          onPressed: () {
                            Get.to(() => ProductDetail(
                                entry: entry, docID: id, chat: false));
                          },
                        ),
                        TextButton(
                          child: const Text('Edit'),
                          onPressed: () {
                            Get.to(() => ProductDetailEdit(
                                  entry: entry,
                                  id: id,
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ],
      )),
    );
  }
}
