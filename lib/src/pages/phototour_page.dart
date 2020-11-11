import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:login_bloc_pattern/src/models/photo_model.dart';

import 'globals.dart' as globals;

class PhotoTourPage extends StatelessWidget {
  // const PhotoTourPage({Key key}) : super(key: key);
  final photoProvider = PhotoProvider();
  final photoModel = Photo();

  @override
  Widget build(BuildContext context) {
    // here the list stored in the device is erased to be filled again.
    photoModel.resetList();
    photoProvider.getAllPhotos(globals.jsonProperty['id'].toString());
    // request the photos from back-end from a specific property
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: _wholePage(context),
    ));
  }

  Widget _wholePage(BuildContext context) {
    // renders the whole view.
    final screen = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // describes the title
        _title(context),
        // renders the pic to this view
        _image(context),
        // Row of suggestions to the user
        _textRows(screen),
        // Button to start process
        _comenzarButton(context)
      ],
    );
  }

  Widget _comenzarButton(BuildContext context) {
    // button to start process and pass to the review page of picture taking
    return FlatButton(
      textColor: Colors.white,
      onPressed: () => Navigator.pushNamed(context, 'propertyReview'),
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
    // title of the page
    return Container(
      width: double.infinity,
      child: Text('Llego el momento de tomar las mejores fotografías',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _image(BuildContext context) {
    // render the picture of the page
    return Column(
      children: [
        Container(
            child: Image(image: AssetImage('assets/photoTour/picture1.png'))),
        SizedBox(height: 5.0),
        // Titulo recuerda
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          alignment: Alignment.topLeft,
          child: Text('Ten en cuenta...',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _textRows(Size screen) {
    // Row of suggestions to the user
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child: Image(image: AssetImage('assets/photoTour/limpiar.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Tener todo el espacio ordenado para tener una foto más limpia y de calidad.',
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
      SizedBox(height: 15.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child: Image(image: AssetImage('assets/photoTour/phone.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Siempre tomar las fotografías con tu celular en modo horizontal.',
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
      SizedBox(height: 15.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child: Image(image: AssetImage('assets/photoTour/bulbe.png'))),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: screen.width * 0.7,
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Una buena iluminación es esencial a la hora de obtener una buena toma.',
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
    ]);
  }
}
