import 'package:flutter/material.dart';

class PropertyReview extends StatelessWidget {
  // const PropertyReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resumen de la propiedad')),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.purple[300]),
            title: Text('Beverly Hills'),
            subtitle: Text('Property located in HollyWood Springs'),
          ),
          Row(
            children: [
              FlatButton(onPressed: () {}, child: Text('Edit')),
              FlatButton(onPressed: () {}, child: Text('Publish')),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Column(
            children: [
              FadeInImage(
                image: NetworkImage(
                    'https://images.adsttc.com/media/images/5be9/fd5c/08a5/e5a5/8c00/008f/medium_jpg/CARLES_FAUS_ARQUITECTURA_-_CARMEN_HOUSE_(2).jpg?1542061390'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                fadeInDuration: Duration(milliseconds: 200),
                height: 300.0,
                fit: BoxFit.cover,
              ),
              Container(
                  padding: EdgeInsets.all(10.0), child: Text('House Sold'))
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.yellowAccent),
            title: Text('Do you want to know more?'),
            subtitle: Text(
                'Please refer to the owner of this house if you want more information'),
          ),
          Row(
            children: [
              FlatButton(onPressed: () {}, child: Text('Cancelar')),
              FlatButton(onPressed: () {}, child: Text('OK')),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ],
      ),
    );
  }

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
