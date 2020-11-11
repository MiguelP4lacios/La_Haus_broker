import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'examplesModel.dart';
import 'package:login_bloc_pattern/src/models/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:login_bloc_pattern/src/resources/customDialog.dart';
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
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                    splashColor: Colors.lightGreen[100],
                    color: Colors.white,
                    iconSize: 40.0,
                    icon: Icon(Icons.save_alt),
                    onPressed: () async {
                      final Map sub = await _submit(propertyPlace);
                      if (sub['foco'] == true && sub['ilum'] == true) {
                        _dialogAcceptance(context, sub, propertyPlace);
                      } else {
                        _dialogFocoWrong(context, sub, propertyPlace);
                      }
                    }),
                Text(
                  'Guardar',
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
    //Method to take the photo using device's camera
    _conditionPermissions(context);
    _imageProcess(ImageSource.camera);
  }

  _showPictures() async {
    // Method to show the photo stored in the device
    _conditionPermissions(context);
    _imageProcess(ImageSource.gallery);
  }

  _imageProcess(ImageSource origin) async {
    // method to optimize previous methods
    final _picker = ImagePicker();
    final PickedFile _photo = await _picker.getImage(source: origin);
    if (_photo == null) return;
    File photo = File(_photo.path);
    setState(() {
      photoImage = photo;
    });
  }

  Future<Map> _submit(String propertyPlace) async {
    // Buttom to send the picture taken for being analyzed
    if (photoImage != null) {
      final String picUrl = await photoProvider.uploadPhoto(photoImage);
      if (picUrl == null) {
        showSnackbar('No se pudo enviar foto');
        return null;
      }
      showSnackbar('Foto Enviada');
      photoId = await photoProvider.sendPhoto(
          picUrl, globals.jsonProperty['id'].toString(), propertyPlace);
      final Map acceptance = await photoProvider.getInfoPhoto(
          photoId, globals.jsonProperty['id'].toString());
      return acceptance;
    }
    return null;
  }

  void showSnackbar(String mensaje) {
    // feedbacks the user that the photo was sent
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _title(Size _screen, BuildContext context) {
    // Text to take the user to place to be shot
    return Container(
      width: double.infinity,
      height: _screen.height * 0.08,
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
    // descrition of what the user should do
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
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
    // renders the list of examples photos.
    return Container(
        width: double.infinity,
        height: _screen.height * 0.48,
        child: _decideWhich());
  }

  Widget _decideWhich() {
    // renders the pciture whether it is taken or not.
    if (photoImage == null) {
      return Stack(alignment: Alignment.center, children: <Widget>[
        Image(
          width: double.infinity,
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
          fit: BoxFit.scaleDown,
          image: FileImage(photoImage),
        ),
      ]);
    }
  }

  void _showOption(BuildContext context) {
    // asks the user in an AlertDialog whether to store the photo or to take another
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Text('¿De donde provendrá la foto?',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              actions: [
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            shape: BoxShape.rectangle,
                            color: Theme.of(context).primaryColor),
                        child: IconButton(
                            iconSize: 40.0,
                            icon: Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: () {
                              _takePhoto();
                              Navigator.of(context).pop();
                            }),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).primaryColor),
                          child: IconButton(
                              iconSize: 40.0,
                              icon: Icon(Icons.photo_library,
                                  color: Colors.white),
                              onPressed: () {
                                _showPictures();
                                Navigator.of(context).pop();
                              }),
                        ),
                      ))
                ])
              ]);
        });
  }

  void _exampleCards(BuildContext context, ExamplesView examplesView) {
    // renders the photos from a list (examples)
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 15),
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
    // the drawer where the examples photos are
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: examplesView.length,
        itemBuilder: (context, i) => _createTile(context, examplesView[i]),
      ),
    );
  }

  Widget _createTile(BuildContext context, ExamplesView examplesView) {
    // creates the tile for every group of examples photos
    return ListTile(
      leading: Icon(examplesView.icon),
      title: Text(examplesView.title),
      onTap: () => _exampleCards(context, examplesView),
    );
  }

  _conditionPermissions(BuildContext context) async {
    // asks permission to use the device's camera
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
    // relates a dialog to show what permission is needed
    return CustomDialog.show(
      context,
      'Permission needed',
      'Photos permission is needed to select photos',
      'Open settings',
      openAppSettings,
    );
  }

  void _dialogAcceptance(BuildContext context, Map sub, String propertyPlace) {
    // it feedbacks the user if the pic is well taken
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              actions: [
                Column(children: [
                  Image(image: AssetImage('assets/accept.gif')),
                  FlatButton(
                      child: Text('OK', style: TextStyle(fontSize: 18.0)),
                      onPressed: () {
                        photoModel.agregar(propertyPlace, sub['url'], photoId,
                            sub['foco'], sub['ilum']);
                        Navigator.pushReplacementNamed(
                            context, 'propertyReview');
                      })
                ])
              ]);
        });
  }

  void _dialogFocoWrong(BuildContext context, Map sub, String propertyPlace) {
    // feedback the user if the pic was not taken well
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: [_dialogDeci(context, sub, propertyPlace)],
        );
      },
    );
  }

  Widget _dialogDeci(BuildContext context, Map sub, String propertyPlace) {
    // continues evaluating previous method
    if (sub['foco'] == false && sub['ilum'] == true) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Lo sentimos, su foto no fue aceptada por foco, por favor intente de nuevo',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  photoProvider.deletePhoto(
                      photoId, globals.jsonProperty['id'].toString());
                  _showOption(context);
                  Future.delayed(Duration(seconds: 5), () {
                    Navigator.of(context).pop(true);
                  });
                },
                child: Text('¿Tomar de nuevo?',
                    style: TextStyle(fontSize: 14.0, color: Colors.white))),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                photoModel.agregar(propertyPlace, sub['url'], photoId,
                    sub['foco'], sub['ilum']);
                Navigator.pushReplacementNamed(context, 'propertyReview');
              },
              child: Text(
                'Guardar de todos modos',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            )
          ]);
    } else if (sub['foco'] == true && sub['ilum'] == false) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Lo sentimos, su foto no fue aceptada por iluminación, por favor intente de nuevo',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  '¿Tomar de nuevo?',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                onPressed: () {
                  photoProvider.deletePhoto(
                      photoId, globals.jsonProperty['id'].toString());
                  _showOption(context);
                  Future.delayed(Duration(seconds: 5), () {
                    Navigator.of(context).pop(true);
                  });
                }),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Guardar de todos modos',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                onPressed: () {
                  photoModel.agregar(propertyPlace, sub['url'], photoId,
                      sub['foco'], sub['ilum']);
                  Navigator.pushReplacementNamed(context, 'propertyReview');
                })
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Lo sentimos, su foto no fue aceptada por foco e iluminación, intente de nuevo',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                photoProvider.deletePhoto(
                    photoId, globals.jsonProperty['id'].toString());
                _showOption(context);
                Future.delayed(Duration(seconds: 5), () {
                  Navigator.of(context).pop(true);
                });
              },
              child: Text(
                '¿Tomar de nuevo?',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                photoModel.agregar(propertyPlace, sub['url'], photoId,
                    sub['foco'], sub['ilum']);
                Navigator.pushReplacementNamed(context, 'propertyReview');
              },
              child: Text(
                'Guardar de todos modos',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            )
          ]);
    }
  }
}
