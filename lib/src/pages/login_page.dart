import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:login_bloc_pattern/src/resources/user_resource.dart';
import 'package:login_bloc_pattern/src/widgets/show_alert.dart';

class LoginPage extends StatelessWidget {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    /* This is the shell in which text fields will take place */
    final bloc = BlocProvider.login(context);
    final sizeScreen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: sizeScreen.height * 0.30,
          )),
          Container(
            width: sizeScreen.width * 0.80,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Text('Autenticación'),
                SizedBox(height: 30.0),
                _createEmail(bloc),
                SizedBox(height: 30),
                _createPassword(bloc),
                SizedBox(height: 30),
                _createButton(bloc),
              ],
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
            child: Text('Crear nuevo usuario'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
          ),
        ],
      ),
    );
  }

  Widget _createButton(LoginBloc bloc) {
    /* This button is used to get into the application */
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 17.0),
              child: Text(
                'Ingresar',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0.0,
            color: buttonColor,
            textColor: Colors.white,
          );
        });
  }

  _login(LoginBloc bloc, BuildContext context) async {
    /* This function is executed once the user have pressed the "ingresar" 
    button, this button make an HTTP request to the server with the user
    information requesting to let it in, if the HTTP response is OK,
    the user will be get into the Home page; other way, an error massage
    will be shown to the user depending on the imposibility to get access */
    Map info = await userProvider.login(bloc.email, bloc.password);
    print(info);
    if (info['ok']) {
      bloc.changeEmail('');
      bloc.changePassword('');
      Navigator.of(context).pushNamedAndRemoveUntil(
          'bottomBar', (Route<dynamic> route) => false);
      // Navigator.pushReplacementNamed(context, 'bottomBar');
    } else if (info['massage'] == "La sesión ha expirado") {
      showAlert(context, '',
          'No se puede establecer conexión, intentelo nuevamente en unos minutos');
    } else {
      showAlert(context, '', 'Correo o Contraseña incorrectos');
    }
    // Navigator.pushNamed(context, 'home');
  }

  Widget _createPassword(LoginBloc bloc) {
    /* Password Text Field */
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: buttonColor),
              labelText: 'Contraseña',
              errorText: snapshot.error != null && snapshot.error == "no error"
                  ? null
                  : snapshot.error,
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    /* Email Text Field */
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: buttonColor),
                hintText: 'Example@email.com',
                labelText: 'Correo',
                errorText:
                    snapshot.error != null && snapshot.error == "no error"
                        ? null
                        : snapshot.error,
              ),
              onChanged: (value) => bloc.changeEmail(value),
            ),
          );
        });
  }

  Widget _createBackground(BuildContext context) {
    /* It is in charge to beutify the login background */
    final heightScreen = MediaQuery.of(context).size.height;
    final backGroundPurple = Container(
      height: heightScreen,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(0, 208, 174, 1.0),
        Color.fromRGBO(126, 255, 222, 1.0),
      ])),
    );
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    );

    return Stack(
      children: <Widget>[
        backGroundPurple,
        Positioned(child: circle, top: 90.0, left: 50.0),
        Positioned(child: circle, top: -30.0, right: -30.0),
        Positioned(child: circle, top: 250, left: -40),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/login/logoWhite.png'))),
              ),
              SizedBox(
                height: 30.0,
                width: double.infinity,
              ),
              Text('LaHaus',
                  style: TextStyle(color: Colors.white, fontSize: 25.0)),
            ],
          ),
        ),
      ],
    );
  }
}
