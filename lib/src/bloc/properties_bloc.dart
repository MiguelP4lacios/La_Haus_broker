/* properties bloc is used to manage the Home Page logic */
import 'package:login_bloc_pattern/src/resources/property_resource.dart';
import 'package:rxdart/rxdart.dart';

class PropertiesBloc {
  PropertiesBloc() {
    /* this constructor is used to ask the server for properties each time
    an instance is made */
    getProperties();
  }
  final _propertyController = BehaviorSubject<List<dynamic>>();
  /* Retreive Stream Data */
  Stream<List<dynamic>> get propertiesStream => _propertyController.stream;
  /* Creation of a get to inser value to the
  streams Insert Values to the Stream */
  Function(List<dynamic>) get changeProperties => _propertyController.sink.add;
  /* get the last value introduced into the streams */
  List<dynamic> get properties => _propertyController.value;

  getProperties() async {
    /* Get all the properties */
    this.changeProperties(await loadProperties());
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
  }
}
