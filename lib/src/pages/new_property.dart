import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/widgets/app_bar.dart';
import 'globals.dart' as globals;

class PropertyPage extends StatefulWidget {
  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  final int _numPages = 4;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          // Botones superiores (puede ser un appbar)
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Color.fromRGBO(103, 103, 103, 1.0),
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('home');
              },
            ),
            laHausLogo(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.13),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 20), // espacio
          SizedBox(height: 20), // espacio
          Text(
            '¿Qué vas a ofrecer?',
            style: TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(103, 103, 103, 1.0),
                fontWeight: FontWeight.w400),
          ), // fontFamily: 'Raleway',
          SizedBox(height: 50), // espacio
          Container(
            // sección de las imagenes del centro
            width: double.infinity, // ancho automático
            height: 250, // altura específica
            child: PageView(
              // scroll en el centro por defecto horizontal
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              physics:
                  BouncingScrollPhysics(), //para cuando llegue al final no me muestre un círculo de delimiter
              children: <Widget>[
                // Lista del contenido que va a estar en el scroll
                cambiarImagen('assets/images/house.png', 'Casa', context, 1),
                cambiarImagen(
                    'assets/images/building.png', 'Apartamento', context, 2),
                cambiarImagen('assets/images/field.png', 'Finca', context, 3),
                cambiarImagen('assets/images/trees.png', 'Lote', context, 4)
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
          SizedBox(height: 50), // espacio
        ],
      ),
    );
  }
}

// Función para escoger tipo de propiedad
cambiarImagen(
    String imagen, String propertyType, BuildContext context, int idx) {
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
