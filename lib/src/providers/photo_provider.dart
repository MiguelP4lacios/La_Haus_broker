import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';
import 'package:login_bloc_pattern/src/models/photo_model.dart';

class PhotoProvider {
  final Photo photoModel = Photo();
  final _userPref = new UserPreferences();
  final String urlApi = "https://lahaus.herokuapp.com/api/v1/";

  Future<String> sendPhoto(
      String urlPhoto, String propertyId, String propertyPlace) async {
    print(propertyId + 'property id');
    print(urlPhoto + ' url test');
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos";
    final response = await http.post(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    }, body: {
      'url': urlPhoto,
      'location': propertyPlace,
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('somth wrong');
      print(response.body);
      return null;
    }
    Map<String, dynamic> decodedResp = json.decode(response.body);
    print('photoId');
    print(decodedResp['photos']['id']);

    return decodedResp['photos']['id'].toString();

    // if (decodedResp.containsKey('idToken')) {
    //   _userPref.token = decodedResp['idToken'];
    //   return {'ok': true};
    // } else {
    //   return {'ok': false, 'message': decodedResp['error']['message']};
    // }
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
  Future<Map> getInfoPhoto(String photoId, String propertyId) async {
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/$photoId";
    Map acceptance = {"foco": null, "ilum": null, "url": null};
    while (acceptance['foco'] == null && acceptance['ilum'] == null) {
      Future.delayed(Duration(seconds: 1));
      final response = await http.get(url, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${_userPref.token}'
      });
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('somth wrong');
        print(response.body);
        return null;
      }
      Map<String, dynamic> decodedResp = json.decode(response.body);
      acceptance['foco'] = decodedResp['photos']['accepted_foc'];
      acceptance['ilum'] = decodedResp['photos']['accepted_lum'];
      acceptance['url'] = decodedResp['photos']['url'];
    }
    return acceptance;
  }

  Future getAllPhotos(String propertyId) async {
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/";

    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('somth wrong');
      print(response.body);
      return null;
    }
    final photos = json.decode(response.body)['photos'];
    print(photos);
    for (var item in photos) {
      if (item['location'] != null) {
        photoModel.agregar(
            item['location'], item['url'], item['id'].toString());
      }
    }
    return;
  }

  // print(acceptance);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }

// Debe de haber una animación de cargando mientras se hace el pooling
//  mientras la respuesta sea difernete a null haga la petición
  Future deletePhoto(String photoId, String propertyId) async {
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/$photoId";
    final response = await http.delete(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('somth wrong');
      print(response.body);
      return null;
    }
    return;
  }
}
