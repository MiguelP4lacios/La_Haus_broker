import 'package:flutter/material.dart';

Widget laHausLogo() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/login/logoWhite.png', scale: 6.0),
        Container(
            margin: EdgeInsets.only(top: 16.0, left: 3.0),
            child: Text('La Haus',
                style: TextStyle(color: Colors.white, fontSize: 22)))
      ],
    ),
  );
}
