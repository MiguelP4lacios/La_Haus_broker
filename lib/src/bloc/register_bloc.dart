import 'package:login_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:login_bloc_pattern/src/bloc/register_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc extends LoginBloc with RegisterValidators {
  final _emailControllerConfirm = BehaviorSubject<String>();
  final _firstNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final _passwordConfirmController = BehaviorSubject<String>();
  final _indicativeController = BehaviorSubject<dynamic>();

  /* Streams Creation whit his validations */
  Stream<String> get emailConfirmStream => _emailControllerConfirm.stream;
  Stream<String> get passwordConfirmStream => _passwordConfirmController.stream;
  Stream<String> get firstNameStream =>
      _firstNameController.stream.transform(validateName);
  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validateName);
  Stream<String> get phoneNumberStream =>
      _phoneNumberController.stream.transform(validateNumber);
  Stream<dynamic> get indicativeStream => _indicativeController.stream;
  /* Stream combinations */
  Stream<bool> get confirmPasswordValid =>
      Rx.combineLatest2(passwordStream, passwordConfirmStream, checkIdentical);
  Stream<bool> get confirmEmailValid =>
      Rx.combineLatest2(emailStream, emailConfirmStream, checkIdentical);
  Stream<bool> get allFiledsCompleted => Rx.combineLatest5(
      firstNameStream,
      lastNameStream,
      phoneNumberStream,
      confirmPasswordValid,
      confirmEmailValid,
      checkFieldsCompleted);
  /* Creation of a get to inser value to the
  streams Insert Values to the Stream */
  Function(String) get changeEmailConfirm => _emailControllerConfirm.sink.add;
  Function(String) get changeFirstName => _firstNameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;
  Function(String) get changePasswordConfirm =>
      _passwordConfirmController.sink.add;
  Function(dynamic) get changeIndicative => _indicativeController.sink.add;
  /* get the last value introduced into the streams */
  String get emailConfirm => _emailControllerConfirm.value;
  String get firstName => _firstNameController.value;
  String get lastName => _lastNameController.value;
  String get phoneNumber => _phoneNumberController.value;
  String get passwordConfirm => _passwordConfirmController.value;
  String get indicative => _indicativeController.value;
  /* close the stream where necessary */
  dispose() {
    _emailControllerConfirm?.close();
    _firstNameController.close();
    _lastNameController.close();
    _phoneNumberController.close();
    _passwordConfirmController.close();
    _indicativeController.close();
  }
}
