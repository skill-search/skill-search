import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final Map<String, dynamic> entry;

  const ListingCard({super.key, required this.entry});

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
              subtitle: Text('Category: ${entry['serviceCategory']}'),
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
                          onPressed: () {/* ... */},
                        ),
                        TextButton(
                          child: const Text('Edit'),
                          onPressed: () {/* ... */},
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
