// import 'package:flutter/material.dart';
// import 'dart:js';

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// import 'package:login_bloc_pattern/src/models/apartment.dart';
import 'dart:convert';
// import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

class PhotoProvider {
  final _userPref = new UserPreferences();
  final String urlApi = "https://lahaus.herokuapp.com/api/v1/";

  // ***** David's code ******
  // Future<bool> sendPhoto(
  //     String propertyUrl, BuildContext context, dynamic propData) async {
  //   // final propData = ModalRoute.of(context).settings.arguments;
  //   final endpoint = Uri.parse(
  //       'https://lahaus.herokuapp.com/api/v1/users/13/properties/__________');
  //   final photoAcceptance = http.MultipartRequest('POST', endpoint);

  //   final imageAccept = http.MultipartFile.fromString('text', propertyUrl);

  //   photoAcceptance.files.add(imageAccept);

  //   final response = await photoAcceptance.send();
  //   final resp = await http.Response.fromStream(response);

  //   if (resp.statusCode != 200) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  Future sendPhoto(Future<String> urlPhoto, String propertyId) async {
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos";
    final response = await http.post(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    }, body: {
      'url': urlPhoto
    });
    Map<String, dynamic> decodedResp = json.decode(response.body);
    print(decodedResp);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }
  }

  // Future<List<Apartment>> loadProperty() async {
  //   final url = '/$_url/13/properties/13.json'; // from backend
  //   final resp = await http.get(url);

  //   final Map<String, dynamic> decodedData = json.decode(resp.body);
  //   final List<Apartment> properties = new List();

  //   if (decodedData == null) return [];

  //   decodedData.forEach((id, prop) {
  //     final propTemp = Apartment.fromJson(prop);
  //     properties.add(propTemp);
  //   });

  //   print(properties);

  //   return properties;
  // }

  Future<String> uploadPhoto(File image) async {
    // final img = FileImage(image).;
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dfne0hspy/image/upload/?upload_preset=wp889nbl');

    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('somth wrong');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData['secure_url']);

    return respData['secure_url'];
  }

  //pooling para recibir la información de la foto (GET)
  Future getInfoPhoto(String photoId, String propertyId) async {
    Future.delayed(Duration(seconds: 1));
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/$photoId";

    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    });
    Map<String, dynamic> decodedResp = json.decode(response.body);
    print(decodedResp);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }

// Debe de haber una animación de cargando mientras se hace el pooling
//  mientras la respuesta sea difernete a null haga la petición
  }
}

// enviar la foto a la API(POST)
// Future sendPhoto(String urlPhoto, String propertyId) async {
//   final url = "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos";
//   final response = await http.post(
//     url,
//     headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'},
//     body: {'url': urlPhoto}
//     );
//   Map<String, dynamic> decodedResp = json.decode(response.body);
//   print(decodedResp);
// //     if (decodedResp.containsKey('idToken')) {
// //       _userPref.token = decodedResp['idToken'];
// //       return {'ok': true};
// //     } else {
// //       return {'ok': false, 'message': decodedResp['error']['message']};
// //     }
// }
