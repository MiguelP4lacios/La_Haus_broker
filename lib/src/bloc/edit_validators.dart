import 'dart:async';

final validateErrors =
    StreamTransformer<dynamic, dynamic>.fromHandlers(handleData: (data, sink) {
  /* This validator receive a list as arguments
      
      The first one represent the attribute or property map representation key
      which need to be checked
      The last represent the new information for what the user want to change to
  */
  if ('Precio' == data[0]) {
    RegExp regExp = new RegExp(r'[\D]');
    if (!regExp.hasMatch(data[1])) {
      sink.add(data[1]);
    } else {
      sink.addError('Usa solo Números');
    }
  }
});
