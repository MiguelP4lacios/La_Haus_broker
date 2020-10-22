// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_apartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResApartment _$ResApartmentFromJson(Map<String, dynamic> json) {
  return ResApartment(
    builtType: json['builtType'] as String,
    project: json['project'] as String,
    price: json['price'] as String,
    hood: json['hood'] as String,
    city: json['city'] as String,
    adress: json['adress'] as String,
    admon: json['admon'] as String,
    buildArea: json['buildArea'] as String,
    privateArea: json['privateArea'] as String,
    socialClass: json['socialClass'] as String,
    state: json['state'] as String,
    apt: json['apt'] as String,
    elevator: json['elevator'] as bool,
    commonArea: json['commonArea'] as String,
    propertyTax: json['propertyTax'] as String,
    rooms: json['rooms'] as String,
    bathrooms: json['bathrooms'] as String,
    halfBathrooms: json['halfBathrooms'] as String,
    parkingLot: json['parkingLot'] as String,
    utilityRoom: json['utilityRoom'] as bool,
    empty: json['empty'] as bool,
    inhabitants: json['inhabitants'] as bool,
    rent: json['rent'] as String,
    mortgage: json['mortgage'] as String,
  )
    ..id = json['id'] as num
    ..userId = json['userId'] as num;
}

Map<String, dynamic> _$ResApartmentToJson(ResApartment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'builtType': instance.builtType,
      'project': instance.project,
      'price': instance.price,
      'hood': instance.hood,
      'city': instance.city,
      'adress': instance.adress,
      'admon': instance.admon,
      'buildArea': instance.buildArea,
      'privateArea': instance.privateArea,
      'socialClass': instance.socialClass,
      'state': instance.state,
      'apt': instance.apt,
      'elevator': instance.elevator,
      'commonArea': instance.commonArea,
      'propertyTax': instance.propertyTax,
      'rooms': instance.rooms,
      'bathrooms': instance.bathrooms,
      'halfBathrooms': instance.halfBathrooms,
      'parkingLot': instance.parkingLot,
      'utilityRoom': instance.utilityRoom,
      'empty': instance.empty,
      'inhabitants': instance.inhabitants,
      'rent': instance.rent,
      'mortgage': instance.mortgage,
    };
