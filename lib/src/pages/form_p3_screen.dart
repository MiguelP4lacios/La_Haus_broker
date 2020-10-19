import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/widgets/show_alert.dart';
import 'form_p4_screen.dart';

class FormP3Screen extends StatelessWidget {
  const FormP3Screen({Key key}) : super(key: key);

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
              cardForm(Icons.room, rooms(bloc)),
              cardForm(null, bathrooms(bloc)),
              cardForm(null, halfBathrooms(bloc)),
              cardForm(Icons.local_parking, parkingLot(bloc)),
              cardForm(null, utilityRoom(bloc)),
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

  Widget rooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.rooms,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Habitaciones',
                  hintText: '3',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeRooms,
              ),
              Container(
                height: 15.0,
              )
            ],
          );
        });
  }

  Widget bathrooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.bathrooms,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Baños',
                  hintText: '2',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeBathrooms,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget halfBathrooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.halfBathrooms,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Medios Baños',
                  hintText: '1',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeHalfBathrooms,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget parkingLot(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.parkingLot,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Estacionamientos',
                  hintText: '0',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFD9D9D9),
                  ),
                  errorText: snapshot.error,
                ),
                onChanged: bloc.changeParkingLot,
              ),
              SizedBox(height: 15.0)
            ],
          );
        });
  }

  Widget utilityRoom(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.utilityRoom,
        builder: (context, snapshot) {
          return Column(
            children: [
              Center(
                child: Text(
                  'Cuartos utiles',
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
                onChanged: bloc.changeUtilityRoom,
              ),
              //Container(height: 15.0),
            ],
          );
        });
  }

  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP3Valid,
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
                  return (_pushScreen(context, FormP4Screen()));
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
