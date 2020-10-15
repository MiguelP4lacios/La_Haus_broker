import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FormBloc {

  //List DropDown
  List<String> listUse = ['New', 'Used'];
  List<String> listElevator = ['Yes', 'No'];
  List<String> listUtilies = ['Yes', 'No'];
  List<String> listEmpty = ['Yes', 'No'];
  //Declare Streams
  // 1
  final _price = BehaviorSubject<String>();
  final _adress = BehaviorSubject<String>();
  final _admon = BehaviorSubject<String>();
  final _buildArea = BehaviorSubject<String>();
  final _privateArea = BehaviorSubject<String>();
  // 2
  final _socialClass = BehaviorSubject<String>();
  final _state = BehaviorSubject<String>();
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
  final _rent = BehaviorSubject<String>();
  /*final _admon = BehaviorSubject<String>();
  final _builArea = BehaviorSubject<String>();
  final _privateArea = BehaviorSubject<String>();*/

  //Get Data from Streams (out)
  // 1
  Stream<num> get price => _price.stream.transform(validateNum);
  Stream<String> get adress => _adress.stream.transform(validateAdress);
  Stream<num> get admon => _admon.stream.transform(validateNum);
  Stream<num> get buildArea => _buildArea.stream.transform(validateNum);
  Stream<num> get privateArea => _privateArea.stream.transform(validateNum);
  // 2
  Stream<num> get socialClass => _socialClass.stream.transform(validateNum);
  Stream<String> get state => _state.stream.transform(validateDropDown);
  Stream<String> get elevator => _elevator.stream.transform(validateDropDown);
  Stream<num> get propertyTax => _propertyTax.stream.transform(validateNum);
  // 3
  Stream<num> get rooms => _rooms.stream.transform(validateNum);
  Stream<num> get bathrooms => _bathrooms.stream.transform(validateNum);
  Stream<num> get halfBathrooms => _halfBathrooms.stream.transform(validateNum);
  Stream<num> get parkingLot => _parkingLot.stream.transform(validateNum);
  Stream<String> get utilityRoom => _utilityRoom.stream.transform(validateDropDown);
  // 4
  Stream<String> get empty => _empty.stream.transform(validateDropDown);
  Stream<num> get rent => _rent.stream.transform(validateNum);

  // Form validate
  // 1
  Stream<bool> get formP1Valid => Rx.combineLatest5(
      price,
      adress,
      admon,
      buildArea,
      privateArea,
      (
        price,
        adress,
        admon,
        buildArea,
        privateArea,
      ) =>
          true);

  // 2
  Stream<bool> get formP2Valid => Rx.combineLatest4(
      socialClass,
      state,
      elevator,
      propertyTax,
      (socialClass, state, elevaror, propertyTax) => true);

  // 3
  Stream<bool> get formP3Valid => Rx.combineLatest5(
      rooms,
      bathrooms,
      halfBathrooms,
      parkingLot,
      utilityRoom,
      (rooms, bathrooms, halfBathrooms, parkingLot, utilityRoom) => true);

  // 4
  Stream<bool> get formP4Valid =>
      Rx.combineLatest2(empty, rent, (empty, rent) => true);


  //Set Data (In)
  // 1
  Function(String) get changePrice => _price.sink.add;
  Function(String) get changeAdress => _adress.sink.add;
  Function(String) get changeAdmon => _admon.sink.add;
  Function(String) get changeBuildArea => _buildArea.sink.add;
  Function(String) get changePrivateArea => _privateArea.sink.add;

  // 2
  Function(String) get changeScialClass => _socialClass.sink.add;
  Function(String) get changeState => _state.sink.add;
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
  Function(String) get changeRent => _rent.sink.add;

  dispose() {
    // 1
    _price.close();
    _adress.close();
    _admon.close();
    _buildArea.close();
    _privateArea.close();
    // 2
    _socialClass.close();
    _state.close();
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
    _rent.close();
  }

  //Transformers
  final validateAdress = StreamTransformer<String, String>.fromHandlers(
      handleData: (adress, sink) {
    if (adress.length < 4) {
      sink.addError('Adress must be at Least 4 characters');
    } else {
      sink.add(adress);
    }
  });

  final validateNum =
      StreamTransformer<String, num>.fromHandlers(handleData: (event, sink) {
    try {
      sink.add(num.parse(event));
    } catch (error) {
      sink.addError('Value must be a number');
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
    print(
        '${_price.value}\n${_adress.value}\n${_admon.value}\n${_buildArea.value}\n${_privateArea.value}');
    print(
        '${_socialClass.value}\n${_state.value}\n${_elevator.value}\n${_propertyTax.value}');
    print(
        '${_rooms.value}\n${_bathrooms.value}\n${_halfBathrooms.value}\n${_parkingLot.value}\n${_utilityRoom.value}');
    print(
        '${_empty.value == 'Yes' ? true.toString() : false.toString()}\n${_rent.value}');
  }
}
