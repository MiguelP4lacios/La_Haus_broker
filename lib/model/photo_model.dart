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

  Photo({
    this.place,
    this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        place: json["place"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "url": url,
      };

  agregar(String place, String url) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.add(url);
      }
    }
  }

  eliminar(String place, String url) {
    for (var item in cardPro) {
      if (item.place == place) {
        item.url.remove(url);
      }
    }
  }
}

// Photos photosFromJson(String str) => Photos.fromJson(json.decode(str));

// String photosToJson(Photos data) => json.encode(data.toJson());

// class Photos {
//   String place;
//   // String url;
//   List<String> url;

//   Photos({
//     this.place,
//     this.url,
//   });

//   factory Photos.fromJson(Map<String, dynamic> json) => Photos(
//         place: json["place"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "place": place,
//         "url": url,
//       };

//   void addPhoto(String urlPhoto) {
//     url.add(urlPhoto);
//   }
// }

// Photos photoCocina = Photos(place: 'Cocina');
// Photos photoCuarto = Photos(place: 'Cuarto');
// Photos photoBath = Photos(place: 'Baño');
// Photos photoSala = Photos(place: 'Zona Social');
// Photos photoComedor = Photos(place: 'Comeder');
// Photos photo = Photos(place: 'Comedor');
// // Photos photoRoom1 = Photos(place: 'Comedor', url: "urlfoto1");
// // Photos photoRoom = Photos(place: 'Comedor', url: "urlfoto2");

// List<Photos> methodPractice(Photos inst) {
//   final List<Photos> library = [];
//   library.add(inst);
//   return library;
// }

// // hardcore porn
// _convertList() {

// }

List<Photo> cardPro = [
  Photo(place: "Frente", url: []),
  Photo(place: "Cocina", url: []),
  Photo(place: "Zona Social", url: []),
  Photo(place: "Comedor", url: []),
  Photo(place: "Cuartos", url: []),
  Photo(place: "Baños", url: []),
  Photo(place: "Exteriores", url: [])
];

// List<String> urls = [
//   "url",
//   "url",
//   "url",
//   "url",
//   "url",
// ];

// final List<Photos> cardProperty = [
//   Photos(
//     place: "Cocina",

//     url:
//         'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg',
//         'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg',
//         'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg',
//   ),
//   Photos(
//       place: "Baños",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1603339597/efelpaqc8gndoqtynmm3.png'),
//   Photos(
//       place: "Comedor",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1603412138/zsxix5nj0jlgv2xm3xou.jpg'),
//   Photos(
//       place: "Cuartos",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1603470091/lkbxpekg3yryvfndo3su.jpg'),
//   Photos(
//       place: "Fachada/Frente",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg'),
//   Photos(
//       place: "Zona Social",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg'),
//   Photos(
//       place: "Jacuzzi",
//       url:
//           'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg'),
// ];

// // final cardProperty = {
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Cocina',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Cuarto',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Comedor',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Zona Social',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Fachada',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// //   PropertyPhoto(
// //     propertyPhotoPart: Part(
// //       namePart: 'Baños',
// //       imageUrl: 'picture taken from ',
// //     ),
// //   ),
// // };
