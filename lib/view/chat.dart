import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:len_den1/view/chat_service.dart';
import 'package:len_den1/view/chatbubble.dart';

class chat extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserId;
  const chat({super.key,
  required this.recieverUserEmail,
  required this.recieverUserId, required String receiverUserEmail, required String receiverUserId});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  void sendMessage() async {
    //only send mssg if there is smthg to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.recieverUserId, _messageController.text);
      //clear controller after sending the message
      _messageController.clear();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 10, 38, 71),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 66, 114),
        title: Text(widget.recieverUserEmail,
        style: TextStyle(
        color: Colors.white, // Set the text color to white or any other color that works with your background
        fontSize: 18, // Adjust the font size as needed
        )
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: _buildMessageList(),
            ),

            //user imput
            _buildMessageInput(),

          SizedBox(height: 20),
        ],

      ),
    );
  }

  //build mssg list
  Widget _buildMessageList () {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recieverUserId, _firebaseAuth.currentUser!.uid), 
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children : snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
          
        );
      }
      )
    );
  }

  //build mssg item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align mssg to right side if sender is current user otherwise to the left
    var alignment = (data['senderId']==_firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            //Text(data['senderEmail']),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //build mssg input
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, ),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            controller: _messageController,
            obscureText: false,
            decoration: InputDecoration(labelText: 'Enter Message',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      )
                      ),
    
          ),
          ),
    
          //send button
          IconButton(onPressed: sendMessage, 
          icon: Icon(Icons.send_sharp,
          size: 20,))
        ],
      ),
    );
  }
}