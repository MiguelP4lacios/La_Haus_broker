import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/models/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'globals.dart' as globals;

class PropertyReview extends StatefulWidget {
  // const PropertyReview({Key key}) : super(key: key);
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
    print('largo del review');
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
                        // photoModel.agregar(defaultList[index].part,
                        //     "https://res.cloudinary.com/babylist/image/upload/f_auto,q_auto:best,c_scale,w_768/v1512679429/best_cribs_header_xzdciu.jpg");
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
                  // FlatButton(
                  //   onPressed: () => Navigator.pushReplacementNamed(
                  //       context, 'phototourKitchen'),
                  //   child: Text('Agregar mas fotos'),
                  // ),
                ]),
                // Image(
                //   image: NetworkImage(
                //       'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
                // ),
              ],
            ),
          );
        });
  }

  Widget _imageValidation(List<String> id, String place, List<String> url,
      Size screen, List<bool> foco, List<bool> ilum) {
    // swiper
    if (url.length != 0) {
      return Swiper(
        // viewportFraction: 2.0,
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
                      // height: screen.height * 0.37,
                      // width: screen.width * 0.7,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(url[index]),
                    ),
                    photoFeedback(
                        id[index], place, url[index], foco[index], ilum[index]),
                    Container(
                      margin: EdgeInsets.only(
                          left: 350, top: 3, right: 3, bottom: 350),
                      height: 30,
                      width: 40.0,
                      child: IconButton(
                        color: Colors.black,
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _dialogBin(id[index], globals.jsonProperty['id'],
                              place, url[index], foco[index], ilum[index]);
                          // photoProvider.deletePhoto(
                          //     id[index],
                          //     globals.jsonProperty['id']);
                          // photoModel.eliminar(place, url[index], id[index]);
                          // setState(() {}); // para la lista
                        },
                      ),
                    ),
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
          title: Text('¿Desea eliminar esta foto?',
              style: TextStyle(fontSize: 20.0)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
          ],
          // actions: List<Widget> [
        );
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

// Widget _createList() {
//   return FutureBuilder(
//       future: photoProvider.loadProperty(),
//       builder:
//           (BuildContext context, AsyncSnapshot<List<Apartment>> snapshot) {
//         if (snapshot.hasData) {
//           final apartments = snapshot.data;
//           return ListView.builder(
//               itemCount: apartments.length,
//               itemBuilder: (context, i) =>
//                   _cardTipo1(context, apartments[i]));
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       });
// }

// Widget _cardTipo2() {
//   return Card(
//     elevation: 10.0,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//     clipBehavior: Clip.antiAlias,
//     child: Column(
//       children: <Widget>[
//         FadeInImage(
//           image: NetworkImage(
//               'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
//           placeholder: AssetImage('assets/jar-loading.gif'),
//           fadeInDuration: Duration(milliseconds: 200),
//           height: 300.0,
//           fit: BoxFit.cover,
//         ),
//         // Image(
//         //   image: NetworkImage(
//         //       'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
//         // ),
//         Container(
//             padding: EdgeInsets.all(10.0),
//             child: Text('Fuji Mountain -Japan'))
//       ],
//     ),
//   );
// }));

// Widget _cardTipo1(BuildContext context, Set<PropertyPhoto> cardProp) {
//   return Card(borderOnForeground: ,)

// }

// Widget _cardTipo1(BuildContext context, Set<PropertyPhoto> cardProp) {
//   // final propertyMap = globals.propertyTour;
//   return Card(
//     elevation: 10.0,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//     child: Column(
//       children: [
//         ListTile(
//           title: Text("${widget.steps[index][part]}"),
//           // subtitle: Text('Property located in HollyWood Springs'),
//         ),
//         Row(
//           children: [
//             FlatButton(
//                 onPressed: () =>
//                     Navigator.pushNamed(context, 'phototourKitchen'),
//                 child: Text('Edit')),
//             FlatButton(onPressed: () {}, child: Text('Publish')),
//           ],
//           mainAxisAlignment: MainAxisAlignment.end,
//         ),
//         Column(
//           children: [
//             FadeInImage(
//               image: AssetImage('assets/nice_kitchens/k7.jpg'),
//               placeholder: AssetImage('assets/jar-loading.gif'),
//               fadeInDuration: Duration(milliseconds: 200),
//               height: 300.0,
//               fit: BoxFit.cover,
//             ),
//             Container(
//                 padding: EdgeInsets.all(10.0), child: Text('House Sold'))
//           ],
//         ),
//       ],
//     ),
//   );
// }
