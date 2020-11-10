import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ayuda',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(103, 103, 103, 1.0),
              fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[_helpMenu(context)],
      ),
    );
  }

  Widget _helpMenu(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: sizeScreen.width * 0.90,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SafeArea(
                  child: Container(
                height: sizeScreen.height * 0.10,
              )),
              Card(
                  color: Colors.white,
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(children: [
                    ListTile(
                        leading: Icon(Icons.filter,
                            color: Color.fromRGBO(0, 208, 175, 1.0)),
                        title: Text('Cómo publicar'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          _showDialog("Cómo Publicar?", "Lorem Ipsum");
                        }),
                    _buildDivider(),
                    ListTile(
                        leading: Icon(Icons.payment,
                            color: Color.fromRGBO(0, 208, 175, 1.0)),
                        title: Text('Pagos y tarifas'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          _showDialog("Pagos y Tarifas", "Lorem Ipsum");
                        }),
                    _buildDivider(),
                    ListTile(
                        leading: Icon(Icons.home,
                            color: Color.fromRGBO(0, 208, 175, 1.0)),
                        title: Text('Acerca de La Haus'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          _showDialog("Acerca de la App", "Lorem Ipsum");
                        }),
                    _buildDivider(),
                    ListTile(
                        leading: Icon(Icons.add_box,
                            color: Color.fromRGBO(0, 208, 175, 1.0)),
                        title: Text('Seguridad y accesibilidad'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          _showDialog(
                              "Seguridad y Accesibilidad", "Lorem Ipsum");
                        }),
                    _buildDivider(),
                    ListTile(
                        leading: Icon(Icons.vpn_key,
                            color: Color.fromRGBO(0, 208, 175, 1.0)),
                        title: Text('Términos y politicas'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          _showDialog("Términos y Politicas", "Lorem Ipsum");
                        }),
                  ])),
              SizedBox(height: sizeScreen.height * 0.1),
              RaisedButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: Text(
                    'Contáctenos',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                onPressed: () {
                  //
                  showAlertDialogContact(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 0.0,
                color: Color.fromRGBO(0, 208, 175, 1.0),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
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

  showAlertDialogContact(BuildContext context) {
    // set up the button
    Widget sendButton = RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        child: Text(
          'Enviar',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      color: Color.fromRGBO(0, 208, 175, 1.0),
      textColor: Colors.white,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Contáctenos"),
      content: TextField(
        autofocus: true,
        decoration: new InputDecoration(labelText: 'Déjanos tu mensaje'),
      ),
      actions: [
        sendButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
