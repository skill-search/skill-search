import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/common/messages/messages.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverID, String message, String chatRoomId) async {
    //get current user info 
    final String currentUser = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(sender: currentUser, receiver: receiverID, message: message, timestamp: timestamp);

    //add new message to database
    await _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .orderBy('Timestamp', descending: false)
    .snapshots();
  }

    //send message
  Future<void> createChat(String receiverID, Map<String, dynamic> entry, String docID) async {
    //get current user info
    final String currentUser = _firebaseAuth.currentUser!.email.toString();

    //construct chatroom id from current user and receiverID
    List<String> ids = [currentUser, receiverID];
    ids.sort();
    String chatRoomId = ids.join("_") + "_" + entry['serviceName'];

    //add new message to database
    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'client': currentUser,
      'freelancer': receiverID,
      'serviceID': docID,
    }, SetOptions(merge: true));
  }
}