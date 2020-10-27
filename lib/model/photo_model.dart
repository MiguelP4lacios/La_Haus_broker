// To parse this JSON data, do
//
//     final propertyPhoto = propertyPhotoFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

HouseParts housePartsFromJson(String str) =>
    HouseParts.fromJson(json.decode(str));

String housePartsToJson(HouseParts data) => json.encode(data.toJson());

class HouseParts {
  String name;
  ImagesUrl imagesUrl;

  HouseParts({
    @required this.name,
    this.imagesUrl,
  });

  factory HouseParts.fromJson(Map<String, dynamic> json) => HouseParts(
        name: json["name"],
        imagesUrl: ImagesUrl.fromJson(json["images_url"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "images_url": imagesUrl.toJson(),
      };
}

class ImagesUrl {
  String url;

  ImagesUrl({
    this.url,
  });

  factory ImagesUrl.fromJson(Map<String, dynamic> json) => ImagesUrl(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

// final property = HouseParts();
// final propertyPart = HousePart();

final List<HouseParts> cardProperty = [
  HouseParts(
    name: "Cocina",
    imagesUrl: ImagesUrl(
        url:
            'https://res.cloudinary.com/dfne0hspy/image/upload/v1602989421/sample.jpg'),
  ),
  HouseParts(
    name: "Baño",
    imagesUrl: ImagesUrl(
        url:
            'https://res.cloudinary.com/dfne0hspy/image/upload/v1603339597/efelpaqc8gndoqtynmm3.png'),
  ),
  HouseParts(
    name: "Comedor",
    imagesUrl: ImagesUrl(
        url:
            'https://res.cloudinary.com/dfne0hspy/image/upload/v1603412138/zsxix5nj0jlgv2xm3xou.jpg'),
  ),
  HouseParts(
    name: "Cuarto 1",
    imagesUrl: ImagesUrl(
        url:
            'https://res.cloudinary.com/dfne0hspy/image/upload/v1603470091/lkbxpekg3yryvfndo3su.jpg'),
  ),
];

// final cardProperty = {
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Cocina',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Cuarto',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Comedor',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Zona Social',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Fachada',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
//   PropertyPhoto(
//     propertyPhotoPart: Part(
//       namePart: 'Baños',
//       imageUrl: 'picture taken from ',
//     ),
//   ),
// };
