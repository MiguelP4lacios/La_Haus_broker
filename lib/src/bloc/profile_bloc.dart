import 'dart:async';

import 'package:login_bloc_pattern/src/bloc/profile_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc with ProfileValidators {
  final _firstNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _cityController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _idController = BehaviorSubject<String>();
  final _oldPasswordConfirmController = BehaviorSubject<String>();
  final _newPasswordController = BehaviorSubject<String>();
  final _newPasswordConfirmController = BehaviorSubject<String>();
  





  /* Retreive Stream Data */
  Stream<String> get firstNameStream =>
      _firstNameController.stream.transform(validateName);
  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validateName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get cityStream =>
      _cityController.stream.transform(validateName);
  Stream<String> get phoneStream =>
      _phoneController.stream.transform(validateNumber);
  Stream<String> get idStream =>
      _idController.stream.transform(validateNumber);
  Stream<String> get oldPasswordConfirmStream => _oldPasswordConfirmController.stream;
  Stream<String> get newPasswordStream => _newPasswordController.stream;
  Stream<String> get newPasswordConfirmStream => _newPasswordConfirmController.stream;




  /* Creation of a get to insert value to the
  streams Insert Values to the Stream */
  Function(String) get changeFirstName => _firstNameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeId => _idController.sink.add;
  Function(String) get changeOldPasswordConfirm =>
      _oldPasswordConfirmController.sink.add;
  Function(String) get changeNewPassword =>
      _newPasswordController.sink.add;
  Function(String) get changeNewPasswordConfirm =>
      _newPasswordConfirmController.sink.add;


  /* get the last value introduced into the streams */
  String get firstName => _firstNameController.value;
  String get lastName => _lastNameController.value;
  String get email => _emailController.value;
  String get city => _cityController.value;
  String get phone => _phoneController.value;
  String get id => _idController.value;
  String get oldPasswordConfirm => _oldPasswordConfirmController.value;
  String get newPassword => _newPasswordController.value;
  String get newPasswordConfirm => _newPasswordConfirmController.value;


  dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _emailController?.close();
    _cityController.close();
    _phoneController.close();
    _idController.close();
    _oldPasswordConfirmController.close();
    _newPasswordController.close();
    _newPasswordConfirmController.close();
  }
}
