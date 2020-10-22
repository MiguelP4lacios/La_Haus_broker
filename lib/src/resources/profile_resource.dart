/* This file is used for edit_page to make http petitions */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';


// class ProfileProvider {
//   final _userPref = new UserPreferences();
//   final String _url = "https://lahaus.herokuapp.com/api/v1/";


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
  final String _url = "https://lahaus.herokuapp.com/api/v1/";
  Future deleteUser() async {
    Future.delayed(Duration(seconds: 2));
    final url = "$_url/users/${_userPref.userId}";
    await http.delete(
      url,
      headers: {'accept':'application/json', 'Authorization': 'Bearer ${_userPref.token}'}
      );
  }


