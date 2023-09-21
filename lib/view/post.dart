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

 int _index = 0;
 void _toggleSection(int index){
  setState(() {
    _index = index;
  });
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

        body: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  _toggleSection(0);
                },
                child: Text('Borrow'),
              ),
              TextButton(
                onPressed: () {
                  _toggleSection(1);
                },
                child: Text('Lend'),
              ),
            ],
            ),
            _index==0
            ?borrowForm()
            :lendForm()
            
            
          ],
        ),


        );
  }
}


class borrowForm extends StatefulWidget {
  const borrowForm({super.key});

  @override
  State<borrowForm> createState() => _borrowFormState();
}

class _borrowFormState extends State<borrowForm> {

  final _formKey = GlobalKey<FormState>();
  final _itemTitleController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  
  // Function to handle item posting
  Future<void> _postItem() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userUid = currentUser.uid;

      // Get a reference to the Firestore collection
      final itemsCollection = FirebaseFirestore.instance.collection('borrowitems');

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
    return Padding(
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
                      fontSize: 15,
                    )
                    ),
                    style: TextStyle(
                      color: Colors.yellow
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
                      fontSize: 15,
                    )
                    ),
                    style: TextStyle(
                      color: Colors.yellow
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
                    child: Text('POST'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 13, 147, 147)
                    ),
                  ),
                ],
              ),
            ),
      );
  }
}

class lendForm extends StatefulWidget {
  const lendForm({super.key});

  @override
  State<lendForm> createState() => _lendFormState();
}

class _lendFormState extends State<lendForm> {
  final _formKey = GlobalKey<FormState>();
  final _itemTitleController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  
  // Function to handle item posting
  Future<void> _lendItem() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userUid = currentUser.uid;

      // Get a reference to the Firestore collection
      final itemsCollection = FirebaseFirestore.instance.collection('lenditems');
      
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
    return Padding(
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
                      fontSize: 15,
                    )
                    ),
                    style: TextStyle(
                      color: Colors.yellow
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
                      fontSize: 15,
                    )
                    ),
                    style: TextStyle(
                      color: Colors.yellow
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
                        _lendItem();
                      }
                    },
                    child: Text('POST'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 13, 147, 147)
                    ),
                  ),
                ],
              ),
            ),
      );
  }
}