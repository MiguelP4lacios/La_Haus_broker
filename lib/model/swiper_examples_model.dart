import 'package:flutter/material.dart';

class Card {
  final String imageUrl;
  final String description;

  Card({@required this.imageUrl, @required this.description});
}

final cardlist = [
  Card(
      imageUrl: 'assets/nice_kitchens/k1.jpg',
      description:
          'Recuerda que la iluminacion es esencial para una buena foto.'),
  Card(
      imageUrl: 'assets/nice_kitchens/k2.jpg',
      description: 'El lugar debe estar limpio y ordenado.'),
  Card(
      imageUrl: 'assets/nice_kitchens/k3.jpg',
      description: 'Captura el detalle y el ambiente que comunica el lugar.'),
  Card(
      imageUrl: 'assets/nice_kitchens/k4.jpg',
      description:
          'Captura todo el lugar haciendo la toma desde una distancia adecuada.'),
  Card(
      imageUrl: 'assets/nice_kitchens/k5.jpeg',
      description: 'Otro buen ejemplo de la distancia.'),
  Card(
      imageUrl: 'assets/nice_kitchens/k6.jpg',
      description:
          'Los objectos que contiene la cocina le da un buen ambiente y propecto para el posible comprador.')
];
