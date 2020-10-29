import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/model/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'globals.dart' as globals;

// import 'globals.dart' as globals;

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
    // List<PhotoProvider> property;
    // final Object propData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.pushReplacementNamed(context, 'home')),
          title: Text('Resumen de la Propiedad')),
      body: _list(_screen),
    );
  }

  Widget _list(Size _screen) {
    print('largo del review');
    // print(mapload.toString().length);
    // print(mapload);
    // print(mapload);
    return ListView.builder(
        itemCount: defaultList.length,
        itemBuilder: (context, index) {
          // print(cardPro[index].url);
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
                _imageValidation(cardPro[index].id, cardPro[index].place,
                    cardPro[index].url, _screen),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                      onPressed: () {
                        // photoModel.agregar(defaultList[index].part,
                        //     "https://res.cloudinary.com/babylist/image/upload/f_auto,q_auto:best,c_scale,w_768/v1512679429/best_cribs_header_xzdciu.jpg");
                        setState(() {});
                        Navigator.pushNamed(context, 'phototourKitchen',
                            arguments: defaultList[index].part);
                      },
                      child: Text('Agregar fotos')),
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

  Widget _imageValidation(
      List<String> id, String place, List<String> url, Size screen) {
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
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(url[index]),
                    ),
                    IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        photoProvider.deletePhoto(
                            id[index],
                            globals.jsonProperty[
                                'id']); // TODO: REPLANTEAR PHOTO MODEL.
                        photoModel.eliminar(place, url[index], id[index]);
                        setState(() {}); // para la lista
                      },
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

// ListView(
//       padding: EdgeInsets.all(10.0),
//       children: <Widget>[
//         _cardTipo1(context),
//         SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//         // _cardTipo2(),
//         // SizedBox(height: 30.0),
//       ],
//     ),

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
