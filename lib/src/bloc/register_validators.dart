import 'dart:async';

class RegisterValidators {
  /* Register Bloc Validators */

  bool checkIdentical(String textField, String textConfirm) {
    /* Check if two streams are flowing identical information */
    if (textField == textConfirm) {
      return (true);
    } else {
      return (false);
    }
  }

  bool checkFieldsCompleted(a, b, c, d, e) {
    /* Check that all the streams have been completely fill
    it is used to prevent to send incomplete information to the backend */
    if (d == true && e == true) {
      return true;
    } else {
      return false;
    }
  }

  final validateNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
    RegExp regExp = new RegExp(r'[\D]');
    if (number.length != 10) {
      sink.addError('Debe contener 10 dígitos');
    } else if (!regExp.hasMatch(number)) {
      sink.add(number);
    } else {
      sink.addError('Solo los número son permitidos');
    }
  });
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    RegExp regExp = new RegExp(r'[\d\s\W_]');
    if (!regExp.hasMatch(name)) {
      sink.add(name);
    } else {
      sink.addError('No use espacios o signos');
    }
  });
}
