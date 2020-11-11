import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

 // General view of profile section
class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _userPref = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            // Rectangulo superior
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(8.0),
            color: Color.fromRGBO(0, 208, 175, 1.0),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('personal');
              },
              title: Text(_userPref.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              subtitle: Text('Medellin',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              leading: CircleAvatar(
                child: Text(
                    _userPref.name[0],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800)),
                backgroundColor: Color.fromRGBO(255, 174, 0, 1.0),
              ),
              trailing: Icon(Icons.edit, color: Colors.white),
            ),
          ),
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
          RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            onPressed: () {
              _userPref.token = "";
              _userPref.userId = "";
              Navigator.of(context).pushNamedAndRemoveUntil(
          'login', (Route<dynamic> route) => false);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0.0,
            color: Color.fromRGBO(0, 208, 175, 1.0),
            textColor: Colors.white,
          ),
        ],
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
