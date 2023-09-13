import 'package:flutter/material.dart';
import 'ham-menu.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
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
        );
  }
}