import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/images/rounded_image.dart';
import 'package:frontend/helper-function/image_helper.dart';
import 'package:frontend/main-pages/chat_room_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xFF4b68ff),
        body: SingleChildScrollView(
            child: Stack(children: [
      const Positioned(
          top: -150,
          left: -175,
          child: CircularContainer(
            width: 750,
            height: 600,
            radius: 300,
            backgroundColor: Color(0xFF4b68ff),
          )),
      Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              //height: 50,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 88, 116, 255),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TabBar(
                        labelColor: Color(0xFF4b68ff),
                        unselectedLabelColor: Color(0xFFFFFFFF),
                        dividerColor: Colors.transparent,
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        controller: tabController,
                        tabs: [Tab(text: "Client"), Tab(text: "Freelancer")],
                      ))
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [_buildClientList(), _buildFreelancerList()],
            ))
          ],
        ),
      ),
    ]))
        //body: _buildUserList(),
        );
  }

  //build a list of users except for current user
  Widget _buildClientList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat_rooms').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        // Filter documents based on a certain field
        List<QueryDocumentSnapshot> filteredDocs = snapshot.data!.docs
            .where((doc) =>
                doc['client'] ==
                FirebaseAuth.instance.currentUser!.email.toString())
            .toList();
        return ListView(
          children: filteredDocs
              .map<Widget>((doc) => _buildUserListItem(doc, doc.id, true))
              .toList(),
        );
      },
    );
  }

  //build a list of users except for current user
  Widget _buildFreelancerList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat_rooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }
          // Filter documents based on a certain field
          List<QueryDocumentSnapshot> filteredDocs = snapshot.data!.docs
              .where((doc) =>
                  doc['freelancer'] ==
                  FirebaseAuth.instance.currentUser!.email.toString())
              .toList();
          return ListView(
            children: filteredDocs
                .map<Widget>((doc) => _buildUserListItem(doc, doc.id, false))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      DocumentSnapshot document, String chatRoomID, bool client) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('listing').get(),
        builder: (context, listingSnapshot) {
          if (listingSnapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return CircularProgressIndicator();
          }

          if (listingSnapshot.hasError) {
            // If an error occurs
            return Text('Error');
          }

          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          // Create a list variable to store documents from the "listing" collection
          List<QueryDocumentSnapshot> listingDocs = listingSnapshot.data!.docs;

          QueryDocumentSnapshot? targetDocument =
              listingDocs.firstWhere((doc) => doc.id == data['serviceID']);

          // You can access the data of the target document using targetDocument.data()
          Map<String, dynamic> targetData =
              targetDocument.data() as Map<String, dynamic>;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(
                      userEmail: client ? data['freelancer'] : data['client'],
                      chatRoomID: chatRoomID,
                    ),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF232323).withOpacity(0.1),
                          blurRadius: 50,
                          spreadRadius: 7,
                          offset: const Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFFFFFFFF)),
                  child: Row(
                    children: [
                      RoundedContainer(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.all(8),
                          backgrounColor: Color(0xFFF6F6F6),
                          child: Stack(
                            children: [
                              //Thumbnail Image
                              RoundedImage(
                                imageUrl:
                                    ImageHelper.getImagePath(targetData['serviceCategory']),
                                applyImageRadius: true,
                              ),
                            ],
                          )),
                      SizedBox(width: 16 / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            targetData['serviceName'],
                            style: Theme.of(context).textTheme.labelLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 8 / 2),
                          RoundedContainer(
                            padding: EdgeInsets.only(right: 4, left: 4),
                            backgrounColor: Color(0xFF4b68ff),
                            child: Text(
                             targetData['serviceCategory'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .apply(color: Color(0xFFFFFFFF)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 8 / 2),
                          Row(
                            children: [
                              Text(
                                '\$${targetData['servicePrice']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                          Text(
                            'with ' + (client ? data['freelancer'] : data['client']),
                            style: Theme.of(context).textTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      new Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mail_outline),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
