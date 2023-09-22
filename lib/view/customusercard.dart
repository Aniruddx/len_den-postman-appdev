
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
        ),
        title: Text('username'),
        
        trailing: Text('timestamp'),
      ),
    );
  }
}