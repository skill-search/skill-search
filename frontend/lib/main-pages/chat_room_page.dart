//chat_room_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/chat/chat_bubble.dart';
import 'package:frontend/chat/chat_service.dart';
import 'package:frontend/common/texts/textfield.dart';

class ChatRoom extends StatefulWidget {
  //userEmail is reciever email
  final String userEmail;
  const ChatRoom({
    super.key,
    required this.userEmail,
    required this.chatRoomID,
  });

  final String chatRoomID;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.userEmail, _messageController.text, widget.chatRoomID);

      //clearing controller after send
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.userEmail)),
        body: Column(children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildMessageInput()
        ]));
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.chatRoomID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data1 = document.data() as Map<String, dynamic>;

    //align the messages based on sender/receiver
    var alignment =
        (data1['sender']) == FirebaseAuth.instance.currentUser!.email.toString()
            ? Alignment.centerRight
            : Alignment.centerLeft;

    Color bubbleColor =
        (data1['sender']) == FirebaseAuth.instance.currentUser!.email.toString()
            ? Colors.blue
            : Color.fromARGB(255, 230, 226, 226);

    Color textColor =
        (data1['sender']) == FirebaseAuth.instance.currentUser!.email.toString()
            ? Colors.white
            : Colors.black;

    return Container(
        alignment: alignment,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: (data1['sender'] ==
                      _firebaseAuth.currentUser!.email.toString())
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: (data1['sender'] ==
                      _firebaseAuth.currentUser!.email.toString())
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(data1['sender']),
                const SizedBox(
                  height: 5,
                ),
                ChatBubble(
                  message: data1['message'],
                  bubbleColor: bubbleColor,
                  textColor: textColor,
                ),
              ],
            )));
  }

  //buidl message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Send Message',
            obscureText: false,
          ),
        ),
        IconButton(
            onPressed: sendMessage, icon: Icon(Icons.arrow_upward, size: 40))
      ],
    );
  }
}