// import 'package:flutter/material.dart';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/models/apartment.dart';
import 'dart:convert';
// import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

class PhotoProvider {
  final _userPref = new UserPreferences();
  // final String _url = 'https://lahaus.herokuapp.com/api/v1/users/13';
  // final _url = 'https://lahaus.herokuapp.com/api/v1/users';

  // final endpointAnal = 'https://lahaus.heroku.com';

  Future<bool> sendPhoto(
      String propertyUrl, BuildContext context, dynamic propData) async {
    // final propData = ModalRoute.of(context).settings.arguments;
    final endpoint = Uri.parse(
        'https://lahaus.herokuapp.com/api/v1/users/${_userPref.userId}/properties/${propData}');

    final photoAcceptance = http.MultipartRequest('POST', endpoint);

    final imageAccept = http.MultipartFile.fromString('text', propertyUrl);

    photoAcceptance.files.add(imageAccept);

    final response = await photoAcceptance.send();
    final resp = await http.Response.fromStream(response);

    if (resp.statusCode != 200) {
      return false;
    } else {
      return true;
    }
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

  Future<String> uploadPhoto(PickedFile image) async {
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
    print(respData);

    return respData['secure_url'];
  }
}
