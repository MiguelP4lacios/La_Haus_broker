/* This file is used for edit_page to make http petitions */
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_bloc_pattern/src/models/house.dart';

final String _url = "https://houseflutter.firebaseio.com/";

Future<List<dynamic>> loadProperties() async {
  /* Get all the properties from the server
  in case the first petition fails another one is make*/
  final url = "$_url/property.json";
  try {
    return await _getProperties(url);
  } catch (e) {
    await Future.delayed(const Duration(seconds: 3), () => "3");
    return await _getProperties(url);
  }
}

Future deleteProp(String id) async {
  /* Delete one Property */
  Future.delayed(Duration(seconds: 2));
  final url = "$_url/property/$id.json";
  await http.delete(url);
}

Future editProperty(String id, dynamic property) async {
  /* Change the attributes of a property */
  print(property.toJson());
  print(id);
  final url = "$_url/property/$id.json";
  final resp = await http.put(url, body: json.encode(property.toJson()));
  final decodedData = json.decode(resp.body);
  print(decodedData);
  return true;
}

Future<List<dynamic>> _getProperties(String url) async {
  /* get a properties from the server */
  List<dynamic> properties = List();
  final resp = await http.get(url);
  final decodedData = json.decode(resp.body);
  if (decodedData != null) {
    decodedData.forEach((id, property) {
      property['id'] = id;
      if (property['property_type'] == 'house') {
        properties.add(HouseModel.fromJson(property));
      }
    });
  }
  return properties;
}
