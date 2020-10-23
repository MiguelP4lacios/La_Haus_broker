import 'package:login_bloc_pattern/src/bloc/edit_validators.dart';
import 'package:login_bloc_pattern/src/resources/property_resource.dart';
import 'package:rxdart/rxdart.dart';

class EditBloc {
  /* bloc controllers */
  final _editController = BehaviorSubject<Map<String, dynamic>>();
  final _propertyController = BehaviorSubject<dynamic>();
  final _textController = BehaviorSubject<String>();
  final _errorController = BehaviorSubject<dynamic>();

  /* Retreive Stream Data */
  Stream<Map<String, dynamic>> get editStream => _editController.stream;
  Stream<dynamic> get propertyStream => _propertyController.stream;
  Stream<String> get textStream => _textController.stream;
  Stream<dynamic> get errorStream =>
      _errorController.stream.transform(validateErrors);

  /* Creation of a get to inser value to the
  streams Insert Values to the Stream */
  Function(Map<String, dynamic>) get changeEdit => _editController.sink.add;
  Function(dynamic) get changeProperty => _propertyController.sink.add;
  Function(String) get changeText => _textController.sink.add;
  Function(dynamic) get changeError => _errorController.sink.add;

  /* get the last value introduced into the streams */
  Map<String, dynamic> get edit => _editController.value;
  dynamic get property => _propertyController.value;
  dynamic get text => _textController.value;
  dynamic get error => _errorController.value;

  /* Functions to work with the information which flows throught the models */
  getMapProperty() {
    /* this function is used to send a map representation of the property which
    is in streaming currently to the edit_page since all the property attribute 
    views are created based on a Map */
    if (property != null) {
      changeEdit(property.toMap());
    }
  }

  changeAttr(String key, dynamic value) {
    /* Change the state of the property model once time the user type a letter
   into the text field input*/

    dynamic prop = property;
    prop.changeAttr(key, value);
    changeProperty(prop);
    changeEdit(prop.toMap());
  }

  dispose() {
    _editController.close();
    _propertyController.close();
    _textController.close();
    _errorController.close();
  }
}
