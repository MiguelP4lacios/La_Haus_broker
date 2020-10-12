import 'dart:async';

class RegisterValidators {
  bool checkIdentical(String textField, String textConfirm) {
    if (textField == textConfirm) {
      return (true);
    } else {
      return (false);
    }
  }

  bool checkFieldsCompleted(a, b, c, d, e) {
    if (d == true && e == true) {
      return true;
    } else {
      return false;
    }
  }

  final validateNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
    RegExp regExp = new RegExp(r'[\D]');
    if (!regExp.hasMatch(number)) {
      sink.add(number);
    } else {
      sink.addError('Name must be contain letters');
    }
  });
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    RegExp regExp = new RegExp(r'[\d\s\W_]');
    if (!regExp.hasMatch(name)) {
      sink.add(name);
    } else {
      sink.addError('Name must be contain letters');
    }
  });
}
