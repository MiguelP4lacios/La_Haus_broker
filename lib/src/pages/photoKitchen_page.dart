import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/model/examplesModel.dart';
import 'package:login_bloc_pattern/src/resources/customDialog.dart';
// import 'package:login_bloc_pattern/src/widgets/lateral_menu.dart';
// import 'package:login_bloc_pattern/src/widgets/swipercard_examples.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:login_bloc_pattern/src/providers/property_provider.dart';

// import 'dart:js';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:imagebutton/imagebutton.dart';
// import 'package:image_picker/image_picker.dart';
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
  // List<File> _photos = List<File>();
  // List<String> _photosUrls = List<String>();
  // List<PhotoSource> _photosSources = List<PhotoSource>();
  final propertyProvider = PropertyProvider();
  PickedFile photo;

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
              _title(_screen, context),
              _description(_screen),
              _swiper(context, _screen),
              // _buttons(context),
            ],
          ),
        ),
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
                    icon: Icon(Icons.save_alt),
                    onPressed: _showPictures,
                  ),
                  Text(
                    'Guardar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15.0),
              //   // color: Colors.green[100],
              //   child: Padding(
              //     padding: const EdgeInsets.all(11.0),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20.0),
              //           shape: BoxShape.rectangle,
              //           color: Theme.of(context).primaryColor),
              //       // borderRadius: BorderRadius.circular(100.0)
              //       child: IconButton(
              //         iconSize: 50.0,
              //         icon: Icon(Icons.photo_library, color: Colors.white),
              //         onPressed: _showPictures,
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   // margin: EdgeInsets.symmetric(horizontal: 10.0),
              //   padding: EdgeInsets.symmetric(horizontal: 20.0),
              //   // color: Colors.red[100],
              //   child: FlatButton(
              //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              //     color: Theme.of(context).primaryColor,
              //     // textColor: Colors.black,
              //     onPressed: _showPictures,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20.0)),
              //     child: Text(
              //       'Saltar',
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20.0),
              //     ),
              //   ),
              // ),
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
      child: MaterialButton(
          padding: EdgeInsets.all(0),
          // minWidth: double.infinity,
          onPressed: () => _showOption(context),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                width: double.infinity,
                colorBlendMode: BlendMode.lighten,
                color: Colors.white54,
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/nice_kitchens/k1.jpg',
                ),
              ),
              Text(
                'Presione para realizar toma de fotos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  // Widget _buttons(BuildContext context) {
  //   final _screen = MediaQuery.of(context).size;
  //   return Container(
  //     // alignment: Alignment.bottomCenter,
  //     // color: Colors.amber[100],
  //     width: double.infinity,
  //     height: _screen.height * 0.15,
  //     child: Row(
  //       // crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 15.0),
  //           // color: Colors.green[100],
  //           child: Padding(
  //             padding: const EdgeInsets.all(11.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   shape: BoxShape.rectangle,
  //                   color: Theme.of(context).primaryColor),
  //               // borderRadius: BorderRadius.circular(100.0)
  //               child: IconButton(
  //                 iconSize: 50.0,
  //                 icon: Icon(Icons.photo_library, color: Colors.white),
  //                 onPressed: _showPictures,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           // margin: EdgeInsets.symmetric(horizontal: 10.0),
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           // color: Colors.red[100],
  //           child: FlatButton(
  //             padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
  //             color: Theme.of(context).primaryColor,
  //             // textColor: Colors.black,
  //             onPressed: _showPictures,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20.0)),
  //             child: Text(
  //               'Saltar',
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 20.0),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _showGallery() {
  // // TO-DO: Se debe corregir el codigo.
  //   if ();
  // }

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

                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   // margin: EdgeInsets.symmetric(horizontal: 10.0),
                            //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                            //   color: Colors.red[100],
                            //   child: IconButton(
                            //     iconSize: 40.0,
                            //     icon: Icon(Icons.camera_alt, color: Colors.white),
                            //     onPressed: _showPictures,
                            //   ),

                            // FlatButton(
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 15.0, horizontal: 30.0),
                            //     color: Theme.of(context).primaryColor,
                            //     // textColor: Colors.black,
                            //     onPressed: _showPictures,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(20.0)),
                            //     child: Text('Galeria',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 20.0
                            //             )
                            //             )
                            //             )
                          ))
                    ])
              ]);
        });
  }

  _takePhoto() async {
    _imageProcess(ImageSource.camera);

    final propertyUrl = await propertyProvider.uploadPhoto(photo);

    print(propertyUrl);

    // TODO: RESPUESTA DE BACKEND

    // final pickedFile = await _picker.getImage(...);
    // final File file = File(pickedFile.path);
    // final bytes = await pickedFile.readAsBytes();
  }

  _showPictures() async {
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
    _imageProcess(ImageSource.gallery);
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

  _imageProcess(ImageSource origin) async {
    final _picker = ImagePicker();
    PickedFile photo =
        await _picker.getImage(imageQuality: 100, source: origin);

    if (photo != null) {
      //cleaning
    }
    setState(() {});
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

  Widget _createTile(BuildContext context, ExamplesView examplesView) {
    return ListTile(
      leading: Icon(examplesView.icon),
      title: Text(examplesView.title),
      onTap: () => _exampleCards(context, examplesView),
    );
  }

  // Future<void> retrieveLostData() async {
  //   final _picker = ImagePicker();
  //   final LostData response = await _picker.getLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     if (response.type == RetrieveType.video) {
  //       isVideo = true;
  //       await _playVideo(response.file);
  //     } else {
  //       isVideo = false;
  //       setState(() {
  //         _imageFile = response.file;
  //       });
  //     }
  //   } else {
  //     _retrieveDataError = response.exception.code;
  //   }
  // }
}
