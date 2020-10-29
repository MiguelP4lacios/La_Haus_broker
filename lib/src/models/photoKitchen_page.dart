import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'examplesModel.dart';
// import 'package:login_bloc_pattern/src/models/apartment.dart';
// import 'package:login_bloc_pattern/src/pages/globals.dart';
// import 'package:path/path.dart' as path;
import 'package:login_bloc_pattern/src/models/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:login_bloc_pattern/src/resources/customDialog.dart';
// import 'package:login_bloc_pattern/src/widgets/lateral_menu.dart';
// import 'package:login_bloc_pattern/src/widgets/swipercard_examples.dart';
import 'package:permission_handler/permission_handler.dart';
import '../pages/globals.dart' as globals;

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
  static String photoId;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final photoProvider = PhotoProvider();
  final photoModel = Photo();
  File photoImage;

  @override
  Widget build(BuildContext context) {
    final String propertyPlace = ModalRoute.of(context).settings.arguments;
    print(propertyPlace);
    // if (aparData != null) {
    //   apartmentId = aparData;
    // }
    // final propData = ModalRoute.of(context).settings.arguments;
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        // color: Colors.blue[50],
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
        child: Column(
          children: [
            _title(_screen, context),
            _description(_screen),
            SizedBox(height: 20.0),
            _swiper(context, _screen),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () => _showOption(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
                Text('Ejemplos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center)
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
                    onPressed: () async {
                      // _dialogWaiting(context);
                      // Future.delayed(Duration(seconds: 2));
                      final Map sub = await _submit(propertyPlace);
                      if (sub['foco'] == true && sub['ilum'] == true) {
                        _dialogAcceptance(context, sub, propertyPlace);
                      } else {
                        _dialogFocoWrong(context, sub, propertyPlace);
                      }
                    }),
                Text(
                  'Analizar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _takePhoto() async {
    // final propData = ModalRoute.of(context).settings.arguments;
    _conditionPermissions(context);
    _imageProcess(ImageSource.camera);
  }

  _showPictures() async {
    _conditionPermissions(context);
    _imageProcess(ImageSource.gallery);
  }

  _imageProcess(ImageSource origin) async {
    final _picker = ImagePicker();
    final PickedFile _photo = await _picker.getImage(source: origin);
    if (_photo == null) return;

    File photo = File(_photo.path);
    // {
    //   Navigator.pushReplacementNamed(context, 'phototourKitchen');
    //   print('MISTAKE');
    // }
    // print(photo.path + '    first');
    // print(photo.path);
    // final String pathImg = await getApplicationDocumentsDirectory().path;
    // final String fileName = path.basename(photo.path);

    setState(() {
      photoImage = photo;
    });
    // print(photo.path + '   text');
    // Navigator.pushReplacementNamed(context, 'phototourKitchen',
    //     arguments: photo);
  }

  Future<Map> _submit(String propertyPlace) async {
    // final File image = ModalRoute.of(context).settings.arguments;
    print('here');
    print(photoImage);
    if (photoImage != null) {
      final String picUrl = await photoProvider.uploadPhoto(photoImage);
      print(picUrl);
      if (picUrl == null) {
        showSnackbar('No se pudo enviar foto');
        return null;
      }
      showSnackbar('Foto Enviada');
      print(globals.jsonProperty['id']);
      photoId = await photoProvider.sendPhoto(
          picUrl, globals.jsonProperty['id'].toString(), propertyPlace);
      final Map acceptance = await photoProvider.getInfoPhoto(
          photoId, globals.jsonProperty['id'].toString());
      return acceptance;
      // animation of waiting
      // sendPhoto - ya recibio url de la nube y la envioa a heroapp
      // alertDialog con
    }
    return null;
  }

  void showSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _title(Size _screen, BuildContext context) {
    return Container(
      width: double.infinity,
      height: _screen.height * 0.08,
      // color: Colors.purple[100],
      alignment: Alignment.center,
      child: Text(
        'Dirigete al lugar.',
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
        height: _screen.height * 0.20,
        child: Text(
          'Las fotos dependen mucho de la iluminacion y ubicacion del receptor. Ubica tu dispositivo en modo horizontal para realizar tomas planas. Recuerda seguir las recomendaciones que te dimos.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 17.0,
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
        height: _screen.height * 0.48,
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
    // final File image = ModalRoute.of(context).settings.arguments;
    print(photoImage);
    if (photoImage == null) {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Image(
          width: double.infinity,
          // colorBlendMode: BlendMode.lighten,
          // color: Colors.white54,
          fit: BoxFit.cover,
          height: 300.0,
          image: AssetImage('assets/source.gif'),
        ),
      ]);
    } else {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Image(
          width: double.infinity,
          height: 300.0,
          // colorBlendMode: BlendMode.lighten,
          // color: Colors.white54,
          fit: BoxFit.scaleDown,
          image: FileImage(photoImage),
        ),
        // Text(
        //   'Presione para realizar toma de fotos',
        //   style: TextStyle(
        //     fontSize: 20.0,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
      ]);
    }
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
                                icon:
                                    Icon(Icons.camera_alt, color: Colors.white),
                                onPressed: () {
                                  _takePhoto();
                                  Navigator.of(context).pop();
                                  // Navigator.pushReplacementNamed(
                                  //     context, 'phototourKitchen');
                                }),
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
                                  onPressed: () {
                                    _showPictures();
                                    Navigator.of(context).pop();
                                    // Navigator.pushReplacementNamed(
                                    //     context, 'phototourKitchen');
                                  }),
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

  // void _dialogWaiting(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         Future.delayed(Duration(seconds: 5), () {
  //           Navigator.of(context).pop(true);
  //         });
  //         return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0)),
  //             title: Text('Analizando...',
  //                 style: TextStyle(color: Theme.of(context).primaryColor)),
  //             actions: [
  //               Column(children: [
  //                 Image(
  //                   image: AssetImage('assets/loading.gif'),
  //                 ),
  //                 FlatButton(
  //                   child: Text(
  //                     'OK',
  //                     style: TextStyle(fontSize: 18.0),
  //                   ),
  //                   onPressed: () => Navigator.of(context).pop(),
  //                 )
  //               ])
  //             ]);
  //       });
  // }

  void _dialogAcceptance(BuildContext context, Map sub, String propertyPlace) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              actions: [
                Column(children: [
                  Image(
                    image: AssetImage('assets/accept.gif'),
                  ),
                  FlatButton(
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        photoModel.agregar(propertyPlace, sub['url'], photoId);
                        // globals.propertyPlace['place'] = globals.place;
                        // globals.propertyPlace['url'] = sub['url'];
                        Navigator.pushReplacementNamed(
                            context, 'propertyReview');
                      })
                ])
              ]);
        });
  }

  void _dialogFocoWrong(BuildContext context, Map sub, String propertyPlace) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: [_dialogDeci(context, sub, propertyPlace)],
          // actions: List<Widget> [
        );
      },
    );
  }

  Widget _dialogDeci(BuildContext context, Map sub, String propertyPlace) {
    if (sub['foco'] == false && sub['ilum'] == true) {
      return Column(children: [
        Text(
          'Lo sentimos, su foto no fue aceptada por foco, por favor intente de nuevo',
          style: TextStyle(fontSize: 12.0),
        ),
        FlatButton(
            onPressed: () {
              photoProvider.deletePhoto(
                  photoId, globals.jsonProperty['id'].toString());
              _showOption(context);
              Future.delayed(Duration(seconds: 5), () {
                Navigator.of(context).pop(true);
              });
              // Navigator.of(context, rootNavigator: true).pop();
              // Navigator.pushReplacementNamed(context, 'phototourKitchen');
            },
            child: Text('¿Tomar de nuevo?', style: TextStyle(fontSize: 18.0))),
        FlatButton(
          onPressed: () {
            photoModel.agregar(propertyPlace, sub['url'], photoId);
            Navigator.pushReplacementNamed(context, 'propertyReview');
          },
          child: Text(
            'Guardar',
            style: TextStyle(fontSize: 18.0),
          ),
        )
      ]);
    } else if (sub['foco'] == true && sub['ilum'] == false) {
      return Column(children: [
        Text(
          'Lo sentimos, su foto no fue aceptada por iluminación, por favor intente de nuevo',
          style: TextStyle(fontSize: 12.0),
        ),
        FlatButton(
            child: Text(
              '¿Tomar de nuevo?',
              style: TextStyle(fontSize: 18.0),
            ),
            onPressed: () {
              photoProvider.deletePhoto(
                  photoId, globals.jsonProperty['id'].toString());
              _showOption(context);
              Future.delayed(Duration(seconds: 5), () {
                Navigator.of(context).pop(true);
              });
              // Navigator.of(context, rootNavigator: true).pop();
              // Navigator.of(context).pop();
            }),
        FlatButton(
            child: Text(
              'Guardar',
              style: TextStyle(fontSize: 18.0),
            ),
            onPressed: () {
              photoModel.agregar(propertyPlace, sub['url'], photoId);
              Navigator.pushReplacementNamed(context, 'propertyReview');
            })
      ]);
    } else {
      return Column(children: [
        Text(
          'Lo sentimos, su foto no fue aceptada por foco e iluminación, intente de nuevo',
          style: TextStyle(fontSize: 12.0),
        ),
        FlatButton(
          onPressed: () {
            photoProvider.deletePhoto(
                photoId, globals.jsonProperty['id'].toString());
            _showOption(context);
            Future.delayed(Duration(seconds: 5), () {
              Navigator.of(context).pop(true);
            });
            // Navigator.of(context).pop();
            // Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            '¿Tomar de nuevo?',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        FlatButton(
          onPressed: () {
            photoModel.agregar(propertyPlace, sub['url'], photoId);
            Navigator.pushReplacementNamed(context, 'propertyReview');
          },
          child: Text(
            'Guardar',
            style: TextStyle(fontSize: 18.0),
          ),
        )
      ]);
    }
  }
}
