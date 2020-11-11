import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/widgets/swipercard_examples.dart';

// This model controls the list for showing the examples requested by the user. It stores the methods, icons, titles and description necessary to show the grrat pictures taken.//
class ExamplesView {
  final IconData icon;
  final String title;
  final Widget onTap;
  final String description;

  ExamplesView(
      {@required this.icon,
      @required this.title,
      @required this.onTap,
      @required this.description});
}

final List<ExamplesView> examplesView = [
  ExamplesView(
      icon: Icons.account_box,
      title: 'Cocinas',
      onTap: SwiperCardKitchen(),
      description: 'Ejemplos de Cocinas'),
  ExamplesView(
    icon: Icons.add,
    title: 'Baños',
    onTap: SwiperCardBathroom(),
    description: 'ejemplos de baños',
  ),
  ExamplesView(
    icon: Icons.camera_enhance,
    title: 'Cuartos',
    onTap: SwiperCardBedroom(),
    description: 'ejemplos de cuartos',
  ),
  ExamplesView(
    icon: Icons.accessibility,
    title: 'Zonas Sociales',
    onTap: SwiperCardSocialZone(),
    description: 'Ejemplos de Zonas Sociales',
  ),
  ExamplesView(
    icon: Icons.account_balance,
    title: 'Exteriores y Zonas Comunes',
    onTap: SwiperCardCommonAreas(),
    description: 'Ejemplos de Exteriores y Areas Comunes',
  ),
];
