import 'package:flutter/material.dart';


class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);
  
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ayuda',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(103, 103, 103, 1.0),
              fontWeight: FontWeight.bold
              ),
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
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.filter,
                          color: Color.fromRGBO(0, 208, 175, 1.0)),
                      title: Text('Cómo publicar'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).pushNamed('personal');
                      }),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.payment,
                          color: Color.fromRGBO(0, 208, 175, 1.0)),
                      title: Text('Pagos y tarifas'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).pushNamed('security');
                      }),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.home,
                          color: Color.fromRGBO(0, 208, 175, 1.0)),
                      title: Text('Acerca de La Haus'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).pushNamed('security');
                      }),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.add_box,
                          color: Color.fromRGBO(0, 208, 175, 1.0)),
                      title: Text('Seguridad y accesibilidad'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).pushNamed('security');
                      }),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(Icons.vpn_key,
                          color: Color.fromRGBO(0, 208, 175, 1.0)),
                      title: Text('Términos y politicas'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).pushNamed('security');
                      }),
                  ]
                )
              ),
              RaisedButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Contáctenos',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                onPressed: () {
                  // lógica para conseguir datos de contacto 
                  Navigator.of(context).pushNamed('profile');
                },
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0.0,
                color: Color.fromRGBO(0, 208, 175, 1.0),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
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
