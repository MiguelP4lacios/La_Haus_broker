import 'package:json_annotation/json_annotation.dart';

part 'apartment.g.dart';

@JsonSerializable()
// Model aparment
class Apartment {
  String built_type;
  String project;
  String price;
  String hood; // → hood
  String city;
  String address;
  String admon;
  String build_area;
  String private_area;
  // 2
  String social_class;
  String state;
  String apt;
  String elevator;
  String common_areas;
  String property_tax;
  // 3
  String rooms;
  String bathrooms;
  String half_bathrooms;
  String parking_lot;
  String utility_room;
  // 4
  String empty_property;
  String inhabitants;
  String rent_desition;
  String rent;
  String mortgage;

  Apartment(
      {this.built_type,
      this.project,
      this.price,
      this.hood, // → hood
      this.city,
      this.address,
      this.admon,
      this.build_area,
      this.private_area,
      // 2
      this.social_class,
      this.state,
      this.apt,
      this.elevator,
      this.common_areas,
      this.property_tax,
      // 3
      this.rooms,
      this.bathrooms,
      this.half_bathrooms,
      this.parking_lot,
      this.utility_room,
      // 4
      this.empty_property,
      this.inhabitants,
      this.rent_desition,
      this.rent,
      this.mortgage});

  // Convert the instance to Json
  Map<String, dynamic> toJson() => _$ApartmentToJson(this);
}
