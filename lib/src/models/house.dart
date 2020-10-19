/* Property House model
This is a an abstraction of a house used to manage all the attributes of a house
*/
import 'dart:convert';

HouseModel houseModelFromJson(String str) =>
    HouseModel.fromJson(json.decode(str));
/* JSON example
{  
       "id": "",
       "user_id": "",
       "price": "",
       "neighborhood": "",
       "address": "",
       "admon": "",
       "buid_area": "",
       "private_area": "",
       "social_class": "",
       "state": "",
       "property_tax": "",
       "rent": "",
       "mortage": "",
       "photos": [],
}
*/
String houseModelToJson(HouseModel data) => json.encode(data.toJson());

class HouseModel {
  HouseModel(
      {this.id,
      // this.userId,
      this.price,
      this.state,
      this.neighborhood,
      this.propertyType,
      this.address,
      this.bathrooms,
      // this.admon,
      // this.buidArea,
      // this.privateArea,
      // this.socialClass,
      // this.propertyTax,
      // this.rent,
      // this.mortage,
      this.img});
  double heigth = 320.0;
  String id;
  String userId;
  int price;
  String neighborhood;
  String state;
  String img;
  String propertyType;
  String address;
  String bathrooms;

  // String admon;
  // String buidArea;
  // String privateArea;
  // String socialClass;
  // String propertyTax;
  // String rent;
  // String mortage;

  /* This is the position in the animatedList
  it is used only for UI */
  int position;
  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
        id: json["id"],
        price: json["price"],
        neighborhood: json["neighborhood"],
        img: json['img'],
        state: json["state"],
        propertyType: json['property_type'],
        address: json["address"],
        bathrooms: json["bathrooms"],
        // admon: json["admon"],
        // buidArea: json["buid_area"],
        // privateArea: json["private_area"],
        // socialClass: json["social_class"],
        // propertyTax: json["property_tax"],
        // rent: json["rent"],
        // mortage: json["mortage"],
        // userId: json["user_id"],
      );
  void changeAttr(key, value) {
    /* since the map representation keys of this property does not have the same
    name as that this property attibutes has, changeAttr is necesary if you want
    to change an attribute value using the map representation keys */
    if ("Precio" == key) {
      price = int.parse(value);
    } else if ('Barrio' == key) {
      neighborhood = value;
    } else if ("Estado" == key) {
      state = value;
    } else if ("Dirección" == key) {
      address = value;
    } else if ("Baños" == key) {
      bathrooms = value;
    }
  }

  Map<String, dynamic> toMap() => {
        /* create map representation of the property. This function is used
    specially to create the editPage which will be showed to the user */
        "Precio": price,
        "Barrio": neighborhood,
        "Estado": state,
        "Dirección": address,
        "Baños": bathrooms,
        "img": img,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "price": price,
        "neighborhood": neighborhood,
        "state": state,
        "property_type": propertyType,
        "address": address,
        "bathrooms": bathrooms,
        "img": img,
        // "admon": admon,
        // "buid_area": buidArea,
        // "private_area": privateArea,
        // "social_class": socialClass,
        // "property_tax": propertyTax,
        // "rent": rent,
        // "mortage": mortage,
      };
}
