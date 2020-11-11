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
    //Sends the photo to back-end to be analyzed
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
      return null;
    }
    Map<String, dynamic> decodedResp = json.decode(response.body);

    return decodedResp['photos']['id'].toString();
  }

  Future<String> uploadPhoto(File image) async {
    // uploads the photo taken to the cloud (storage)
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

  Future<Map> getInfoPhoto(String photoId, String propertyId) async {
    //pooling to receive the information of the photo (GET)
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
    // request to back-end the pictures from a specific property and store them in a list
    final url =
        "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/";

    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${_userPref.token}'
    });
    if (response.statusCode != 200 && response.statusCode != 201) {
      return null;
    }
    final photos = json.decode(response.body)['photos'];
    for (var item in photos) {
      if (item['location'] != null) {
        photoModel.agregar(item['location'], item['url'], item['id'].toString(),
            item['accepted_foc'], item['accepted_lum']);
      }
    }
    return;
  }

// Debe de haber una animación de cargando mientras se hace el pooling
//  mientras la respuesta sea difernete a null haga la petición
  Future deletePhoto(String photoId, String propertyId) async {
    // it deletes the photo from the list to be rendered
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
