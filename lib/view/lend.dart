import 'package:flutter/material.dart';
import 'ham-menu.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final _itemStream = FirebaseFirestore.instance.collection('items').snapshots();
  void initState(){
    super.initState();
  }

  
  

  @override
  
  

  Widget build(BuildContext context) {
    return Scaffold(
      

      backgroundColor:Colors.grey,
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
        
        body: StreamBuilder(
          stream: _itemStream, 
          builder: ((context, snapshot) {
            if (snapshot.hasError){
              return const Text('Connection Error');
            }

            if (snapshot.connectionState == ConnectionState.waiting){
              return const Text('Loading....');
            }

            var docs = snapshot.data!.docs;
            
            return ListView.builder(
  itemCount: docs.length,
  itemBuilder: ((context, index) {
    // Create a CustomListTile for each item in the list
    return Column(
      children: [
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
                // Customize the top bar as needed
                //padding: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(0),
                width: double.infinity,
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 15,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,), 
                      onPressed: () {},
                    ),
                    Text('Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13
                    ),
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
                onTap: () {
                  // Handle tap event here
                },
              ),
              bottomBar: Container(
                // Customize the bottom bar as needed
                //padding: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.black,
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
                      onPressed: () {},
                    ),
                    ])
              ),
            ),
          ),
        ),
        SizedBox(height: 5)
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
