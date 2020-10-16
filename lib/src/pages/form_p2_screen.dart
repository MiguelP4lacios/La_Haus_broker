import 'package:flutter/material.dart';
import 'form_p3_screen.dart';
/* import '../blocs/bloc_form_p2.dart'; */
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class FormP2Screen extends StatelessWidget {
  const FormP2Screen({Key key}) : super(key: key);

  _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.form(context);
    return Scaffold(
      appBar: AppBar(title: Text('La Haus Brokers')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              socialClass(bloc),
              state(bloc),
              elevator(bloc),
              /* commonArea(), */
              propertyTax(bloc),
              nextButton(bloc)
            ],
          ),
        ),
      ),
    );
  }

  Widget socialClass(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.socialClass,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Social class',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeScialClass,
          );
        });
  }

  Widget state(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.state,
        builder: (context, snapshot) {
          return DropdownButton(
            hint: Text("State"),
            value: snapshot.data,
            items: bloc.listUse.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(children: <Widget>[
                  Text(item),
                ]),
              );
            }).toList(),
            onChanged: bloc.changeState,
          );
        });
  }

  Widget elevator(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.elevator,
        builder: (context, snapshot) {
          return DropdownButton(
            hint: Text("Elevator"),
            value: snapshot.data,
            items: bloc.listElevator.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(children: <Widget>[
                  Text(item),
                ]),
              );
            }).toList(),
            onChanged: bloc.changeElevator,
          );
        });
  }

  Widget propertyTax(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.propertyTax,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Property Tax',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePropertyTax,
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP2Valid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Next'),
            onPressed: () {
              if (!snapshot.hasData) {
                return (null); // pop Error
              } else {
                return (_pushScreen(context, FormP3Screen()));
              }
            },
          );
        });
  }
}
