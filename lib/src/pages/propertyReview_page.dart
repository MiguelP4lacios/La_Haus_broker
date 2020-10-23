import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/models/apartment.dart';
import 'package:login_bloc_pattern/src/providers/photo_provider.dart';
// import 'globals.dart' as globals;

class PropertyReview extends StatelessWidget {
  // const PropertyReview({Key key}) : super(key: key);
  final photoProvider = new PhotoProvider();

  @override
  Widget build(BuildContext context) {
    // final Object propData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Resumen de la Propiedad')),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(context),
          SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
          // _cardTipo2(),
          // SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _cardTipo1(BuildContext context) {
    // final propertyMap = globals.propertyTour;

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.purple[300]),
            title: Text('propertyMap'),
            // subtitle: Text('Property located in HollyWood Springs'),
          ),
          Row(
            children: [
              FlatButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'phototourKitchen'),
                  child: Text('Edit')),
              FlatButton(onPressed: () {}, child: Text('Publish')),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Column(
            children: [
              FadeInImage(
                image: AssetImage('assets/nice_kitchens/k7.jpg'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                fadeInDuration: Duration(milliseconds: 200),
                height: 300.0,
                fit: BoxFit.cover,
              ),
              Container(
                  padding: EdgeInsets.all(10.0), child: Text('House Sold'))
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _cardTipo2() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          // Image(
          //   image: NetworkImage(
          //       'https://static.photocdn.pt/images/articles/2018/03/20/articles/2017_8/Natural_Night.jpg'),
          // ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Fuji Mountain -Japan'))
        ],
      ),
    );
  }
}
