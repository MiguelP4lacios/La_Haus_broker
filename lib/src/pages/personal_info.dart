import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: GestureDetector(
      //     child: IconButton(
      //       iconSize: 50.0,
      //       color: Color.fromRGBO(103, 103, 103, 100),
      //       icon: new Icon(Icons.keyboard_arrow_left),
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('profile');
      //       },
      //     ),
      //   ),
      //   title: const Text('Información personal'),
      // ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            // Botones superiores (puede ser un appbar)
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 50.0,
                color: Color.fromRGBO(103, 103, 103, 100),
                icon: new Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              Text(
                'Información personal',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(103, 103, 103, 100),
                    fontWeight: FontWeight.w400),
              ), // fontFamily: 'Raleway',
            ],
          ),
          SizedBox(height: 100), // espacio
        ],
      ),
    );
  }
}
