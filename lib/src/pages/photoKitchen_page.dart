import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class PhotoKitchen extends StatelessWidget {
  // const PhotoKitchen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoKitchen2();
  }
}

class PhotoKitchen2 extends StatefulWidget {
  // const PhotoKitchen({Key key}) : super(key: key);
  @override
  _PhotoKitchen2State createState() => _PhotoKitchen2State();
}

class _PhotoKitchen2State extends State<PhotoKitchen2> {
  File photo;

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      // color: Colors.blue[50],
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
      child: Column(
        children: [
          _dotsProgress(_screen),
          // SizedBox(height: 5.0,),
          _title(_screen, context),
          _description(_screen),
          _swiper(_screen),
          _buttons(context),
        ],
      ),
    ));
  }

  Widget _dotsProgress(Size _screen) {
    return Container(
        // color: Colors.amberAccent[100],
        width: double.infinity,
        height: _screen.height * 0.07,
        child: Text('Slide of dots'));
  }

  Widget _title(Size _screen, BuildContext context) {
    return Container(
      width: double.infinity,
      height: _screen.height * 0.10,
      // color: Colors.purple[100],
      alignment: Alignment.center,
      child: Text(
        'Dirigete a la cocina',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _description(Size _screen) {
    return Container(
        alignment: Alignment.center,
        // color: Colors.brown[200],
        width: double.infinity,
        height: _screen.height * 0.1,
        child: Text(
          'Estos son algunos ejemplos de buenas fotos de cocinas.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _swiper(Size _screen) {
    return Container(
        // color: Colors.cyan[300],
        padding: EdgeInsets.all(10.0),
        height: _screen.height * 0.52,
        width: double.infinity,
        child: Image(
            height: 30.0, image: AssetImage('assets/photoTour/cocina.png')));
  }

  Widget _buttons(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Container(
      // alignment: Alignment.bottomCenter,
      // color: Colors.amber[100],
      width: double.infinity,
      height: _screen.height * 0.15,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            // margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            // color: Colors.red[100],
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              textColor: Colors.black,
              onPressed: _showPictures,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Text('Saltar'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            // color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).primaryColor),
                // borderRadius: BorderRadius.circular(100.0)
                child: IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.camera_alt),
                  onPressed: _takePhoto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // _showGallery() {
  // // TO-DO: Se debe corregir el codigo.
  //   if ();
  // }

  _takePhoto() async {
    _imageProcess(ImageSource.camera);

    // final pickedFile = await _picker.getImage(...);
    // final File file = File(pickedFile.path);
    // final bytes = await pickedFile.readAsBytes();
  }

  _showPictures() async {
    _imageProcess(ImageSource.gallery);
  }

  _imageProcess(ImageSource origin) async {
    final _picker = ImagePicker();
    PickedFile photo = await _picker.getImage(source: origin);

    if (photo != null) {
      //cleaning
    }
    setState(() {});
  }
}
