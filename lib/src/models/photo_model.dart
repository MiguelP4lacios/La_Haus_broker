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
  List<bool> foco;
  List<bool> ilum;

  Photo({this.place, this.url, this.id, this.foco, this.ilum});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        place: json["place"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "url": url,
      };

  agregar(String place, String url, String id, bool foco, bool ilum) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.add(url);
        item.id.add(id);
        item.foco.add(foco);
        item.ilum.add(ilum);
      }
    }
  }

  eliminar(String place, String url, String id, bool foco, bool ilum) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.remove(url);
        item.id.remove(id);
        item.foco.remove(foco);
        item.ilum.remove(ilum);
      }
    }
  }

  resetList() {
    for (var item in cardPro) {
      item.url = [];
      item.id = [];
      item.foco = [];
      item.ilum = [];
    }
  }
}

List<Photo> cardPro = [
  Photo(place: "Frente", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Cocina", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Zona Social", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Comedor", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Cuartos", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Baños", url: [], id: [], foco: [], ilum: []),
  Photo(place: "Exteriores", url: [], id: [], foco: [], ilum: [])
];
