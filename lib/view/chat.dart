import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 10, 38, 71),

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 66, 114),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,      
              ),
            ),
        ],
        ) ,
      ),

      body: Container(),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 20, 66, 114),
        height: size.height / 12,
        width: size.width /1.1,
        child: Row(
          children: [
            Container(
              color: Colors.white,

              //height: size.height / 10,
              width: size.width /1.155,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(8)
                  )
                ),
              )
            ),
            IconButton(onPressed: () {}, 
            icon: Icon(Icons.send,
            color: Colors.white,)
            
            )
          ],
        ),
      ),
    );
  }
} 