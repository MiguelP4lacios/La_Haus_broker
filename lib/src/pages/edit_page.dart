import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/edit_bloc.dart';
import 'package:login_bloc_pattern/src/widgets/app_bar.dart';
import 'package:login_bloc_pattern/src/widgets/custom_dialog.dart';

class EditPage extends StatefulWidget {
  EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  /* This page is used to edit the attributes of the property
  selected in the home page */
  dynamic property;
  /* specialKeyboards are used to tell the _showAlertDialog function
  what kind of TextInput needs to use, each key of the variable represent 
  a key inside the property map representation, when any keyboard is found
  _showAlertDialog will use the phone type */
  Map<String, TextInputType> specialKeyboards = {
    'Barrio': TextInputType.text,
    'Dirección': TextInputType.text,
  };
  /* toggle button states */
  List<bool> inhabitants = [true, false];
  List<bool> empty = [true, false];
  List<bool> utilityRoom = [true, false];
  List<bool> state = [true, false];

  @override
  Widget build(BuildContext context) {
    final propData = ModalRoute.of(context).settings.arguments;
    if (propData != null) {
      property = propData;
      inhabitants[0] = property.inhabitants;
      inhabitants[1] = !property.inhabitants;
      empty[0] = property.empty;
      empty[1] = !property.empty;
      utilityRoom[0] = property.utilityRoom;
      utilityRoom[1] = !property.utilityRoom;
      state[0] = property.state == 'Nuevo' ? true : false;
      state[1] = !state[0];
    }
    final bloc = BlocProvider.edit(context);
    bloc.changeProperty(property);
    bloc.getMapProperty();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
              onTap: () => Navigator.pushReplacementNamed(context, 'home'),
            ),
            laHausLogo(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: bloc.editStream,
        builder: (context, snapshot) =>
            ListView(children: _propertyFileds(snapshot.data, bloc)),
      ),
    );
  }

  _propertyFileds(Map<String, dynamic> property, EditBloc bloc) {
    /* this functions is used to create all the body of th application
    which is achieve retreiving a list containing all the necesary widgets
    flutter will use to show the information to the user 
    
    The image handler might be added at the begining of the fields list and the
    buttons delete and store were added once the list have created the property
    attribute fields. All you want to display in the app body needs to be added
    at fields

    bloc.editStream is in charge to send a map representation of the house the
    user have selected and a forEach run through the map creating each attribute 
    */
    /* TODO: Images Handler */
    List<Widget> fields = [];
    if (property == null) {
      return fields;
    }
    fields.add(_isInhabitants(context));
    fields.add(_isEmpty(context));
    fields.add(_hasUtilityRoom(context));
    fields.add(_state(context));
    property.remove('Inhabitado');
    property.remove('Vacío');
    property.remove('Cuarto Util');
    // TODO: cambiar el éstado del inmueble
    property.remove('Estado');
    property.remove('Hipoteca');
    property.remove('Areas Comunes');
    /* CREATING THE PROPERTY ATTRIBUTES */
    property.forEach((key, value) {
      Widget tile = ListTile(
        title: Text(key),
        subtitle: Text(value.toString()),
        trailing: FlatButton(
          onPressed: () {
            return _showAlertDialog(context, bloc, key);
          },
          child: Icon(Icons.edit, color: Color.fromRGBO(0, 208, 174, 1.0)),
        ),
      );
      fields..add(tile)..add(Divider());
    });
    /* ADDING SAVE AND DELETE BUTTONS */
    fields.add(_propertyButtons(context, bloc));

    return fields;
  }

  /* toggle buttons must be here */

  Widget _state(BuildContext context) {
    /* used to create a toggle button to ask for boolean values of the property
    */
    double widthScreen = MediaQuery.of(context).size.width;
    return ListTile(
      title: Center(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          borderColor: Colors.grey[300],
          color: Color.fromRGBO(0, 208, 174, 1.0),
          selectedColor: Colors.white,
          fillColor: Color.fromRGBO(0, 208, 174, 1.0),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Nuevo')),
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Usado')),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < state.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  state[buttonIndex] = true;
                } else {
                  state[buttonIndex] = false;
                }
                property.state = state[0] == true ? 'Nuevo' : 'Usado';
              }
            });
          },
          isSelected: state,
        ),
      ),
    );
  }

  Widget _hasUtilityRoom(BuildContext context) {
    /* used to create a toggle button to ask for boolean values of the property
    */
    double widthScreen = MediaQuery.of(context).size.width;
    return ListTile(
      title: Center(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          borderColor: Colors.grey[300],
          color: Color.fromRGBO(0, 208, 174, 1.0),
          selectedColor: Colors.white,
          fillColor: Color.fromRGBO(0, 208, 174, 1.0),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Cuartos Utiles')),
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('No cuartos útiles')),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < utilityRoom.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  utilityRoom[buttonIndex] = false;
                } else {
                  utilityRoom[buttonIndex] = true;
                }
                property.utilityRoom = utilityRoom[1];
              }
            });
          },
          isSelected: utilityRoom,
        ),
      ),
    );
  }

  Widget _isEmpty(BuildContext context) {
    /* used to create a toggle button to ask for boolean values of the property
    */
    double widthScreen = MediaQuery.of(context).size.width;
    return ListTile(
      title: Center(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          borderColor: Colors.grey[300],
          color: Color.fromRGBO(0, 208, 174, 1.0),
          selectedColor: Colors.white,
          fillColor: Color.fromRGBO(0, 208, 174, 1.0),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Vacía')),
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Amoblada')),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < empty.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  empty[buttonIndex] = false;
                } else {
                  empty[buttonIndex] = true;
                }
                property.empty = empty[1];
              }
            });
          },
          isSelected: empty,
        ),
      ),
    );
  }

  Widget _isInhabitants(BuildContext context) {
    /* used to create a toggle button to ask for boolean values of the property
    */
    double widthScreen = MediaQuery.of(context).size.width;
    return ListTile(
      title: Center(
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(20),
          borderColor: Colors.grey[300],
          color: Color.fromRGBO(0, 208, 174, 1.0),
          selectedColor: Colors.white,
          fillColor: Color.fromRGBO(0, 208, 174, 1.0),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('Habitada')),
            Container(
                alignment: Alignment.center,
                height: 60,
                width: widthScreen * 0.39,
                child: Text('No habitada')),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < inhabitants.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  inhabitants[buttonIndex] = false;
                } else {
                  inhabitants[buttonIndex] = true;
                }
                property.inhabitants = inhabitants[1];
              }
            });
          },
          isSelected: inhabitants,
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, EditBloc bloc, String key) {
    /* This is a function in charge of editing the attributes of the property
    in each iterartion of the _property fields it receive a key which represent
    one attribute of the property
    
    Once the user type in something the app check's the input errors and if
    there are the error a corresponding is reley streamed through bloc.error
    which is used to show an user alert

    The most important part of the functions comes in TextField where the
    text that user has write is transmited through a bloc and at the same time
    is checked. The conditions to check each attributes are decribed in the
    edit_validator file
    */
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bloc.changeError(['Restore Stream']);
        bloc.changeText('');
        return StreamBuilder(
            stream: bloc.errorStream,
            builder: (context, snapshot) {
              return CustomAlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: specialKeyboards[key] != null
                            ? specialKeyboards[key]
                            : TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: key,
                          labelText: key,
                          errorText: snapshot.error,
                        ),
                        onChanged: (value) {
                          bloc.changeError([key, value]);
                          return bloc.changeText(value);
                        },
                      ),
                      FlatButton(
                          onPressed:
                              snapshot.hasError == true || bloc.text.length < 1
                                  ? null
                                  : () {
                                      Navigator.of(context).pop();
                                      return bloc.changeAttr(
                                          key, bloc.text.toString());
                                    },
                          child: Text('Ok')),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  _propertyButtons(BuildContext context, EditBloc bloc) {
    /* The buttons related with the behavoir of this view */
    final homeBloc = BlocProvider.home(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          child: FloatingActionButton.extended(
            heroTag: null,
            elevation: 0,
            icon: Icon(Icons.delete),
            label: Text('Eliminar'),
            backgroundColor: Color.fromRGBO(0, 208, 174, 1.0),
            onPressed: () {
              homeBloc.deleteProperty(property.id);
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 20),
            child: FloatingActionButton.extended(
              heroTag: null,
              elevation: 0,
              icon: Icon(Icons.mode_edit),
              label: Text('Guardar'),
              backgroundColor: Color.fromRGBO(0, 208, 174, 1.0),
              onPressed: () {
                homeBloc.saveProperty(property);
                Navigator.pushReplacementNamed(context, 'home');
              },
            )),
      ],
    );
  }

  disose() {
    super.dispose();
  }
}
