import 'package:json_annotation/json_annotation.dart';

part 'apartment.g.dart';

@JsonSerializable()
class Apartment {
  String builtType;
  String project;
  String price;
  String hood; // → hood
  String city;
  String adress;
  String admon;
  String buildArea;
  String privateArea;
  // 2
  String socialClass;
  String state;
  String apt;
  String elevator;
  String commonArea;
  String propertyTax;
  // 3
  String rooms;
  String bathrooms;
  String halfBathrooms;
  String parkingLot;
  String utilityRoom;
  // 4
  String empty;
  String inhabitants;
  String rent;
  String mortgage;

  Apartment(
      {this.builtType,
      this.project,
      this.price,
      this.hood, // → hood
      this.city,
      this.adress,
      this.admon,
      this.buildArea,
      this.privateArea,
      // 2
      this.socialClass,
      this.state,
      this.apt,
      this.elevator,
      this.commonArea,
      this.propertyTax,
      // 3
      this.rooms,
      this.bathrooms,
      this.halfBathrooms,
      this.parkingLot,
      this.utilityRoom,
      // 4
      this.empty,
      this.inhabitants,
      this.rent,
      this.mortgage});

  Map<String, dynamic> toJson() => _$ApartmentToJson(this);
}
