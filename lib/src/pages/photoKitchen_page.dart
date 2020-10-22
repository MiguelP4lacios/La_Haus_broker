import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/model/examplesModel.dart';
import 'package:login_bloc_pattern/src/models/apartment.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:login_bloc_pattern/src/resources/customDialog.dart';
// import 'package:login_bloc_pattern/src/widgets/lateral_menu.dart';
// import 'package:login_bloc_pattern/src/widgets/swipercard_examples.dart';
import 'package:permission_handler/permission_handler.dart';

enum PhotoSource { FILE, NETWORK }

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
  Apartment apartmentId = new Apartment();
  final photoProvider = PhotoProvider();
  PickedFile photo;

  @override
  Widget build(BuildContext context) {
    final Apartment aparData = ModalRoute.of(context).settings.arguments;
    if (aparData != null) {
      apartmentId = aparData;
    }
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
              _title(_screen, context),
              _description(_screen),
              _swiper(context, _screen),
              // _photoExistence(_screen),
              // _buttons(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () => _showOption(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 4.0,
          shape: CircularNotchedRectangle(),
          elevation: 200.0,
          color: Theme.of(context).primaryColor,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    splashColor: Colors.lightGreen[100],
                    color: Colors.white,
                    iconSize: 40.0,
                    icon: Icon(Icons.menu),
                    onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => openBottomDrawer()),
                  ),
                  Text(
                    'Ejemplos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              // SizedBox(width: 15.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    splashColor: Colors.lightGreen[100],
                    color: Colors.white,
                    iconSize: 40.0,
                    icon: Icon(Icons.home),
                    onPressed: () =>
                        Navigator.pushNamed(context, 'propertyReview'),
                  ),
                  Text('Resumen',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ),
              // SizedBox(width: 15.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                    splashColor: Colors.lightGreen[100],
                    color: Colors.white,
                    iconSize: 40.0,
                    icon: Icon(Icons.search),
                    onPressed: _showPictures,
                  ),
                  Text(
                    'Analizar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  // Widget _photoExistence(Size _screen) {
  //   if (apartment.price != null) {
  //     // print(photo);
  //     return Container();
  //   } else {
  //     return Container(
  //         child: Image(
  //             fit: BoxFit.cover,
  //             image: AssetImage(photo?.path ?? _swiper(context, _screen))));
  //   }
  // }

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
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        // color: Colors.brown[200],
        width: double.infinity,
        height: _screen.height * 0.15,
        child: Text(
          'Iniciemos este tour por la propiedad. Te quiaremos por cada lugar tomando las mejores fotos. Recuerda seguir las recomendaciones que te dimos.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
          ),
        ));
  }

  Widget _swiper(BuildContext context, Size _screen) {
    return Container(
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(vertical: 5.0),
        // margin: EdgeInsets.all(40.0),
        // color: Colors.red,
        width: double.infinity,
        height: _screen.height * 0.50,
        child: _decideWhich()
        // MaterialButton(
        //   padding: EdgeInsets.all(0),
        //   // minWidth: double.infinity,
        //   onPressed: () => _showOption(context),
        //   child: _decideWhich(),
        // )
        );
  }

  Widget _decideWhich() {
    if (photo != null) {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Image(
            width: double.infinity,
            colorBlendMode: BlendMode.lighten,
            color: Colors.white54,
            fit: BoxFit.cover,
            image: AssetImage(photo?.path ?? 'assets/no-image.jpg'))
      ]);
    } else {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Image(
          width: double.infinity,
          colorBlendMode: BlendMode.lighten,
          color: Colors.white54,
          fit: BoxFit.cover,
          image: AssetImage('assets/nice_kitchens/k1.jpg'),
        ),
        Text(
          'Presione para realizar toma de fotos',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ]);
    }
  }

  _takePhoto() async {
    // final propData = ModalRoute.of(context).settings.arguments;
    _conditionPermissions(context);

    _imageProcess(ImageSource.camera);
  }

  // final propertyUrl = await photoProvider.uploadPhoto(photo);

  // print(propertyUrl);
  // print(propData);

  // final backEndResp =
  //     await photoProvider.sendPhoto(propertyUrl, context, propData);
  // if (backEndResp == true) {
  //   //alertdialog avisa que ha sido aceptada
  //   //guardar en base de datos
  //   //snackbar
  // } else {
  //   //alert dialog avisa que ha sido rechazada con opciones de tomar de nuevo o
  //   //pregunta si desea obtener foto alert
  //   //
  // }

  // TODO: RESPUESTA DE BACKEND

  // final pickedFile = await _picker.getImage(...);
  // final File file = File(pickedFile.path);
  // final bytes = await pickedFile.readAsBytes();

  _showPictures() async {
    _conditionPermissions(context);
    _imageProcess(ImageSource.gallery);
  }

  _imageProcess(ImageSource origin) async {
    final _picker = ImagePicker();
    PickedFile photo =
        await _picker.getImage(imageQuality: 100, source: origin);

    if (photo != null) {
      //cleaning
    }
    setState(() {});
  }

  void _showOption(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text('¿De donde provendrá la foto?',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              actions: [
                Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        // color: Colors.red[100],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.rectangle,
                                color: Theme.of(context).primaryColor),
                            // borderRadius: BorderRadius.circular(100.0)
                            child: IconButton(
                              iconSize: 40.0,
                              icon: Icon(Icons.camera_alt, color: Colors.white),
                              onPressed: _takePhoto,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          // color: Colors.green[100],
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  color: Theme.of(context).primaryColor),
                              // borderRadius: BorderRadius.circular(100.0)
                              child: IconButton(
                                iconSize: 40.0,
                                icon: Icon(Icons.photo_library,
                                    color: Colors.white),
                                onPressed: _showPictures,
                              ),
                            ),
                          ))
                    ])
              ]);
        });
  }

  void _exampleCards(BuildContext context, ExamplesView examplesView) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 15),
            // insetPadding: EdgeInsets.symmetric(horizontal: 15.0),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(examplesView.description),
            content: examplesView.onTap,
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')),
            ],
          );
        });
  }

  Widget openBottomDrawer() {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: examplesView.length,
        itemBuilder: (context, i) => _createTile(context, examplesView[i]),
      ),
    );
  }

  Widget _createTile(BuildContext context, ExamplesView examplesView) {
    return ListTile(
      leading: Icon(examplesView.icon),
      title: Text(examplesView.title),
      onTap: () => _exampleCards(context, examplesView),
    );
  }

  _conditionPermissions(BuildContext context) async {
    Permission permission;

    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    PermissionStatus permissionStatus = await permission.status;

    print(permissionStatus);

    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.undetermined) {
      permissionStatus = await permission.request();

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context);
      } else {
        permissionStatus = await permission.request();
      }

      if (permissionStatus != PermissionStatus.granted) {
        //Only continue if permission granted
        return;
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      print('Permission granted');
    }
  }

  _showOpenAppSettingsDialog(context) {
    return CustomDialog.show(
      context,
      'Permission needed',
      'Photos permission is needed to select photos',
      'Open settings',
      openAppSettings,
    );
  }
}
