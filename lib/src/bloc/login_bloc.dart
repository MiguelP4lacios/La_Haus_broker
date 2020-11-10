import 'dart:async';

import 'package:login_bloc_pattern/src/bloc/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  /* Retreive Stream Data */
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (email, pass) => true);
  /* Creation of a get to inser value to the
  streams Insert Values to the Stream */
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  /* get the last value introduced into the streams */
  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
