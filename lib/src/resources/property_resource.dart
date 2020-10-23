/* This file is used for edit_page to make http petitions */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/models/house.dart';
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

final String _url = "https://lahaus.herokuapp.com/api/v1";
final _userPref = UserPreferences();
Future<List<dynamic>> loadProperties() async {
  /* Get all the properties from the server
  in case the first petition fails another one is make*/
  final url = "$_url/users/${_userPref.userId}/properties";
  // try {
  List<dynamic> properties = List();
  try {
    final resp = await http
        .get(url, headers: {'Authorization': 'Bearer ${_userPref.token}'});
    final decodedData = json.decode(resp.body);
    final decodedProps = decodedData['properties'];

    if (decodedProps.length != 0) {
      decodedData['properties'].forEach((property) {
        properties.add(HouseModel.fromJson(property));
      });
    }
    return properties;
  } catch (e) {
    print(e);
    return ['error_connection'];
  }
}

Future deleteProp(String id) async {
  /* Delete one Property */
  Future.delayed(Duration(seconds: 2));
  final url = "$_url/users/${_userPref.userId}/properties/$id";
  final resp = await http.delete(url, headers: {
    "accept": "application/json",
    'Authorization': 'Bearer ${_userPref.token}'
  });
  print(json.decode(resp.body));
}

Future editProperty(dynamic property) async {
  /* Change the attributes of a property */
  final url = "$_url/users/${_userPref.userId}/properties/${property.id}";
  print(property.toJson());
  final resp =
      await http.put(url, body: json.encode(property.toJson()), headers: {
    'Authorization': 'Bearer ${_userPref.token}',
    "accept": "application/json",
    "Content-Type": "application/json"
  });
  final decodedData = json.decode(resp.body);
  print(decodedData);
  return true;
}
