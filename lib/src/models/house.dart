/* Property House model
This is a an abstraction of a house used to manage all the attributes of a house
*/
/* JSON example
{  
       "id": "",
       "user_id": "",
       "price": "",
       "neighborhood": "",
       "address": "",
       "admon": "",
       "build_area": "",
       "private_area": "",
       "social_class": "",
       "state": "",
       "property_tax": "",
       "rent": "",
       "mortage": "",
} */
class HouseModel {
  /* This model is used in the Home Page view to manage and show the houses */
  HouseModel(
      {this.id,
      this.userId,
      this.price,
      this.builtType,
      this.address,
      this.admon,
      this.buildArea,
      this.privateArea,
      this.socialClass,
      this.state,
      this.propertyTax,
      this.mortage,
      this.commonAreas,
      this.rooms,
      this.bathrooms,
      this.halfBathrooms,
      this.parkingLot,
      this.utilityRoom,
      this.empty,
      this.inhabitants,
      this.rent,
      this.neighborhood,
      this.img});
  String id;
  String userId;
  String price;
  String neighborhood;
  String state;
  String builtType;
  String address;
  String bathrooms;
  String admon;
  String buildArea;
  String privateArea;
  String socialClass;
  String propertyTax;
  String rent;
  String mortage;
  String commonAreas;
  String rooms;
  String halfBathrooms;
  String parkingLot;
  String img;
  bool utilityRoom;
  bool empty;
  bool inhabitants;

  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
        id: json["id"].toString(),
        price: json["price"],
        neighborhood: json["hood"],
        state: json["state"],
        builtType: json['built_type'],
        address: json["address"],
        bathrooms: json["bathrooms"],
        admon: json["admon"],
        buildArea: json["build_area"],
        privateArea: json["private_area"],
        socialClass: json["social_class"],
        propertyTax: json["property_tax"],
        rent: json["rent"],
        mortage: json["mortage"],
        userId: json["user_id"].toString(),
        commonAreas: json["common_areas"],
        rooms: json["rooms"],
        halfBathrooms: json["half_bathrooms"],
        parkingLot: json["parking_lot"],
        utilityRoom: json["utility_room"],
        empty: json["empty_property"],
        // empty: json["empty_property"] == null ? false : json["empty_property"],
        inhabitants: json["inhabitants"],
      );
  void changeAttr(key, value) {
    /* since the map representation keys of this property does not have the same
    name as that this property attibutes has, changeAttr is necesary if you want
    to change an attribute value using the map representation keys */
    if ("Precio" == key) {
      price = value;
    } else if ('Barrio' == key) {
      neighborhood = value;
    } else if ("Estado" == key) {
      state = value;
    } else if ("Dirección" == key) {
      address = value;
    } else if ("Baños" == key) {
      bathrooms = value;
    } else if ("Administración" == key) {
      admon = value;
    } else if ("Area Construida" == key) {
      buildArea = value;
    } else if ("Area Privada" == key) {
      privateArea = value;
    } else if ("Estrato" == key) {
      socialClass = value;
    } else if ("Impuestos" == key) {
      propertyTax = value;
    } else if ("Renta" == key) {
      rent = value;
    } else if ("Hipoteca" == key) {
      mortage = value;
    } else if ("Areas Comunes" == key) {
      commonAreas = value;
    } else if ("Habitaciones" == key) {
      rooms = value;
    } else if ("Medios Baños" == key) {
      halfBathrooms = value;
    } else if ("Parqueaderos" == key) {
      parkingLot = value;
    } else if ("Cuarto Util" == key) {
      utilityRoom = value;
    } else if ("Vacío" == key) {
      empty = value;
    } else if ("Inhabitado" == key) {
      inhabitants = value;
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
        "Administración": admon,
        "Area Construida": buildArea,
        "Area Privada": privateArea,
        "Estrado": socialClass,
        "Impuestos": propertyTax,
        "Renta": rent,
        "Hipoteca": mortage,
        "Areas Comunes": commonAreas,
        "Habitaciones": rooms,
        "Medios Baños": halfBathrooms,
        "Parqueaderos": parkingLot,
        "Cuarto Util": utilityRoom,
        "Vacío": empty,
        "Inhabitado": inhabitants,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId.toString(),
        "price": price,
        "hood": neighborhood,
        "state": state,
        "built_type": builtType,
        "address": address,
        "bathrooms": bathrooms,
        "admon": admon,
        "build_area": buildArea,
        "private_area": privateArea,
        "social_class": socialClass,
        "property_tax": propertyTax,
        "rent": rent,
        "mortage": mortage,
        "common_areas": commonAreas,
        "rooms": rooms,
        "half_bathrooms": halfBathrooms,
        "parking_lot": parkingLot,
        "utility_room": utilityRoom,
        "empty_property": empty,
        "inhabitants": inhabitants,
      };
}
