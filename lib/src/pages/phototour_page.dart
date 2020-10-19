import 'package:flutter/material.dart';

class PhotoTourPage extends StatelessWidget {
  // const PhotoTourPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // color: Colors.green[100],
      width: double.infinity,
      height: double.infinity,
      // height: screen.height * 1,
      // alignment: Alignment.topRight,
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      // margin: EdgeInsets.symmetric(horizontal: 20.0),
      // EdgeInsets.symmetric(vertical: 35.0, horizontal: 35.0),
      child: _wholePage(context),
    ));
  }

  Widget _wholePage(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _title(context),
        SizedBox(height: 5.0),
        _image(context),
        SizedBox(height: 15.0),
        _textRows(screen),
        SizedBox(height: 25.0),
        _comenzarButton(context)
      ],
    );
  }

  Widget _comenzarButton(BuildContext context) {
    return FlatButton(
      textColor: Colors.white,
      onPressed: () => Navigator.pushNamed(context, 'phototourKitchen'),
      child: Text(
        'Comenzar',
        style: TextStyle(fontSize: 18.0),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      // color: Colors.blue[50],
      width: double.infinity,
      // height: screen.height * 0.2,
      // padding: EdgeInsets.symmetric(vertical: 50.0),
      // margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: Text('Llego el momento de tomar las mejores fotografías',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _image(BuildContext context) {
    return Column(
      children: [
        Container(
            // color: Colors.red[50],
            child: Image(image: AssetImage('assets/photoTour/picture1.png'))),
        SizedBox(height: 5.0),
        // Titulo recuerda
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          // color: Colors.yellow[50],
          alignment: Alignment.topLeft,
          child: Text('Recuerda...',
              // textAlign: TextAlign.left,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _textRows(Size screen) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.amberAccent[100],
              child: Image(image: AssetImage('assets/photoTour/limpiar.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),
            // color: Colors.blue[100],
            // margin: EdgeInsets.all(5.0),
            child: Text(
              'Tener todo el espacio ordenado para tener una foto más limpia y de calidad.',
              // overflow: TextOverflow.ellipsis,
              // softWrap: true,
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
      SizedBox(height: 15.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.amberAccent[100],
              child: Image(image: AssetImage('assets/photoTour/phone.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),

            // color: Colors.blue[100],
            // margin: EdgeInsets.all(5.0),
            child: Text(
              'Siempre tomar las fotografías con tu celular en modo horizontal.',
              // overflow: TextOverflow.ellipsis,
              // softWrap: true,
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
      SizedBox(height: 15.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // alignment: Alignment.center,
              // padding: EdgeInsets.all(0),
              // margin: EdgeInsets.all(0),
              // color: Colors.amberAccent[100],
              child: Image(image: AssetImage('assets/photoTour/bulbe.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),
            // color: Colors.blue[100],
            // margin: EdgeInsets.all(5.0),
            child: Text(
              'Una buena iluminación es esencial a la hora de obtener una buena toma.',
              // overflow: TextOverflow.ellipsis,
              // softWrap: true,
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
    ]);
  }
}
