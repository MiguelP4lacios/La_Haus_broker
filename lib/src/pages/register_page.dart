import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/register_bloc.dart';
import 'package:login_bloc_pattern/src/resources/user_resource.dart';
import 'package:login_bloc_pattern/src/widgets/show_alert.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;

  final icon;
}

class RegisterPage extends StatelessWidget {
  final buttonColor = Color.fromRGBO(0, 208, 174, 1.0);
  final userProvider = new UserProvider();
  final _indicatives = [
    Item(
      '+57',
      Image.asset(
        'icons/flags/png/co.png',
        package: 'country_icons',
        scale: 5,
      ),
    ),
    Item(
      '+52',
      Image.asset(
        'icons/flags/png/mx.png',
        package: 'country_icons',
        scale: 5,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    final bloc = BlocProvider.register(context);
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
                Text('Create Account'),
                SizedBox(height: 30.0),
                _createFirstName(bloc),
                SizedBox(height: 10.0),
                _createLastName(bloc),
                SizedBox(height: 10.0),
                _createPhoneNumber(context, bloc),
                SizedBox(height: 10.0),
                _createEmail(bloc),
                SizedBox(height: 10.0),
                _createConfirmEmail(bloc),
                SizedBox(height: 10.0),
                _createPassword(bloc),
                SizedBox(height: 10.0),
                _createConfirmPassword(bloc),
                SizedBox(height: 40.0),
                _createButton(bloc),
              ],
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
            child: Text('Do you have an account? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
    );
  }

  Widget _createConfirmPassword(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.confirmPasswordValid,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: buttonColor),
              labelText: 'Confirm Password',
              errorText: snapshot.data == null || snapshot.data == true
                  ? null
                  : 'Passwords must be identicals',
            ),
            onChanged: (value) => bloc.changePasswordConfirm(value),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<String>> getIndicatives() {
    List<DropdownMenuItem<String>> newList = new List();
    _indicatives.forEach((indicative) {
      newList.add(DropdownMenuItem(
        child: Row(
          children: [
            indicative.icon,
            SizedBox(width: 5),
            Text(indicative.name),
          ],
        ),
        value: indicative.name,
      ));
    });

    return newList;
  }

  Widget _phoneField(BuildContext context, RegisterBloc bloc, double width) {
    return StreamBuilder(
      stream: bloc.phoneNumberStream,
      builder: (context, snapshot) {
        return Container(
          width: width * 0.48,
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: buttonColor),
              labelText: 'Phone Number',
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changePhoneNumber(value),
          ),
        );
      },
    );
  }

  Widget _indicativeDropDown(RegisterBloc bloc, double width) {
    return StreamBuilder(
      stream: bloc.indicativeStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(left: 18),
          width: width * 0.215,
          child: DropdownButton(
            value: snapshot.data == null
                ? bloc.changeIndicative(_indicatives[0].name)
                : snapshot.data,
            isExpanded: true,
            items: getIndicatives(),
            onChanged: (ind) {
              bloc.changeIndicative(ind);
            },
          ),
        );
      },
    );
  }

  Widget _createPhoneNumber(BuildContext context, RegisterBloc bloc) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen,
      child: Row(
        children: <Widget>[
          _indicativeDropDown(bloc, widthScreen),
          _phoneField(context, bloc, widthScreen),
        ],
      ),
    );
  }

  Widget _createLastName(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.lastNameStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.perm_identity, color: buttonColor),
              labelText: 'Last Name',
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeLastName(value),
          ),
        );
      },
    );
  }

  Widget _createFirstName(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.firstNameStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.perm_identity, color: buttonColor),
              labelText: 'First Name',
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changeFirstName(value),
          ),
        );
      },
    );
  }

  Widget _createButton(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.allFiledsCompleted,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 17.0),
              child: Text(
                'Create',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            onPressed:
                snapshot.data == true ? () => _register(bloc, context) : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0.0,
            color: buttonColor,
            textColor: Colors.white,
          );
        });
  }

  _register(RegisterBloc bloc, BuildContext context) async {
    Map<String, dynamic> registerData = {
      'first_name': bloc.firstName,
      'last_name': bloc.lastName,
      'phone_number': '(' + bloc.indicative + ')' + bloc.phoneNumber,
      'email': bloc.email,
      'password': bloc.password,
    };
    Map info = await userProvider.newUser(registerData);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, 'Email already exists');
    }
  }

  Widget _createPassword(RegisterBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open, color: buttonColor),
              labelText: 'Password',
              errorText: snapshot.error,
            ),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _createConfirmEmail(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.confirmEmailValid,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: buttonColor),
                hintText: 'Example@email.com',
                labelText: 'Confirm Email',
                errorText: snapshot.data == null || snapshot.data == true
                    ? null
                    : 'Email must be identicals',
              ),
              onChanged: (value) => bloc.changeEmailConfirm(value),
            ),
          );
        });
  }

  Widget _createEmail(RegisterBloc bloc) {
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
                labelText: 'Email',
                errorText: snapshot.error,
              ),
              onChanged: (value) => bloc.changeEmail(value),
            ),
          );
        });
  }

  Widget _createBackground(BuildContext context) {
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
