import 'dart:async';

class ProfileValidators {
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
  final validateEmail =
    StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Invalid Email');
    }
  });
}
