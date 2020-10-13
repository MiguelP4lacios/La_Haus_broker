import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide(
      {@required this.imageUrl,
      @required this.title,
      @required this.description});
}

final slidelist = [
  Slide(
      imageUrl: 'assets/slides_intro/Imagen1_paseo.png',
      title: 'Bienvenidos a La Haus Brokers',
      description: 'Aquí podrás tomar las mejores fotos del mercado.'),
  Slide(
      imageUrl: 'assets/slides_intro/Imagen2_paseo.png',
      title: 'Conviertete en un fotografo',
      description:
          'Te damos los mejores tips para que tus fotografías se vean mas profesionales.'),
  Slide(
      imageUrl: 'assets/slides_intro/Imagen3_paseo.png',
      title: 'Mejora la visibilidad de tu vivienda',
      description: 'Te guiamos paso a paso para que tu vivienda destaque.'),
];
