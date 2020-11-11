// Model amenities.
class Item {
  int id;
  String title;
  Item({this.id, this.title});
  List<String> _amenities = [
    "Piscina",
    "Piscina de Niños",
    "Salón Social",
    "Placa Polideportiva",
    "BBQ",
    "Estaciones de Ejercicio al Aire Libre",
    "Juegos Infantiles",
    "Jacuzzi",
    "Sauna",
    "Turco",
    "Gimnasio",
    "Zonas Verdes",
    "Cancha Múltiple",
    "Cancha Sintética",
    "Cancha de Squash",
    "Otras Canchas",
    "Zona Comercial",
    "Solarium",
    "Club House",
    "Sky Club",
    "Carril de Nado",
    "Zona de Mascotas",
    "Ludoteca",
    "Cine",
    "Karaoke",
    "Centro de Negocios",
    "Ascensor",
    "Baño Turco",
    "Parqueadero de Visitantes",
    "Shut de Basura",
    "Cancha de Tenis",
    "Jardín",
    "Patio",
    "Sala de Internet",
    "Kiosko",
    "Cancha de Baloncesto",
    "Cancha de Fútbol",
    "Zona de Camping",
    "Lago",
    "Cancha de Microfútbol",
    "Cancha de Volleyball",
    "Minigolf",
    "Mesa de Ping Pong",
    "Sala de Juegos",
    "Ascensor de Servicio",
    "Auditorio",
    "Circuito Cerrado de TV",
    "Corrales",
    "Espacio Yoga",
    "Guardería",
    "Jaula de Golf",
    "Lavandería",
    "Muro de Escalada",
    "Planta Eléctrica",
    "Rooftop",
    "Salón de Conferencias",
    "Sendero Ecologico",
    "Spa",
    "Vigilancia 24 Hrs",
    "Vigilancia Privada",
    "Accesso Silla de Ruedas",
    "Terraza"
  ];

  // Get the amenities checked
  List<String> getAm(
      Map<int, bool> checkBoxes, Map<int, String> checkAmenities) {
    List<String> _am = [];

    for (var i = 0; i < checkBoxes.length; i++) {
      if (checkBoxes[i] != false) {
        print(i);
        print(checkAmenities[i]);
        _am.add(checkAmenities[i]);
      }
    }
    return _am;
  }

  // Get all amenities
  List<Item> getItems() {

    List<Item> _items = [];
    for (var i = 0; i < _amenities.length; i++) {
      _items.add(Item(id: i, title: _amenities[i]));
    }
    return _items;
  }
}
