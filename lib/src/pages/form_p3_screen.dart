import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
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
              rooms(bloc),
              bathrooms(bloc),
              halfBathrooms(bloc),
              parkingLot(bloc),
              utilityRoom(bloc),
              nextButton(bloc)
            ],
          ),
        ),
      ),
    );
  }

  Widget rooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.rooms,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Rooms',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeRooms,
          );
        });
  }

  Widget bathrooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.bathrooms,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Bathrooms',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeBathrooms,
          );
        });
  }

  Widget halfBathrooms(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.halfBathrooms,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Half Bathrooms',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeHalfBathrooms,
          );
        });
  }

  Widget parkingLot(FormBloc bloc) {
    return StreamBuilder<num>(
        stream: bloc.parkingLot,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Parking lot',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeParkingLot,
          );
        });
  }

  Widget utilityRoom(FormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.utilityRoom,
        builder: (context, snapshot) {
          return DropdownButton(
            hint: Text("Utility rooms"),
            value: snapshot.data,
            items: bloc.listUtilies.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(children: <Widget>[
                  Text(item),
                ]),
              );
            }).toList(),
            onChanged: bloc.changeUtilityRoom,
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
    return TextField(!snapshot.hasData ? null : bloc.submitP2,
 */
  Widget nextButton(FormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formP3Valid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Next'),
            onPressed:() {
              if (!snapshot.hasData) {
                return (null); // pop Error
              } else {
                return (_pushScreen(context, FormP4Screen()));
              }
            },
          );
        });
  }
}
