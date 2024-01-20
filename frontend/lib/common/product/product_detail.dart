//product_detail.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/chat/chat_service.dart';
import 'package:frontend/common/appbar/appbar.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';
import 'package:frontend/common/custom-shapes/curved_edge_widget.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/texts/section_heading.dart';
import 'package:frontend/helper-function/image_helper.dart';
import 'package:frontend/main-pages/chat_room_page.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({
    super.key,
    required this.entry,
    required this.docID,
    this.chat = true,
  });

  final bool chat;

  final Map<String, dynamic> entry;
  final String docID;
  final ChatService _chatService = ChatService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createChat(String receiverID) async {
    await _chatService.createChat(receiverID, entry, docID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedEdgeWidget(
              child: Container(
                color: Color(0xFF4b68ff),
                child: Stack(
                  children: [
                    SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Center(
                              child: Image(
                                  image: AssetImage(
                                      ImageHelper.getImagePath(entry['serviceCategory'])))),
                        )),
                    CustomAppBar(
                      showBackArrow: true,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 24, left: 24, bottom: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry['serviceName'],
                      style: Theme.of(context).textTheme.titleLarge!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16 / 2),
                    Row(
                      children: [
                        RoundedContainer(
                          backgrounColor: Color(0xFFE0E0E0),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("\$${entry['servicePrice']}",
                                style:
                                    Theme.of(context).textTheme.titleMedium!),
                          ),
                        ),
                        SizedBox(width: 8),
                        RoundedContainer(
                          padding: const EdgeInsets.all(8),
                          backgrounColor: Color(0xFF4b68ff),
                          child: Text(
                            entry['serviceCategory'],
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .apply(color: Color(0xFFFFFFFF)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16 / 2),
                    //Description of Service
                    RoundedContainer(
                        padding: const EdgeInsets.all(16),
                        backgrounColor: Color(0xFFE0E0E0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeading(
                              title: "Description",
                              showActionButton: false,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              entry['serviceDescription'],
                              style: Theme.of(context).textTheme.titleSmall!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 16 / 2),
                            CircularContainer(
                              height: 5,
                              backgroundColor: Color(0xFF4B68FF),
                            ),
                            const SizedBox(height: 16),

                            //Qualifications
                            const SectionHeading(
                              title: "Qualification",
                              showActionButton: false,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              entry['userQualification'],
                              style: Theme.of(context).textTheme.titleSmall!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )),
                    const SizedBox(height: 16),

                    //Chat button
                    if (chat)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            createChat(entry['userEmail']);
                            List<String> ids = [
                              entry['userEmail'],
                              _firebaseAuth.currentUser!.email.toString()
                            ];
                            ids.sort();
                            String chatRoomId =
                                ids.join("_") + "_" + entry['serviceName'];
                            Get.to(() => ChatRoom(
                                  userEmail: entry['userEmail'],
                                  chatRoomID: chatRoomId,
                                ));
                          },
                          //onTap: () {},
                          child: RoundedContainer(
                            padding: EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 8),
                            backgrounColor: Color(0xFF4B68FF),
                            child: SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline_sharp,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Chat",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(color: Color(0xFFFFFFFF)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}