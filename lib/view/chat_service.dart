import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String recieverId, String message) async{
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      recieverId: recieverId, 
      message: message, 
      timestamp: timestamp
      );
      List<String> ids = [currentUserId, recieverId];
      ids.sort();
      String chatRoomId = ids.join("_"); //join to have single chat id for 2 users

      await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());

  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    //construct chat room ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}
