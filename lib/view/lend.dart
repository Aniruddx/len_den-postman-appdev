import 'package:flutter/material.dart';
import 'ham-menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'borrow.dart';
import 'post.dart';

import 'lend1.dart';
final CollectionReference userRef =  FirebaseFirestore.instance.collection('users');

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState(){
    //getUsers();
    //getUsersbyID();
    super.initState();
  }

  /*getUsers() {
    userRef.get().then((QuerySnapshot snapshot){        //can also use async and await instead of the then()
    snapshot.docs.forEach((DocumentSnapshot doc){
      print(doc.data);
    }); 
    });
  }*/
  
  int _index = 0;
  List<Widget> _screens = [
    HomePage(),
    post(),
    borrow(),
  ];

  @override
  
  

  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],

      backgroundColor:Color.fromARGB(255, 3, 63, 113),
      appBar: AppBar(
        backgroundColor: Colors.black,
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
              onPressed: () {},
            )
        ],
        ) ,
        ),

        bottomNavigationBar: CustomNavigationBar(
          
          backgroundColor: Colors.black,         
          
          items: [
            CustomNavigationBarItem(
              //onItemTap () {},
              icon: Icon(Icons.gavel_outlined,
              color: Colors.white,),
              //label: 'Lend',
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.add_box_sharp,
              color: Colors.white),
              //label: 'Post',
            ),
            CustomNavigationBarItem(
              
              icon: Icon(Icons.book_outlined,
              color: Colors.white,),
              //label: 'Borrow',
              
            ),
            
          ],
          onTap: (i){
            setState(() {
              _index = i;
            });
          },
          /*selectedLabelStyle: TextStyle(
            color: Colors.white, 
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: const Color.fromARGB(255, 185, 51, 51), 
            fontSize: 15,
            fontWeight: FontWeight.bold, 
        ),*/
        ),
        


        );
  }
}
