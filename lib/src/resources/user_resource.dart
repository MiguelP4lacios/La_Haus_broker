/* This module is used connect all actions related with
user login and register with the server api */
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

class UserProvider {
  final _fireBaseToken = 'AIzaSyDwvPnf351IUk36ZBOxIHukHPuiNFH1nJU';
  final _userPref = new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken',
      body: json.encode(authData),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      _userPref.token = decodedResp['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(Map<String, dynamic> data) async {
    final authData = {
      /* this variable is just to test the project in firebase db
    it will be deleted once real api has implemented
    data will be used instead of authdata*/
      'email': data['email'],
      'password': data['password'],
      'returnSecureToken': true,
    };
    print(data['phone_number']);
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken',
      body: json.encode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('idToken')) {
      _userPref.token = decodedResp['idToken'];
      return {'ok': true};
    } else {
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }
}
