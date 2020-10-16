import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class FormP4Screen extends StatelessWidget {
  const FormP4Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.form(context);
    return Scaffold(
      appBar: AppBar(title: Text('La Haus Brokers - Form')),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            empty(bloc),
            rent(bloc),
            /*  admon(),
            builArea(),
            privateArea(),*/
            nextButton(bloc)
          ],
        ),
      ),
    );
  }

  Widget empty(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.empty,
        builder: (context, snapshot) {
          return DropdownButton(
            hint: Text("Empy"),
            value: snapshot.data,
            items: bloc.listEmpty.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(children: <Widget>[
                  Text(item),
                ]),
              );
            }).toList(),
            onChanged: bloc.changeEmpty,
          );
        });
  }

  Widget rent(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.rent,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Rent',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeRent,
          );
        });
  }

  /* Widget admon() {
    return TextField(
      decoration: InputDecoration(labelText: 'Administration'),
    );
  }

  Widget builArea() {
    return TextField(
      decoration: InputDecoration(labelText: 'Build area'),
    );
  }

  Widget privateArea() {
    return TextField(
      decoration: InputDecoration(labelText: 'Private area'),
    );
  }
 */
  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP4Valid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Finish'),
            onPressed: !snapshot.hasData ? null : bloc.submit,
            splashColor: Color(0xFF56b473),
          );
        });
  }
}
