import 'package:flutter/material.dart';
import 'ham-menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final CollectionReference userRef =  FirebaseFirestore.instance.collection('users');

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {

  final _formKey = GlobalKey<FormState>();
  final _itemTitleController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  
  // Function to handle item posting
  Future<void> _postItem() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userUid = currentUser.uid;

      // Get a reference to the Firestore collection
      final itemsCollection = FirebaseFirestore.instance.collection('items');

      // Create a new document with a unique ID
      await itemsCollection.add({
        'title': _itemTitleController.text,
        'description': _itemDescriptionController.text,
        'postedBy': userUid,
        'postedAt': FieldValue.serverTimestamp(),
      });
    }
    }


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
              'Post a Request',
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

        body: Padding(
        padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
        
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _itemTitleController,
                decoration: InputDecoration(labelText: 'Item Title',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                )
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _itemDescriptionController,
                decoration: InputDecoration(labelText: 'Item Description',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                )
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _postItem();
                  }
                },
                child: Text('Post Item'),
              ),
            ],
          ),
        ),
      ),


        );
  }
}