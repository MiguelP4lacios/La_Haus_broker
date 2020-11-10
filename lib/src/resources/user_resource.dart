/* This module is used connect all actions related with
user login and register with the server api */
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

class UserProvider {
  //final _fireBaseToken = 'AIzaSyDwvPnf351IUk36ZBOxIHukHPuiNFH1nJU';
  final _userPref = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email.toString(),
      'password': password.toString()
      //'returnSecureToken': true,
    };

    print("auth: " + authData.toString());
    try {
      final resp = await http.post(
          'https://lahaus.herokuapp.com/api/v1/login/?email=${email.toString()}&password=${password.toString()}',
          headers: {'Authorization': 'Bearer token'});

      print("my body:" + resp.body);

      Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (decodedResp.containsKey('token')) {
        _userPref.token = decodedResp['token'];
        _userPref.userId = decodedResp['users']['id'].toString();
        _userPref.name = decodedResp['users']['full_name'].toString();
        _userPref.email = decodedResp['users']['email'].toString();
        _userPref.cellphone = decodedResp['users']['cellphone'].toString();
        return {'ok': true, 'massage': 'ok'};
      } else {
        return {'ok': false, 'message': decodedResp['errors']};
      }
    } catch (e) {
      return {'ok': false, 'message': 'La sesión ha expirado'};
    }
  }

  Future<Map<String, dynamic>> newUser(Map<String, dynamic> data) async {
    final authData = {
      /* this variable is just to test the project in firebase db
    it will be deleted once real api has implemented
    data will be used instead of authdata*/
      'email': data['email'].toString(),
      'password': data['password'].toString(),
      'full_name': data['full_name'].toString(),
      'cellphone': data['cellphone'].toString()
      //'returnSecureToken': true,
    };
    try {
      final resp = await http.post('https://lahaus.herokuapp.com/api/v1/signup',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
      print(resp.body);
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (decodedResp.containsKey('token')) {
        _userPref.token = decodedResp['token'];
        _userPref.userId = decodedResp['users']['id'].toString();
        _userPref.name = decodedResp['users']['full_name'].toString();
        _userPref.email = decodedResp['users']['email'].toString();
        _userPref.cellphone = decodedResp['users']['cellphone'].toString();
        return {'ok': true, 'message': "ok"};
      } else {
        return {'ok': false, 'message': decodedResp['errors']};
      }
    } catch (e) {
      return {'ok': false, 'message': 'La sesión ha expirado'};
    }
  }
}
