/* This file is used for edit_page to make http petitions */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';


// class ProfileProvider {
//   final _userPref = new UserPreferences();
//   final String urlApi = "https://lahaus.herokuapp.com/api/v1/";


//   // función para recibir información personal y de segudirad(GET)
//   Future<Map<String, dynamic>> load(String email, String password) async {
//     final authData = {
//       'email': email,
//       'password': password,
//       'returnSecureToken': true,
//     };
//     final resp = await http.get(
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${_userPref.token}',
//     );
//     Map<String, dynamic> decodedResp = json.decode(resp.body);
//     print(decodedResp);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }
//   }

//   // función para enviar información personal y de seguridad (PUT)
//   Future<Map<String, dynamic>> save(String email, String password) async {
//     final authData = {
//       'email': email,
//       'password': password,
//       'returnSecureToken': true,
//     };
//     final resp = await http.put(
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${_userPref.token}',
//       body: json.encode(authData),
//     );
//     Map<String, dynamic> decodedResp = json.decode(resp.body);
//     print(decodedResp);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }
//   }

//   // Delete user
// }



  final _userPref = new UserPreferences();
  final String urlApi = "https://lahaus.herokuapp.com/api/v1/";
  
  // Función para eliminar el usuario  (DELETE)
  Future deleteUser() async {
    Future.delayed(Duration(seconds: 2));
    final url = "$urlApi/users/${_userPref.userId}";
    await http.delete(
      url,
      headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'}
      );
  }

  // Función para traer la contraseña vieja (GET)
  Future getPass() async {
    Future.delayed(Duration(seconds: 2));
    final url = "$urlApi/users/${_userPref.userId}";
    await http.get(
      url,
      headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'}
      );
  }

  //función para modificar la contraseña nueva (PUT)
  Future changePass() async {
    Future.delayed(Duration(seconds: 2));
    final url = "$urlApi/users/${_userPref.userId}";
    await http.put(
      url,
      headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'},
      body: {'password': ''}
      );
  }


  // Otra forma de hacer un delete user

  // Future<Response> deleteUser() async {
  //   final http.Response response = await http.delete(
  //     '$urlApi/users/${_userPref.userId}',
  //     headers: <String, String>{
  //       'accept':'application/json',
  //       'Authorization': 'Bearer ${_userPref.token}'
  //       }
  //   );
  //   return response;
  // }

// enviar la foto a la API(POST)
Future sendPhoto(String urlPhoto, String propertyId) async {
  final url = "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos";
  final response = await http.post(
    url,
    headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'},
    body: {'url': urlPhoto}
    );
  Map<String, dynamic> decodedResp = json.decode(response.body);
  print(decodedResp);
//     if (decodedResp.containsKey('idToken')) {
//       _userPref.token = decodedResp['idToken'];
//       return {'ok': true};
//     } else {
//       return {'ok': false, 'message': decodedResp['error']['message']};
//     }
}

//pooling para recibir la información de la foto (GET)
  Future getInfoPhoto(String photoId, String propertyId) async {
    Future.delayed(Duration(seconds: 1));
    final url = "$urlApi/users/${_userPref.userId}/properties/$propertyId/photos/$photoId";

    final response = await http.get(
      url,
      headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'}
      );
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