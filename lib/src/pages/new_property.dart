import 'package:flutter/material.dart';

class PropertyPage extends StatelessWidget {

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
                  color: Color.fromRGBO(103, 103, 103, 100),
                  icon: new Icon(Icons.keyboard_arrow_left),
                  onPressed: (){
                    Navigator.of(context).pushNamed('profile');
                  },
                ),
                IconButton(
                  iconSize: 40.0,
                  color: Color.fromRGBO(103, 103, 103, 100),
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
              color: Color.fromRGBO(103, 103, 103, 100),
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
                  cambiarImagen('assets/images/house.png', 'Casa'),
                  cambiarImagen('assets/images/building.png', 'Apartamento'),
                  cambiarImagen('assets/images/field.png', 'Finca'),
                  cambiarImagen('assets/images/trees.png', 'Lote')
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
cambiarImagen(String imagen, String propertyType) {
  return Container(
    child: Column(
      children: [
        IconButton(
          icon: Image.asset(imagen),
          iconSize: 170.0,
          onPressed: (){
            //function redirect
            // habilitar botón de siguiente
            // Cómo enviar los datos de tipo de propiedad?
          }
        ),
        SizedBox(height: 20.0),
        Text(propertyType, style: TextStyle(
          fontSize: 20.0,
          color: Color.fromRGBO(103, 103, 103, 100)
        ),)
      ]
    ),
  );
}

