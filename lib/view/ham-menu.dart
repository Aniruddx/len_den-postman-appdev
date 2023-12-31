import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';




class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}
FirebaseAuth _authh = FirebaseAuth.instance;
Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 63, 113),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Hi!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 2,
              ),
              ),

            SizedBox(height: 5),

            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(_authh.currentUser?.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  );
                }
                String username = snapshot.data?['name'];
                return Text(
                  username,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                );
              }
            ),

            SizedBox(height: 25,),

            Center(
              child: CircleAvatar(
                //backgroundImage: NetworkImage(userPhotoURL),
                radius: 80,
              ),
            ),

            SizedBox(height: 40,),
            
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                ListTile(
                  leading: Icon(Icons.post_add_sharp,
                  color: Colors.white),
                  title: Text('My Posts',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark_add_outlined,
                  color: Colors.white),
                  title: Text('Bookmarked Posts',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.settings,
                  color: Colors.white),
                  title: Text('Settings',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.feedback_sharp,
                  color: Colors.white),
                  title: Text('Feedback',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.gif_box_outlined,
                  color: Colors.white),
                  title: Text('Donate',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.developer_board,
                  color: Colors.white),
                  title: Text('Developers',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined,
                  color: Colors.white),
                  title: Text('Sign Out',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  ),
                  onTap: () {
                    logout();
                    Navigator.pushReplacement(context, 
                    MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  }
                ),
            
            
              ],
            ),
            )


          ]
        )
        ),
    );
  }
}
