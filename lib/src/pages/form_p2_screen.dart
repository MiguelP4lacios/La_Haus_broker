import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/widgets/app_bar.dart';
import 'form_p3_screen.dart';
/* import '../blocs/bloc_form_p2.dart'; */
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/widgets/show_alert.dart';
import 'globals.dart' as globals;

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
    _switchWidget() {
      List<Widget> formAparment = [
        cardForm(Icons.group, socialClass(bloc)),
        cardForm(Icons.star, state(bloc)),
        cardForm(null, floor(bloc)),
        cardForm(Icons.swap_vertical_circle, elevator(bloc)),
        cardForm(null, commonArea(bloc)),
        cardForm(null, propertyTax(bloc)),
        nextButton(bloc)
      ];

      List<Widget> formHouse = [
        cardForm(Icons.group, socialClass(bloc)),
        cardForm(null, state(bloc)),
        cardForm(null, commonArea(bloc)),
        cardForm(null, propertyTax(bloc)),
        nextButton(bloc)
      ];
      if (globals.propertyType == "Apartamento") {
        return formAparment;
      } else {
        return formHouse;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          // Botones superiores (puede ser un appbar)
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Color.fromRGBO(103, 103, 103, 1.0),
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            laHausLogo(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.13),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: _switchWidget(),
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
                color: Color.fromRGBO(0, 208, 174, 1.0),
              ),
              title: item)),
    );
  }

  Widget socialClass(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.socialClass,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Estrato *',
                  hintText: '2',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeScialClass,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget state(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.state,
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Text(
                  'Estado del inmueble *',
                ),
              ),
              DropdownButton(
                hint: Text("Select item"),
                value: snapshot.data,
                isExpanded: true,
                items: bloc.listUse.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Row(children: <Widget>[
                      Text(item),
                    ]),
                  );
                }).toList(),
                onChanged: bloc.changeState,
              ),
              //Container(height: 15.0),
            ],
          );
        });
  }

  Widget floor(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.floor,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Piso/Apartamento *',
                  hintText: '3',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeFloor,
              ),
              SizedBox(height: 15.0),
            ],
          );
        });
  }

  Widget elevator(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.elevator,
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Text(
                  'Ascensor ?*',
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
                onChanged: bloc.changeElevator,
              ),
              //Container(height: 15.0),
            ],
          );
        });
  }

  Widget commonArea(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.commonArea,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Areas comunes *',
                  hintText: 'Acomun 1, Acomun 2, ...',
                  hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeCommonArea,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget propertyTax(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.propertyTax,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Impuesto predial *',
                  prefixText: '\$  ',
                  hintText: '1000000',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changePropertyTax,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    _switchWidgetBloc() {
      if (globals.propertyType == "Apartamento") {
        return bloc.formP2Valid;
      } else {
        return bloc.formP2ValidHouse;
      }
    }

    return StreamBuilder<bool>(
        stream: _switchWidgetBloc(),
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
                  return (_pushScreen(context, FormP3Screen()));
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
