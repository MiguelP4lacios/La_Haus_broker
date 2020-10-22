// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apartment _$ApartmentFromJson(Map<String, dynamic> json) {
  return Apartment(
    built_type: json['built_type'] as String,
    project: json['project'] as String,
    price: json['price'] as String,
    hood: json['hood'] as String,
    city: json['city'] as String,
    address: json['address'] as String,
    admon: json['admon'] as String,
    build_area: json['build_area'] as String,
    private_area: json['private_area'] as String,
    social_class: json['social_class'] as String,
    state: json['state'] as String,
    apt: json['apt'] as String,
    elevator: json['elevator'] as String,
    common_areas: json['common_areas'] as String,
    property_tax: json['property_tax'] as String,
    rooms: json['rooms'] as String,
    bathrooms: json['bathrooms'] as String,
    half_bathrooms: json['half_bathrooms'] as String,
    parking_lot: json['parking_lot'] as String,
    utility_room: json['utility_room'] as String,
    empty_property: json['empty_property'] as String,
    inhabitants: json['inhabitants'] as String,
    rent: json['rent'] as String,
    mortgage: json['mortgage'] as String,
  );
}

Map<String, dynamic> _$ApartmentToJson(Apartment instance) => <String, dynamic>{
      'built_type': instance.built_type,
      'project': instance.project,
      'price': instance.price,
      'hood': instance.hood,
      'city': instance.city,
      'address': instance.address,
      'admon': instance.admon,
      'build_area': instance.build_area,
      'private_area': instance.private_area,
      'social_class': instance.social_class,
      'state': instance.state,
      'apt': instance.apt,
      'elevator': instance.elevator,
      'common_areas': instance.common_areas,
      'property_tax': instance.property_tax,
      'rooms': instance.rooms,
      'bathrooms': instance.bathrooms,
      'half_bathrooms': instance.half_bathrooms,
      'parking_lot': instance.parking_lot,
      'utility_room': instance.utility_room,
      'empty_property': instance.empty_property,
      'inhabitants': instance.inhabitants,
      'rent': instance.rent,
      'mortgage': instance.mortgage,
    };
