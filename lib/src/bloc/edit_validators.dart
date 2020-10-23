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
    if (data[1].length >= 7) {
      sink.add(data[1]);
    } else {
      sink.addError('Precio debe ser superior a 6 dígitos');
    }
  } else if ("Barrio" == data[0] || "Dirección" == data[0]) {
    RegExp regExp = new RegExp(r'[\d\s\W]');
    if (!regExp.hasMatch(data[1])) {
      sink.add(data[1]);
    } else {
      sink.addError('Solo letras son permitidas');
    }
  } else if ("Baños" == data[0] ||
      "Habitaciones" == data[0] ||
      "Medios Baños" == data[0] ||
      "Parqueaderos" == data[0]) {
    RegExp regExp = new RegExp(r'[\D]');
    if (data[1].length <= 2 && !regExp.hasMatch(data[1])) {
      sink.add(data[1]);
    } else {
      sink.addError('Solo números de dos dígitos');
    }
  } else if ("Administracion" == data[0] || "Renta" == data[0]) {
    RegExp regExp = new RegExp(r'[\D]');
    if (data[1].length <= 8 && !regExp.hasMatch(data[1])) {
      sink.add(data[1]);
    } else {
      sink.addError('Solo 8 dígitos máximo');
    }
  } else if ("Area Privada" == data[0] || "Area Construida" == data[0]) {
    RegExp regExp = new RegExp(r'[\D,]+[^.]+[\D]');
    if (data[1].length <= 8 && !regExp.hasMatch(data[1])) {
      sink.add(data[1]);
    } else {
      sink.addError('Use números únicamente');
    }
  } else if ("Estrato" == data[0]) {
    RegExp regExp = new RegExp(r'[\D]');
    if (data[1].length <= 8 &&
        !regExp.hasMatch(data[1]) &&
        data[1] > 0 &&
        data[1] < 7) {
      sink.add(data[1]);
    } else {
      sink.addError('Número entre 1 y 6');
    }
  }
});
