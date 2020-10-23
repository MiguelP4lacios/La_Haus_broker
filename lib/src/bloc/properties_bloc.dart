/* properties bloc is used to manage the Home Page logic */
import 'package:login_bloc_pattern/src/resources/property_resource.dart';
import 'package:rxdart/rxdart.dart';

class PropertiesBloc {
  PropertiesBloc() {
    /* this constructor is used to ask the server for properties each time
    an instance is made */
    // getProperties();
    changeConnection(false);
  }
  final _propertyController = BehaviorSubject<List<dynamic>>();
  final _connectionController = BehaviorSubject<bool>();
  /* Retreive Stream Data */
  Stream<List<dynamic>> get propertiesStream => _propertyController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  /* Creation of a get to inser value to the
  streams Insert Values to the Stream */
  Function(List<dynamic>) get changeProperties => _propertyController.sink.add;
  Function(bool) get changeConnection => _connectionController.sink.add;
  /* get the last value introduced into the streams */
  List<dynamic> get properties => _propertyController.value;
  bool get connection => _connectionController.value;

  getProperties() async {
    /* Get all the properties */
    // this.changeProperties([]);
    this.changeProperties(await loadProperties());
  }

  saveProperty(dynamic property) async {
    /* call a resource function in charge to change the property attributes
    from the db 
    The proprty instance is necessary to work with*/
    List<dynamic> properties = this.properties;
    for (int i = 0; i < properties.length; i++) {
      if (properties[i].id == property.id) {
        properties[i] = property;
        await editProperty(property);
        break;
      }
    }
    this.changeProperties(properties);
  }

  deleteProperty(String id) async {
    /* Delete a property */
    List<dynamic> properties = this.properties;
    int i = 0;
    await deleteProp(id);

    for (i = 0; i < properties.length; i++) {
      if (properties[i].id == id) {
        properties.removeAt(i);
        break;
      }
    }
    this.changeProperties(properties);
  }

  dispose() {
    _propertyController.close();
    _connectionController.close();
  }
}
