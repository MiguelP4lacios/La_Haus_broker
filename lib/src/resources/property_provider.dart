import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';
import '../pages/globals.dart' as globals;

class PropertyProvider {
  final _userPref = new UserPreferences();

  Future<Map<String, dynamic>> newProperty(Map<String, dynamic> data) async {
    final resp = await http.post(
        'https://lahaus.herokuapp.com/api/v1/users/${_userPref.userId}/properties',
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${_userPref.token}'
        });
    Map<String, dynamic> ap = json.decode(resp.body);
    if (resp.statusCode == 201) {
      globals.jsonProperty = ap['properties'];
      return {'ok': true};
    } else {
      return {'ok': false};
    }
  }
}
