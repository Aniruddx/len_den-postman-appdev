import 'package:flutter/material.dart';
import 'package:len_den1/view/chat.dart';
import 'package:len_den1/view/chat_list_screen.dart';
import 'ham-menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'chat.dart';




class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
FirebaseAuth _authh = FirebaseAuth.instance; 
class _HomePageState extends State<HomePage> {

//final _itemStream = FirebaseFirestore.instance.collection('lenditems').snapshots();
  void initState(){
    super.initState();
  }
String recieverUserEmail = '';
String chatRoomId(String user1, String user2) {
  if(user1[0].toLowerCase().codeUnits[0] > user2[0].toLowerCase().codeUnits[0]) {
    return "$user1$user2";
  }
  else {
    return "$user2$user1";}
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      

      backgroundColor:Color.fromARGB(255, 10, 38, 71),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 66, 114),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.menu_sharp), 
              onPressed: () {
                setState(() { Navigator.push(context, MaterialPageRoute(builder: ((context) => Profile())));
                });
              },
            ),

            Text(
              'Lend Requests',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,      
              ),
            ),

            IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.chat_rounded), 
              onPressed: () {
                setState(() { Navigator.push(context, MaterialPageRoute(builder: ((context) => ChatListScreen())));
                });
              },
            )
        ],
        ) ,
        ),
        
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('lenditems').snapshots(), 
          builder: ((context, snapshot) {
            if (snapshot.hasError){
              return const Text('Connection Error');
            }

            if (snapshot.connectionState == ConnectionState.waiting){
              return const Text('Loading....');
            }
            
            final lendItems = snapshot.data?.docs;
            var docs = snapshot.data!.docs;
            
            return ListView.builder(
              itemCount: lendItems?.length,
              itemBuilder: ((context, index) {
                final lendItem = lendItems?[index].data() ;
                final userId = lendItem?['postedBy'];
                String receiverEmail = '';
    // Create a CustomListTile for each item in the list
    return Column(
      children: [
        SizedBox(height: 15,),
        Container(
          margin: EdgeInsets.all(8.0), // Adjust the margin as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20.0)), // Optional: Add rounded corners
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            
            child: CustomListTile(
              topBar: Container(
                height: 30,
                // Customize the top bar as needed
                //padding: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(0),
                width: double.infinity,
                color: Color.fromARGB(255, 20, 66, 114),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 15,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,), 
                      onPressed: () {},
                    ),
                    Row(
                      children: [
                        
                        FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator
                }
                if (userSnapshot.hasError) {
                  return Text('Error: ${userSnapshot.error}');
                }
                
                final userData = userSnapshot.data?.data();

                receiverEmail = userData?['email'];
                
                
                        /*if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          );
                        }*/
                
                        // Retrieve the username from the user document
                        //String username = snapshot.data?['name'];
                
                        return Text(
                          '${userData?['name']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        );
                      
                    
                 
  
                
                
              }
            ),
                        
                      ],
                    )
              
                  ],
                ),
                
              ),
              listTile: ListTile(
                // Customize the ListTile as needed
                title: Text(docs[index]['title'],
                style: TextStyle(
                  color: Colors.white
                ),),
                
                subtitle: Text(docs[index]['description'],
                style: TextStyle(
                  color: Colors.white
                ),),
                tileColor: Color.fromARGB(255, 17, 57, 98),
                onTap: () {
                  // Handle tap event here
                },
              ),
              bottomBar: Container(
                height: 30,
                // Customize the bottom bar as needed
                //padding: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Color.fromARGB(255, 20, 66, 114),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 15,
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.white,), 
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 15,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,), 
                      onPressed: () async {
                        String currentUserId = _authh.currentUser!.uid;
                        String otherUserId = userId;
                        
                        String roomId = chatRoomId(currentUserId, otherUserId);
                        DocumentReference chatRoomRef = FirebaseFirestore.instance.collection('chatRooms').doc(roomId);

                          if (!(await chatRoomRef.get()).exists) {
      // Create the chat room if it doesn't exist
                          await chatRoomRef.set({
                          'users': [currentUserId, otherUserId],
                          });
                          }
                        

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chat(
                            //roomId: roomId,
                            //currentUserId: currentUserId,
                            receiverUserEmail: receiverEmail, 
                            receiverUserId:  otherUserId, recieverUserEmail: '$receiverEmail', recieverUserId: '$otherUserId',
                            //otherUserName: userData?['name'],
                            ), 
                          ),
                        );
                        

                      },
                    ),
                    ])
              ),
            ),
          ),
        ),
        
      ],
    );
  }),
);


          } )),

        

        );
  }
}


class CustomListTile extends StatelessWidget {
  final Widget topBar;
  final ListTile listTile;
  final Widget bottomBar;

  CustomListTile({
    required this.topBar,
    required this.listTile,
    required this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          topBar,
          listTile,
          bottomBar,
        ],
      ),
    );
  }
}


