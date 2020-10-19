import 'package:json_annotation/json_annotation.dart';

part 'insert_property_aparment.g.dart';

@JsonSerializable()
class InsertPropertyAparmnet {
  String price;
  String neighborhood;
  String adress;
  String admon;
  String buildArea;
  String privateArea;
  // 2
  String socialClass;
  String state;
  String floor;
  String elevator;
  //String commonArea
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

  InsertPropertyAparmnet(
      {this.price,
      this.neighborhood,
      this.adress,
      this.admon,
      this.buildArea,
      this.privateArea,
      // 2
      this.socialClass,
      this.state,
      this.floor,
      this.elevator,
      //this.commonArea
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

  Map<String, dynamic> toJson() => _$InsertPropertyAparmnetToJson(this);
}
