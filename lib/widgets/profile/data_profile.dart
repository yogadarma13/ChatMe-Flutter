import 'package:flutter/material.dart';

class DataProfile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String data;

  DataProfile(this.icon, this.label, this.data);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
        ),
        SizedBox(width: 24,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: TextStyle(fontWeight: FontWeight.bold),),
            Text(data)
          ],
        )
      ],
    );
  }
}
