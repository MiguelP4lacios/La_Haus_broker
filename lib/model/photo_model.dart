// To parse this JSON data, do
//
//     final photos = photosFromJson(jsonString);

import 'dart:convert';

Photos photosFromJson(String str) => Photos.fromJson(json.decode(str));

String photosToJson(Photos data) => json.encode(data.toJson());

class Photos {
  List<Photo> photos;

  Photos({
    this.photos,
  });

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}

class Photo {
  String place;
  List<String> url;
  List<String> id;

  Photo({this.place, this.url, this.id});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        place: json["place"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "url": url,
      };

  agregar(String place, String url, String id) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.add(url);
        item.id.add(id);
      }
    }
  }

  eliminar(String place, String url, String id) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.remove(url);
        item.id.remove(id);
      }
    }
  }

  resetList() {
    for (var item in cardPro) {
      item.url = [];
      item.id = [];
    }
  }
}

List<Photo> cardPro = [
  Photo(place: "Frente", url: [], id: []),
  Photo(place: "Cocina", url: [], id: []),
  Photo(place: "Zona Social", url: [], id: []),
  Photo(place: "Comedor", url: [], id: []),
  Photo(place: "Cuartos", url: [], id: []),
  Photo(place: "Baños", url: [], id: []),
  Photo(place: "Exteriores", url: [], id: [])
];
