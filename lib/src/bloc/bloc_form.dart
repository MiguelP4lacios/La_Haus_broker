import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/insert_property_aparment.dart';

class FormBloc {
  //List DropDown
  List<String> listUse = ['Nuevo', 'Usado'];
  List<String> listDecision = ['Si', 'No'];
  //Declare Streams
  // 1
  final _price = BehaviorSubject<String>();
  final _neighborhood = BehaviorSubject<String>();
  final _adress = BehaviorSubject<String>();
  final _admon = BehaviorSubject<String>();
  final _buildArea = BehaviorSubject<String>();
  final _privateArea = BehaviorSubject<String>();
  // 2
  final _socialClass = BehaviorSubject<String>();
  final _state = BehaviorSubject<String>();
  final _floor = BehaviorSubject<String>();
  final _elevator = BehaviorSubject<String>();
  //final _commonArea = BehaviorSubject<String>();
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
  final _rent = BehaviorSubject<String>();
  final _mortgage = BehaviorSubject<String>();

  /*final _admon = BehaviorSubject<String>();
  final _builArea = BehaviorSubject<String>();
  final _privateArea = BehaviorSubject<String>();*/

  //Get Data from Streams (out)
  // 1
  Stream<num> get price => _price.stream.transform(validateMoney);
  Stream<String> get neighborhood =>
      _neighborhood.stream.transform(validateString);
  Stream<String> get adress => _adress.stream.transform(validateString);
  Stream<num> get admon => _admon.stream.transform(validateMoney);
  Stream<num> get buildArea => _buildArea.stream.transform(validateNum);
  Stream<num> get privateArea => _privateArea.stream.transform(validateNum);
  // 2
  Stream<num> get socialClass => _socialClass.stream.transform(validateNum);
  Stream<String> get state => _state.stream.transform(validateDropDown);
  Stream<num> get floor => _floor.stream.transform(validateMoney);
  Stream<String> get elevator => _elevator.stream.transform(validateDropDown);
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
  Stream<num> get rent => _rent.stream.transform(validateMoney);
  Stream<num> get mortgage => _mortgage.stream.transform(validateMoney);

  // Form validate
  // 1
  Stream<bool> get formP1Valid => Rx.combineLatest6(
      price,
      neighborhood,
      adress,
      admon,
      buildArea,
      privateArea,
      (
        price,
        neighborhood,
        adress,
        admon,
        buildArea,
        privateArea,
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
  Stream<bool> get formP4Valid => Rx.combineLatest4(
      empty,
      inhabitants,
      rent,
      mortgage,
      (
        empty,
        inhabitants,
        rent,
        mortgage,
      ) =>
          true);

  //Set Data (In)
  // 1
  Function(String) get changePrice => _price.sink.add;
  Function(String) get changeNeighborhood => _neighborhood.sink.add;
  Function(String) get changeAdress => _adress.sink.add;
  Function(String) get changeAdmon => _admon.sink.add;
  Function(String) get changeBuildArea => _buildArea.sink.add;
  Function(String) get changePrivateArea => _privateArea.sink.add;

  // 2
  Function(String) get changeScialClass => _socialClass.sink.add;
  Function(String) get changeState => _state.sink.add;
  Function(String) get changeFloor => _floor.sink.add;
  Function(String) get changeElevator => _elevator.sink.add;
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
  Function(String) get changeRent => _rent.sink.add;
  Function(String) get changeMortgage => _mortgage.sink.add;

  dispose() {
    // 1
    _price.close();
    _neighborhood.close();
    _adress.close();
    _admon.close();
    _buildArea.close();
    _privateArea.close();
    // 2
    _socialClass.close();
    _state.close();
    _floor.close();
    _elevator.close();
    // _commonArea.close();
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
    _rent.close();
    _mortgage.close();
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

  //Functions
  submit() {
    final aparmet = InsertPropertyAparmnet(
        price: _price.value.toString(),
        neighborhood: _neighborhood.value.toString(),
        adress: _adress.value.toString(),
        admon: _admon.value.toString(),
        buildArea: _buildArea.value.toString(),
        privateArea: _privateArea.value.toString(),
        socialClass: _socialClass.value.toString(),
        state: _state.value.toString(),
        floor: _floor.value.toString(),
        elevator: _elevator.value == 'Si' ? true.toString() : false.toString(),
        propertyTax: _propertyTax.value.toString(),
        rooms: _rooms.value.toString(),
        bathrooms: _bathrooms.value.toString(),
        halfBathrooms: _halfBathrooms.value.toString(),
        parkingLot: _parkingLot.value.toString(),
        utilityRoom:
            _utilityRoom.value == 'Si' ? true.toString() : false.toString(),
        empty: _empty.value == 'Si' ? true.toString() : false.toString(),
        inhabitants:
            _inhabitants.value == 'Si' ? true.toString() : false.toString(),
        rent: _rent.value.toString(),
        mortgage: _mortgage.value.toString());
    //print('${_price.value}\n${_neighborhood.value}\n${_adress.value}\n${_admon.value}\n${_buildArea.value}\n${_privateArea.value}');
    //print(${_socialClass.value}\n${_state.value}\n${_floor.value}\n${_elevator.value}\n${_propertyTax.value}');
    //print('${_rooms.value}\n${_bathrooms.value}\n${_halfBathrooms.value}\n${_parkingLot.value}\n${_utilityRoom.value}');
    //print('${_empty.value == 'Yes' ? true.toString() : false.toString()}\n${_rent.value}');
    print(aparmet.toJson());
  }
}