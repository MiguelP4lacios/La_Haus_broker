import 'dart:convert';

PhotoModel photoModelFromJson(String str) =>
    PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel {
  PhotoModel({
    this.housePart,
  });

  HousePart housePart;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        housePart: HousePart.fromJson(json["house_part"]),
      );

  Map<String, dynamic> toJson() => {
        "house_part": housePart.toJson(),
      };
}

class HousePart {
  HousePart({
    this.name,
    this.pictureUrl,
  });

  String name;
  String pictureUrl;

  factory HousePart.fromJson(Map<String, dynamic> json) => HousePart(
        name: json["name"],
        pictureUrl: json["picture_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture_url": pictureUrl,
      };
}
