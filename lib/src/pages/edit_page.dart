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
  _showAlertDialog will use the default keyboard */
  Map<String, TextInputType> specialKeyboards = {
    'Precio': TextInputType.phone,
  };
  @override
  Widget build(BuildContext context) {
    final propData = ModalRoute.of(context).settings.arguments;
    if (propData != null) {
      property = propData;
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
            SizedBox(width: MediaQuery.of(context).size.width * 0.09),
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
    if (property['img'] != null) {
      fields.add(FadeInImage(
        placeholder: AssetImage('assets/login/logo.png'),
        //TODO: create a place holder to use when the hosue images does not exists
        image: NetworkImage(property['img']),
      ));
      property.remove('img');
    }
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
                            : TextInputType.text,
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
              bloc.deleteProperty(property.id);
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
                bloc.saveProperty(property);
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
