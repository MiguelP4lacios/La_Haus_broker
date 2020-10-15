import 'package:flutter/material.dart';
import 'form_p2_screen.dart';
/* import '../blocs/bloc_form_p1.dart';*/
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class FormP1Screen extends StatelessWidget {
  const FormP1Screen({Key key}) : super(key: key);

  _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.form(context);
    return Scaffold(
      appBar: AppBar(title: Text('La Haus Brokers - Form')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              price(bloc),
              adress(bloc),
              admon(bloc),
              buildArea(bloc),
              privateArea(bloc),
              nextButton(bloc)
            ],
          ),
        ),
      ),
    );
  }

  Widget price(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.price,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePrice,
          );
        });
  }

  Widget adress(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.adress,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              labelText: 'Adress',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeAdress,
          );
        });
  }

  Widget admon(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.admon,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Administration',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeAdmon,
          );
        });
  }

  Widget buildArea(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.buildArea,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Build Area',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeBuildArea,
          );
        });
  }

  Widget privateArea(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.privateArea,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Private Area',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePrivateArea,
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP1Valid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Next'),
            onPressed: () {
              if (!snapshot.hasData) {
                return (null); // pop Error
              } else {
                return (_pushScreen(context, FormP2Screen()));
              }
            },
            focusColor: Colors.amber
            /* !snapshot.hasData ? null : _pushScreen(context, FormP2Screen()) */,
            splashColor: Color(0xFF56b473),
          );
        });
  }
}
