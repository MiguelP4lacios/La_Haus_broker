import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/profile_bloc.dart';
import 'package:login_bloc_pattern/src/resources/profile_resource.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Seguridad',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(103, 103, 103, 1.0),
              fontWeight: FontWeight.bold
              ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _personalInfo(context), // Contenido central
        ],
      ),
    );
  }




  Widget _personalInfo(BuildContext context) {
    final bloc = BlocProvider.profile(context); // ESTO HAY QUE CAMBIARLO ???
    final sizeScreen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: sizeScreen.width * 0.80,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _oldPassword(bloc),
                  SizedBox(height: 10),
                  _newPassword(bloc),
                  SizedBox(height: 10),
                  _confirmPassword(bloc)
                ],
              ),
            ),
            SizedBox(height: 30.0),
            RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0),
                child: Text(
                  'Guardar Cambios',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              onPressed: () {
                // hacer put para guardar la información nueva
                Navigator.of(context).pushNamed('profile');
              },
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0.0,
              color: Color.fromRGBO(0, 208, 175, 1.0),
              textColor: Colors.white,
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0),
                child: Text(
                  'Eliminar Usuario',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              onPressed: () {
                // lógica para sobreescribir y guardar la información 
                deleteUser();
                Navigator.of(context).pushNamed('login');
              },
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0.0,
              color: Color.fromRGBO(0, 208, 175, 1.0),
              textColor: Colors.white,
            ),
            SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }




  Widget _oldPassword(ProfileBloc bloc) {
    return StreamBuilder(
      stream: bloc.firstNameStream,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            decoration: InputDecoration(
              // icon: Icon(Icons.perm_identity, color: buttonColor),
              labelText: 'Contraseña vieja',
              hintText: '******', // Aquí se va a leer los datos previos
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeFirstName(value),
          ),
        );
      },
    );
  }

  Widget _newPassword(ProfileBloc bloc) {
    return StreamBuilder(
      stream: bloc.firstNameStream,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            decoration: InputDecoration(
              // icon: Icon(Icons.perm_identity, color: buttonColor),
              labelText: 'Nueva contraseña',
              hintText: '*******', // Aquí se va a leer los datos previos
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeFirstName(value),
          ),
        );
      },
    );
  }

  Widget _confirmPassword(ProfileBloc bloc) {
    return StreamBuilder(
      stream: bloc.firstNameStream,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            decoration: InputDecoration(
              // icon: Icon(Icons.perm_identity, color: buttonColor),
              labelText: 'confirmar contraseña',
              hintText: '*******', // Aquí se va a leer los datos previos
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeFirstName(value),
          ),
        );
      },
    );
  }

}
