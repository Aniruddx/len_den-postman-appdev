

/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: ChatListScreen(),
  ));
}

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: StreamBuilder<QuerySnapshot> (
        stream: _firestore.collection('chatRooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('You haven\'t talked to anyone yet.'),
            );
          }

          final chatRooms = snapshot.data!.docs;
          List<Widget> chatListItems = [];
          Future<void> fetchData() async{ 
          for (final room in chatRooms) {
            final users = room['users'] as List<dynamic>;
            final user1 = users[0];
            final user2 = users[1];

            // Fetch user information from Firestore based on user1 and user2 IDs.
            final user1Data = await getUserData(user1);
            final user2Data = await getUserData(user2);

            final chatListItem = ListTile(
              title: Text(user1Data?['name'] ?? 'User Name'), // Replace with user1's name
              subtitle: Text('Last message'), // Replace with the last message.
              onTap: () {
                // Navigate to the chat screen for this user.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      user1Data: user1Data,
                      user2Data: user2Data,
                    ),
                  ),
                );
              },
            );

            chatListItems.add(chatListItem);
          }
        }
          return ListView(
            children: chatListItems,
          );
        },
      ),
    );
  }

  // Replace 'users' with your actual Firestore collection name for user data.
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final userDoc = await usersCollection.doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null; // User not found.
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic>? user1Data;
  final Map<String, dynamic>? user2Data;

  ChatScreen({
    required this.user1Data,
    required this.user2Data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user1Data?['name'] ?? 'User Name'), // Replace with user1's name
      ),
      body: Center(
        child: Text('Chat Screen Content'),
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:len_den1/view/chat.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('chatRooms').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final currentUserID = _auth.currentUser?.uid;

          final chatRooms = snapshot.data?.docs.where((doc) {
            final users = doc['users'] as List<dynamic>;
            return users.contains(currentUserID);
          }).toList();

          return ListView.builder(
            itemCount: chatRooms?.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms?[index];
              final users = chatRoom?['users'] as List<dynamic>;

              // Get the other user's ID
              final otherUserID = users.firstWhere(
                (user) => user != currentUserID,
                orElse: () => null,);
              if (otherUserID == null) {
  // Handle the case where no other user was found in the chat room.
  return Container(); // Or some other placeholder widget.
}
              return FutureBuilder(
                future: _firestore.collection('users').doc(otherUserID).get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  if (userSnapshot.hasError) {
      // Handle the error gracefully, e.g., display an error message.
      return Text('Error loading user data');
    }
     if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
      // Handle the case where the user document doesn't exist.
      return Text('User not found');
    }
                  final userName = userSnapshot.data?['name'];

                  return GestureDetector(
                    /*onTap: () {
                      final receiverUserEmail = '...'; // Replace with the logic to get the receiver's email
    final receiverUserId = '...';   // Replace with the logic to get the receiver's user ID

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => chat(
          recieverUserEmail: '', 
          recieverUserId: '',
        ),
      ),
    );
                    },*/
                    child: ListTile(
                      title: Text(userName),
                      // You can add more UI elements here for each chat room
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
