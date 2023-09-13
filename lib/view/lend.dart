import 'package:flutter/material.dart';
import 'ham-menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
  
  

  @override
  
  

  Widget build(BuildContext context) {
    return Scaffold(
      

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
        );
  }
}
