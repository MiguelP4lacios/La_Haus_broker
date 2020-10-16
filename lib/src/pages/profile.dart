import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

// ignore: unused_element
class _PerfilState extends State<Perfil> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 10),
          Card(
            // Rectangulo superior
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(8.0),
            color: Color.fromRGBO(0, 208, 175, 1.0),
            child: ListTile(
              onTap: () {
                // function of profile
              },
              title: Text("Miguel Palacios",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              subtitle: Text('Medellin',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              leading: CircleAvatar(
                child: Text('MP',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800)),
                backgroundColor: Color.fromRGBO(255, 174, 0, 1.0),
              ),
              trailing: Icon(Icons.edit, color: Colors.white),
            ),
          ),
          // SizedBox(height: 40),
          Card(
            // Submenu central
            color: Colors.white,
            elevation: 4.0,
            margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.person,
                        color: Color.fromRGBO(0, 208, 175, 1.0)),
                    title: Text('Información personal'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pushNamed('personal');
                    }),
                _buildDivider(),
                ListTile(
                    leading: Icon(Icons.lock,
                        color: Color.fromRGBO(0, 208, 175, 1.0)),
                    title: Text('Seguridad'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pushNamed('security');
                    }),
                _buildDivider(),
                ListTile(
                    leading: Icon(Icons.settings,
                        color: Color.fromRGBO(0, 208, 175, 1.0)),
                    title: Text('Configuración'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pushNamed('settings');
                    }),
                _buildDivider(),
                ListTile(
                    leading: Icon(Icons.help,
                        color: Color.fromRGBO(0, 208, 175, 1.0)),
                    title: Text('Ayuda'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).pushNamed('help');
                    })
              ],
            ),
          ),
          // SizedBox(height: 20),
          RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 17.0),
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            onPressed: () {
              //
              Navigator.of(context).pushNamed('login');
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0.0,
            color: Color.fromRGBO(0, 208, 175, 1.0),
            textColor: Colors.white,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // menú inferior
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                '',
                style: TextStyle(fontSize: 0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              title: Text(
                '',
                style: TextStyle(fontSize: 0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                '',
                style: TextStyle(fontSize: 0),
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

Container _buildDivider() {
  // Raya divisoria entre opciones
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  );
}
