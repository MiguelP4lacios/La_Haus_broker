import 'package:flutter/material.dart';
import 'globals.dart' as globals;


// Page to choose the property type
class PropertyPage extends StatefulWidget {
  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green[900] : Color.fromRGBO(0, 208, 175, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround, // esto daña el slider
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15), // espacio
          Text(
            '¿Qué vas a ofrecer?',
            style: TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(103, 103, 103, 1.0),
                fontWeight: FontWeight.w400),
          ), // fontFamily: 'Raleway',
          SizedBox(height: 40), // espacio
          Container(
            // sección de las imagenes del centro
            width: 250, // ancho automático
            height: 250, // altura específica
            child: PageView(
              // scroll en el centro por defecto horizontal
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              physics: BouncingScrollPhysics(), //para cuando llegue al final no me muestre un círculo de delimiter
              children: <Widget>[
                // Lista del contenido que va a estar en el scroll
                cambiarImagen('assets/images/house.png', 'Casa', context),
                cambiarImagen('assets/images/building.png', 'Apartamento', context),
                // cambiarImagen('assets/images/field.png', 'Finca', context),
                // cambiarImagen('assets/images/trees.png', 'Lote', context)
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          _currentPage != _numPages - 1
              ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                  ),
                )
              : Text(''),
        ],
      ),
    );
  }
}

// Función para escoger tipo de propiedad
cambiarImagen(String imagen, String propertyType, BuildContext context) {
  return Container(
    child: Column(children: [
      IconButton(
          icon: Image.asset(imagen),
          iconSize: 150.0,
          onPressed: () {
            globals.propertyType = propertyType;
            Navigator.of(context).pushNamed('form');
            // Navigator.of(context).pushNamed(FormP1Screen());
          }),
      SizedBox(height: 20.0),
      Text(
        propertyType,
        style: TextStyle(
            fontSize: 20.0, color: Color.fromRGBO(103, 103, 103, 1.0)),
      )
    ]),
  );
}
