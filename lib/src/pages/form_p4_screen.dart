import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class FormP4Screen extends StatelessWidget {
  const FormP4Screen({Key key}) : super(key: key);

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
              cardForm(null, empty(bloc)),
              cardForm(null, inhabitants(bloc)),
              cardForm(null, rent(bloc)),
              cardForm(null, mortgage(bloc)),
              nextButton(bloc)
            ],
          ),
        ),
      ),
    );
  }

  cardForm(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(
          child: ListTile(
              leading: Icon(
                icon,
                size: 40.0,
                color: Color(0xFF003027),
              ),
              title: item)),
    );
  }

  Widget empty(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.empty,
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Text(
                  'Vácio ?',
                ),
              ),
              DropdownButton(
                hint: Text("Select item"),
                value: snapshot.data,
                isExpanded: true,
                items: bloc.listDecision.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(children: <Widget>[
                      Text(item),
                    ]),
                  );
                }).toList(),
                onChanged: bloc.changeEmpty,
              ),
            ],
          );
        });
  }

  Widget inhabitants(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.inhabitants,
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Text(
                  'Ocupado',
                ),
              ),
              DropdownButton(
                hint: Text("Select item"),
                value: snapshot.data,
                isExpanded: true,
                items: bloc.listDecision.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(children: <Widget>[
                      Text(item),
                    ]),
                  );
                }).toList(),
                onChanged: bloc.changeInhabitants,
              ),
            ],
          );
        });
  }

  Widget rent(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.rent,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Arrendamiento',
                  prefixText: '\$  ',
                  hintText: '1000000',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeRent,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget mortgage(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.mortgage,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Hipoteca',
                  prefixText: '\$  ',
                  hintText: '1000000',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeMortgage,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP4Valid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Center(
              child: Text(
                'Finalizar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: !snapshot.hasData ? null : bloc.submit,
            splashColor: Color(0xFF56b473),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Color(0xFF00DDB3),
          );
        });
  }
}
