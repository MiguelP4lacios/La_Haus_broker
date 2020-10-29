import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Configuración',
            style: TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(103, 103, 103, 1.0),
                fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: sizeScreen.width * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                    color: Colors.white,
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(children: [
                      ListTile(
                          leading: Icon(Icons.language,
                              color: Color.fromRGBO(0, 208, 175, 1.0)),
                          title: Text('Cambiar Lenguaje'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _showDialog("Selecciona el lenguaje", "EN\nES");
                          }),
                      _buildDivider(),
                      ListTile(
                          leading: Icon(Icons.location_on,
                              color: Color.fromRGBO(0, 208, 175, 1.0)),
                          title: Text('Cambiar Ubicación'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            _showDialog("Ubicación", "GPS");
                          }),
                    ])),
                Text(
                  'Notificaciones',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 208, 175, 1.0)),
                ),
                SwitchListTile(
                  activeColor: Color.fromRGBO(127, 255, 223, 1.0),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text('Recibir notificaciones'),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color.fromRGBO(127, 255, 223, 1.0),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text('Noticias al correo'),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color.fromRGBO(127, 255, 223, 1.0),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text('Recibir promociones'),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color.fromRGBO(127, 255, 223, 1.0),
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text('Actualizaciones de la App'),
                  onChanged: (val) {},
                )
              ],
            ),
          ),
        ));
  }

  _showDialog(String title, String text) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: new Text(title),
              content: new Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text("Entendido"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
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
}
