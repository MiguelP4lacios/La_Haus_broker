/* Necessary login validations before the information
could be send */
import 'dart:async';

class LoginValidators {
  /* Login Bloc Stream validations

    In the validations, "no error" massage tells to the view that dont need to 
    display an error this massage is used when the type something and that is
    deleted. In this cases the stream ends flowing an empty string, so this
    massage no error is sent to prevent the "ingresar" button will be activated 
    and no one error message will be showed
    */

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else if (password.length == 0) {
      sink.addError("no error");
    } else {
      sink.addError('Contraseña debe ser mayor a 6 letras');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else if (email.length == 0) {
      sink.addError("no error");
    } else {
      sink.addError('Correo invalido');
    }
  });
}
