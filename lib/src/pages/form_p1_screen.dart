import 'package:flutter/material.dart';
import 'form_p2_screen.dart';
/* import '../blocs/bloc_form_p1.dart';*/
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/widgets/show_alert.dart';

/* import '../blocs/bloc_form_p1.dart';*/
//import './widget/form_widgets.dart';

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
              cardForm(Icons.attach_money, price(bloc)),
              cardForm(Icons.location_city, neighborhood(bloc)),
              cardForm(Icons.place, adress(bloc)),
              cardForm(Icons.build, admon(bloc)),
              cardForm(Icons.adjust, buildArea(bloc)),
              cardForm(Icons.lock, privateArea(bloc)),
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

  Widget price(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.price,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  prefixText: '\$  ',
                  hintText: '1000000',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changePrice,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget neighborhood(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.neighborhood,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Barrio',
                  hintText: 'La Romana',
                  hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeNeighborhood,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget adress(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.adress,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeAdress,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget admon(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.admon,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Administración',
                  prefixText: '\$  ',
                  hintText: '1000000',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeAdmon,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget buildArea(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.buildArea,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Área construida',
                  suffixText: 'km²',
                  hintText: '48.6',
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeBuildArea,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget privateArea(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.privateArea,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Área privada',
                  suffixText: 'km²',
                  hintText: '58.4',
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changePrivateArea,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP1Valid,
        builder: (context, snapshot) {
          return RaisedButton(
              child: Center(
                child: Text(
                  'Siguiente',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onPressed: () {
                if (!snapshot.hasData) {
                  showAlert(context, 'Campos obligatorios vácios',
                      'Para continuar, llene los campos.'); // pop Error
                } else {
                  return (_pushScreen(context, FormP2Screen()));
                }
              },
              /* !snapshot.hasData ? null : _pushScreen(context, FormP2Screen()) */
              splashColor: Color(0xFF56b473),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Color(0xFF00DDB3));
        });
  }
}
