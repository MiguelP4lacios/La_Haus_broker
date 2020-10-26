import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/model/photo_model.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
// import 'globals.dart' as globals;

class PropertyReview extends StatelessWidget {
  // const PropertyReview({Key key}) : super(key: key);
  final photoProvider = new PhotoProvider();

  // final PropertyPhoto propertyPhoto = new PropertyPhoto();

  @override
  Widget build(BuildContext context) {
    // List<PhotoProvider> property;
    // final Object propData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text('Resumen de la Propiedad')),
        body: ListView.builder(
            // property = cardProperty.length,
            itemCount: cardProperty.length,
            itemBuilder: (context, index) {
              // final part = cardProperty;
              // print(cardProperty.length);
              print('starts here');
              print(cardProperty[index].imagesUrl.url);
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
                            cardProperty[index].name,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            onPressed: () => Navigator.pushNamed(
                                context, 'phototourKitchen'),
                            child: Text('Edit')),
                        FlatButton(onPressed: () {}, child: Text('Publish')),
                      ],
                    ),
                    FadeInImage(
                      image: NetworkImage(cardProperty[index].imagesUrl.url),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                    // Image(
                    //   image: NetworkImage(
                    //       'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
                    // ),
                  ],
                ),
              );
            }));

    // _cardTipo1(context, cardProperty),

    //     ListView(
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
    //   );
    // }

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
  }

  // Widget _cardTipo1(BuildContext context, Set<PropertyPhoto> cardProperty) {
  //   return Card(borderOnForeground: ,)

  // }

  // Widget _cardTipo1(BuildContext context, Set<PropertyPhoto> cardProperty) {
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
}
