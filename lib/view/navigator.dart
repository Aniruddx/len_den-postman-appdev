import 'package:flutter/material.dart';
import 'borrow.dart';
import 'post.dart';
import 'lend.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';


class Navigatorr extends StatefulWidget {
  const Navigatorr({super.key});

  @override
  State<Navigatorr> createState() => _NavigatorrState();
}

class _NavigatorrState extends State<Navigatorr> {

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