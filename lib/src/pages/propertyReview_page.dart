import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/models/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'globals.dart' as globals;

class PropertyReview extends StatefulWidget {
  /// const PropertyReview({Key key}) : super(key: key);
  @override
  _PropertyReviewState createState() => _PropertyReviewState();
}

class _PropertyReviewState extends State<PropertyReview> {
  final photoProvider = new PhotoProvider();
  final photoModel = Photo();

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'bottomBar')),
          title: Text(
            'Resumen de la Propiedad',
          )),
      body: _list(_screen),
    );
  }

  Widget _list(Size _screen) {
    /// render empty tiles based on a default list
    return ListView.builder(
        itemCount: defaultList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        defaultList[index].part,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _imageValidation(
                    cardPro[index].id,
                    cardPro[index].place,
                    cardPro[index].url,
                    _screen,
                    cardPro[index].foco,
                    cardPro[index].ilum),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pushNamed(context, 'phototourKitchen',
                            arguments: defaultList[index].part);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          margin: EdgeInsets.all(10.0),
                          child: Text('Agregar fotos',
                              style: TextStyle(color: Colors.white)))),
                ]),
              ],
            ),
          );
        });
  }

  Widget _imageValidation(List<String> id, String place, List<String> url,
      Size screen, List<bool> foco, List<bool> ilum) {
    // swiper and validation to the feedback to the user
    if (url.length != 0) {
      return Swiper(
        loop: false,
        containerWidth: 1.0,
        containerHeight: 1.0,
        layout: SwiperLayout.STACK,
        itemWidth: screen.width * 1,
        itemHeight: screen.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(url[index]),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 290, top: 3, right: 3, bottom: 250),
                      child: IconButton(
                        color: Colors.black,
                        alignment: Alignment.center,
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _dialogBin(id[index], globals.jsonProperty['id'],
                              place, url[index], foco[index], ilum[index]);
                        },
                      ),
                    ),
                    photoFeedback(
                        id[index], place, url[index], foco[index], ilum[index]),
                  ],
                ),
              ));
        },
        itemCount: url.length,
        pagination: new SwiperPagination(),
      );
    } else {
      return FadeInImage(
          image: AssetImage('assets/no-image.jpg'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          height: 300.0,
          fit: BoxFit.cover);
    }
  }

  Widget photoFeedback(
      String id, String place, String url, bool foco, bool ilum) {
    // decides the feedback of each picture to the user
    if (foco == true && ilum == false) {
      return processComparison('assets/images/foc-no-ilu-w.png');
    } else if (foco == false && ilum == true) {
      return processComparison('assets/images/ilu-no-foc-w.png');
    } else if (foco == false && ilum == false) {
      return processComparison('assets/images/no-foc-no-ilu-w.png');
    } else {
      return processComparison('assets/images/foc-ilu-w.png');
    }
  }

  Widget processComparison(String photoPath) {
    // optimization to the previous method
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              alignment: Alignment.topLeft,
              image: AssetImage(photoPath),
              height: 40),
        ]);
  }

  void _dialogBin(String id, String propId, String place, String url, bool foco,
      bool ilum) {
    // Alert Dialog which shows whether the user wants to erase a pic or not
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text('¿Desea eliminar esta foto?',
                style: TextStyle(fontSize: 20.0)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            actions: [
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                    photoProvider.deletePhoto(id, propId);
                    photoModel.eliminar(place, url, id, foco, ilum);
                    setState(() {});
                  },
                  child: Text('Si',
                      style: TextStyle(fontSize: 20.0, color: Colors.white))),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('No',
                      style: TextStyle(fontSize: 20.0, color: Colors.white))),
            ]);
      },
    );
  }
  // para la lista
}

class DefaultList {
  String part;
  DefaultList({this.part});
}

final List<DefaultList> defaultList = [
  DefaultList(part: "Frente"),
  DefaultList(part: "Cocina"),
  DefaultList(part: "Zona Social"),
  DefaultList(part: "Comedor"),
  DefaultList(part: "Cuartos"),
  DefaultList(part: "Baños"),
  DefaultList(part: "Exteriores"),
];
