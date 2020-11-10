import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/pages/home_page.dart';
import 'package:login_bloc_pattern/src/pages/new_property.dart';
import 'package:login_bloc_pattern/src/pages/profile.dart';
import 'package:login_bloc_pattern/src/widgets/app_bar.dart';

/// This is the stateful widget that the main application instantiates.
class BottomBar extends StatefulWidget {
  BottomBar({Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

/// This is the private State class that goes with BottomBar.
class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = 
  [
    HomePage(),
    PropertyPage(),
    Perfil(),    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: laHausLogo(),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // menú inferior
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/folder.png'),
                  fit: BoxFit.cover),
                width: 30,
                height: 30,
              ),
              title: Text(
                'Propiedades',
                style: TextStyle(fontSize: 14),
              )),
          BottomNavigationBarItem(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/add.png'),
                  fit: BoxFit.cover),
                width: 30,
                height: 30,
              ),
              title: Text(
                'Agregar',
                style: TextStyle(fontSize: 14),
              )),
          BottomNavigationBarItem(
              icon: Container(
                child: Image(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.cover),
                width: 30,
                height: 30,
              ),
              title: Text(
                'Perfil',
                style: TextStyle(fontSize: 14),
              )),
        ],
        backgroundColor: Colors.white,
        iconSize: 40.0,
        selectedItemColor: Color.fromRGBO(0, 208, 175, 1.0),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
