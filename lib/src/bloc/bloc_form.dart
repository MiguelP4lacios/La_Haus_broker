import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import '../models/apartment.dart';
import '../resources/property_provider.dart';
import '../pages/globals.dart' as globals;
import '../models/amenities.dart';

class FormBloc {
  //List DropDown
  List<String> listUse = ['Nuevo', 'Usado', 'Remodelado', 'Por remodelar'];
  List<String> listDecision = ['Si', 'No'];
  //Declare Streams
  // 1
  final _project = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _neighborhood = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _admon = BehaviorSubject<String>();
  final _buildArea = BehaviorSubject<String>();
  final _privateArea = BehaviorSubject<String>();
  // 2
  final _socialClass = BehaviorSubject<String>();
  final _state = BehaviorSubject<String>();
  final _floor = BehaviorSubject<String>();
  final _elevator = BehaviorSubject<String>();
  final _commonArea = BehaviorSubject<String>();
  final _propertyTax = BehaviorSubject<String>();
  // 3
  final _rooms = BehaviorSubject<String>();
  final _bathrooms = BehaviorSubject<String>();
  final _halfBathrooms = BehaviorSubject<String>();
  final _parkingLot = BehaviorSubject<String>();
  final _utilityRoom = BehaviorSubject<String>();
  // 4
  final _empty = BehaviorSubject<String>();
  final _inhabitants = BehaviorSubject<String>();
  final _rentDesition = BehaviorSubject<String>();
  final _rent = BehaviorSubject<String>();
  final _mortgage = BehaviorSubject<String>();

  /* final _idProperty = BehaviorSubject<dynamic>(); */

  // Checkbox Management - Item Model ID and checkbox value
  BehaviorSubject<Map<int, bool>> checkboxController =
      BehaviorSubject<Map<int, bool>>();
  Stream<Map<int, bool>> get mapModelCheckbox => checkboxController.stream;
  Function(Map<int, bool>) get setCheckbox => checkboxController.sink.add;

  //Get Data from Streams (out)
  // 1
  Stream<String> get project => _project.stream.transform(validateString);
  Stream<num> get price => _price.stream.transform(validateMoney);
  Stream<String> get neighborhood =>
      _neighborhood.stream.transform(validateString);
  Stream<String> get city => _city.stream.transform(validateString);
  Stream<String> get address => _address.stream.transform(validateString);
  Stream<num> get admon => _admon.stream.transform(validateMoney);
  Stream<num> get buildArea => _buildArea.stream.transform(validateNum);
  Stream<num> get privateArea => _privateArea.stream.transform(validateNum);
  // 2
  Stream<num> get socialClass => _socialClass.stream.transform(validateNum);
  Stream<String> get state => _state.stream.transform(validateDropDown);
  Stream<num> get floor => _floor.stream.transform(validateMoney);
  Stream<String> get elevator => _elevator.stream.transform(validateDropDown);
  Stream<String> get commonArea => _commonArea.stream.transform(validateString);
  Stream<num> get propertyTax => _propertyTax.stream.transform(validateMoney);
  // 3
  Stream<num> get rooms => _rooms.stream.transform(validateMoney);
  Stream<num> get bathrooms => _bathrooms.stream.transform(validateMoney);
  Stream<num> get halfBathrooms =>
      _halfBathrooms.stream.transform(validateMoney);
  Stream<num> get parkingLot => _parkingLot.stream.transform(validateMoney);
  Stream<String> get utilityRoom =>
      _utilityRoom.stream.transform(validateDropDown);
  // 4
  Stream<String> get empty => _empty.stream.transform(validateDropDown);
  Stream<String> get inhabitants =>
      _inhabitants.stream.transform(validateDropDown);
  Stream<String> get rentDesition =>
      _rentDesition.stream.transform(validateDropDown);
  Stream<num> get rent => _rent.stream.transform(validateMoney);
  Stream<String> get mortgage => _mortgage.stream.transform(validateDropDown);

  /* Stream<dynamic> get idStream => _idProperty.stream;

  dynamic get idProperty => _idProperty.value; */

  // Form validate
  // 1
  Stream<bool> get formP1Valid => Rx.combineLatest6(
      price,
      neighborhood,
      city,
      address,
      admon,
      buildArea,
      (
        price,
        neighborhood,
        city,
        adress,
        admon,
        buildArea,
      ) =>
          true);

  // 2
  Stream<bool> get formP2Valid => Rx.combineLatest5(
      socialClass,
      state,
      floor,
      elevator,
      propertyTax,
      (socialClass, state, floor, elevaror, propertyTax) => true);

  Stream<bool> get formP2ValidHouse => Rx.combineLatest3(socialClass, state,
      propertyTax, (socialClass, state, propertyTax) => true);

  // 3
  Stream<bool> get formP3Valid => Rx.combineLatest5(
      rooms,
      bathrooms,
      halfBathrooms,
      parkingLot,
      utilityRoom,
      (rooms, bathrooms, halfBathrooms, parkingLot, utilityRoom) => true);

  // 4
  Stream<bool> get formP4Valid => Rx.combineLatest3(
      inhabitants,
      rentDesition,
      mortgage,
      (
        inhabitants,
        rentDesition,
        mortgage,
      ) =>
          true);

  //Set Data (In)
  // 1
  Function(String) get changeProject => _project.sink.add;
  Function(String) get changePrice => _price.sink.add;
  Function(String) get changeNeighborhood => _neighborhood.sink.add;
  Function(String) get changeCity => _city.sink.add;
  Function(String) get changeAddress => _address.sink.add;
  Function(String) get changeAdmon => _admon.sink.add;
  Function(String) get changeBuildArea => _buildArea.sink.add;
  Function(String) get changePrivateArea => _privateArea.sink.add;

  // 2
  Function(String) get changeScialClass => _socialClass.sink.add;
  Function(String) get changeState => _state.sink.add;
  Function(String) get changeFloor => _floor.sink.add;
  Function(String) get changeElevator => _elevator.sink.add;
  Function(String) get changeCommonArea => _commonArea.sink.add;
  Function(String) get changePropertyTax => _propertyTax.sink.add;

  // 3
  Function(String) get changeRooms => _rooms.sink.add;
  Function(String) get changeBathrooms => _bathrooms.sink.add;
  Function(String) get changeHalfBathrooms => _halfBathrooms.sink.add;
  Function(String) get changeParkingLot => _parkingLot.sink.add;
  Function(String) get changeUtilityRoom => _utilityRoom.sink.add;

  // 4
  Function(String) get changeEmpty => _empty.sink.add;
  Function(String) get changeInhabitants => _inhabitants.sink.add;
  Function(String) get changeRentDesition => _rentDesition.sink.add;
  Function(String) get changeRent => _rent.sink.add;
  Function(String) get changeMortgage => _mortgage.sink.add;

  /* Function(dynamic) get changId => _idProperty.sink.add; */

  dispose() {
    // 1
    _project.close();
    _price.close();
    _neighborhood.close();
    _city.close();
    _address.close();
    _admon.close();
    _buildArea.close();
    _privateArea.close();
    // 2
    _socialClass.close();
    _state.close();
    _floor.close();
    _elevator.close();
    _commonArea.close();
    checkboxController.close();
    _propertyTax.close();
    // 3
    _rooms.close();
    _bathrooms.close();
    _halfBathrooms.close();
    _parkingLot.close();
    _utilityRoom.close();
    // 4
    _empty.close();
    _inhabitants.close();
    _rentDesition.close();
    _rent.close();
    _mortgage.close();

    /* _idProperty.close(); */
  }

  //Transformers

  final validateMoney =
      StreamTransformer<String, int>.fromHandlers(handleData: (event, sink) {
    try {
      if (event.contains('.')) {
        throw 'Whitout point, please';
      }
      RegExp regExp = new RegExp(r'([0-9])');
      if (regExp.hasMatch(event)) {
        sink.add(int.parse(event));
      } else {
        throw 'Value must be a number';
      }
    } catch (error) {
      if (error.toString().contains('FormatException:')) {
        sink.addError('Invalid number');
      } else {
        sink.addError(error);
      }
    }
    /* if (prise.contains('.')) {
      s'Whitout point, please';
    } */
  });

  final validateString =
      StreamTransformer<String, String>.fromHandlers(handleData: (event, sink) {
    if (event.length < 4) {
      sink.addError('Value must be at Least 4 characters');
    } else {
      sink.add(event);
    }
  });

  final validateNum =
      StreamTransformer<String, num>.fromHandlers(handleData: (event, sink) {
    try {
      RegExp regExp = new RegExp(r'([0-9])');
      if (regExp.hasMatch(event)) {
        sink.add(num.parse(event));
      } else {
        throw 'Value must be a number';
      }
    } catch (error) {
      if (error.toString().contains('FormatException:')) {
        sink.addError('Invalid number');
      } else {
        sink.addError(error);
      }
    }
  });

  final validateDropDown =
      StreamTransformer<String, String>.fromHandlers(handleData: (event, sink) {
    print(event.runtimeType);
    try {
      sink.add(event);
    } catch (error) {
      sink.addError(error);
    }
  });

  Item _item = Item();
  Map<int, bool> mapCheckbox = HashMap<int, bool>();
  Map<int, String> _mapAmenities = HashMap<int, String>();

  FormBloc() {
    // Initial data for list and map
    List<Item> _theAmenities = _item.getItems();
    for (var i = 0; i < _theAmenities.length; i++) {
      _mapAmenities[i] = _theAmenities[i].title;
      mapCheckbox[i] = false;
    }
    // Insert initial data in controller
    checkboxController.add(mapCheckbox);
    checkboxController.stream.listen(setCheckboxHandler);
  }

  setCheckboxHandler(Map<int, bool> newMapCheckbox) {
    // New checkbox value for the itemModel id
    int id = newMapCheckbox.entries.elementAt(0).key;
    bool check = newMapCheckbox.entries.elementAt(0).value;
    if (mapCheckbox.containsKey(id)) {
      mapCheckbox[id] = check;
    }

    /* print('-----------');
    print('newMapCheckbox: $newMapCheckbox');
    print('_mapCheckbox: $mapCheckbox');
    print('-----------');
    print(mapCheckbox.length); */

    /* print(a.toString());
    print(a.toString().runtimeType); */
  }

  //Functions
  Future<bool> submit() async {
    List<String> a = _item.getAm(mapCheckbox, _mapAmenities);
    final propertyProvider = PropertyProvider();
    final apartment = Apartment(
        project: _project.value.toString(),
        built_type: globals.propertyType.toString(),
        price: _price.value.toString(),
        hood: _neighborhood.value.toString(),
        city: _city.value.toString(),
        address: _address.value.toString(),
        admon: _admon.value.toString(),
        build_area: _buildArea.value.toString(),
        private_area: _privateArea.value.toString(),
        social_class: _socialClass.value.toString(),
        state: _state.value.toString(),
        apt: _floor.value.toString(),
        elevator: _elevator.value == 'Si' ? true.toString() : false.toString(),
        common_areas: a.toString(),/* _commonArea.value.toString(), */
        property_tax: _propertyTax.value.toString(),
        rooms: _rooms.value.toString(),
        bathrooms: _bathrooms.value.toString(),
        half_bathrooms: _halfBathrooms.value.toString(),
        parking_lot: _parkingLot.value.toString(),
        utility_room:
            _utilityRoom.value == 'Si' ? true.toString() : false.toString(),
        empty_property:
            _empty.value == 'Si' ? true.toString() : false.toString(),
        inhabitants:
            _inhabitants.value == 'Si' ? true.toString() : false.toString(),
        rent_desition:
            _rentDesition.value == 'Si' ? true.toString() : false.toString(),
        rent: _rent.value.toString(),
        mortgage: _mortgage.value == 'Si' ? true.toString() : false.toString());
    //print(apartment.toJson());
    Map info = await propertyProvider.newProperty(apartment.toJson());
    if (info['ok']) {
      /* changId(info['id']); */
      return true;
    } else {
      return false;
    }
  }
}
