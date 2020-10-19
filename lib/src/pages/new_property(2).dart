import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class PropertyPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20), // espacio
            Row( // Botones superiores (puede ser un appbar)
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 50.0,
                  color: Color.fromRGBO(103, 103, 103, 1.0),
                  icon: new Icon(Icons.keyboard_arrow_left),
                  onPressed: (){
                    Navigator.of(context).pushNamed('profile');
                  },
                ),
                IconButton(
                  iconSize: 40.0,
                  color: Color.fromRGBO(103, 103, 103, 1.0),
                  icon: new Icon(Icons.highlight_off),
                  onPressed: (){
                    Navigator.of(context).pushNamed('home');
                  },
                ),
              ],
            ),
            SizedBox(height: 20), // espacio
            Text('¿Qué vas a ofrecer?', style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(103, 103, 103, 1.0),
              fontWeight: FontWeight.w400
              ),
            ), // fontFamily: 'Raleway', 
            SizedBox(height: 100), // espacio
            Container( // sección de las imagenes del centro
              width: double.infinity, // ancho automático
              height: 250, // altura específica
              child: PageView( // scroll en el centro por defecto horizontal
                controller: PageController(viewportFraction: 0.7), //para que se vean los siguientes - 70% de la pantalla
                physics: BouncingScrollPhysics(), //para cuando llegue al final no me muestre un círculo de delimiter
                children: <Widget>[ // Lista del contenido que va a estar en el scroll
                  cambiarImagen('assets/images/house.png', 'Casa', context, 1),
                  cambiarImagen('assets/images/building.png', 'Apartamento', context, 2),
                  cambiarImagen('assets/images/field.png', 'Finca', context, 3),
                  cambiarImagen('assets/images/trees.png', 'Lote', context, 4)
                ],
              ),
            ),
            SizedBox(height: 50), // espacio
          ],
        ),
      );
  }
}

// Función para escoger tipo de propiedad
cambiarImagen(String imagen, String propertyType, BuildContext context, int idx) {
  return Container(
    child: Column(
      children: [
        IconButton(
          icon: Image.asset(imagen),
          iconSize: 170.0,
          onPressed: (){
            globals.propertyType = propertyType;
            Navigator.of(context).pushNamed('property');
            // Navigator.of(context).pushNamed(FormP1Screen());
          }
        ),
        SizedBox(height: 20.0),
        Text(propertyType, style: TextStyle(
          fontSize: 20.0,
          color: Color.fromRGBO(103, 103, 103, 1.0)
        ),)
      ]
    ),
  );
}

