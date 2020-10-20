import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/properties_bloc.dart';
import 'package:login_bloc_pattern/src/widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.home(context);
    bloc.getProperties();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: laHausLogo(),
      ),
      body: _getProperties(bloc),
      floatingActionButton: _newHouseButton(context),
    );
  }

  Widget _getProperties(PropertiesBloc bloc) {
    /* it is in charge to create a widget which will receive all the houses once
    the server have been send the properties or a view soliciting the user
    refresh the page when the http request fails */
    return StreamBuilder(
      stream: bloc.propertiesStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return _propertyList(bloc, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
        //TODO: create a condition to show an user advice indicading the http request fail and how to refresh the page
      },
    );
  }

  /* This happen when properties have been retrieved */
  Widget _propertyList(PropertiesBloc bloc, properties) {
    /* Create a list view builder which might contain all the property */
    return RefreshIndicator(
      onRefresh: () => bloc.getProperties(),
      child: ListView.builder(
          itemCount: properties.length,
          itemBuilder: (context, index) {
            return _createProperty(context, bloc, properties[index]);
          }),
    );
  }

  Widget _createProperty(
      BuildContext context, PropertiesBloc bloc, dynamic property) {
    property.state =
        property.state[0].toUpperCase() + property.state.substring(1);
    Color letterGreen = Color.fromRGBO(0, 40, 32, 0.7);
    /* Property elements to show */
    Container address = Container(
      /* address and State */
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '${property.address}  ${property.state}',
        style: TextStyle(
          color: letterGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Container rooms = Container(
      /* Create row of little icons indicating the bathroom numbers, rooms number,
    etc */
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Image.asset(
            'assets/icons/bathroom.png',
            scale: 20,
            color: Colors.grey,
          ),
          Text(
            property.bathrooms,
            style: TextStyle(
              color: Color.fromRGBO(128, 128, 128, 0.5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 15),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/icons/bed.png',
              scale: 17,
              color: Colors.grey,
            ),
          ),
          Text(
            property.bathrooms,
            style: TextStyle(
              color: Color.fromRGBO(128, 128, 128, 0.5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 15),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/icons/parking.png',
              scale: 17,
              color: Colors.grey[400],
            ),
          ),
          Text(
            property.bathrooms,
            style: TextStyle(
              color: Color.fromRGBO(128, 128, 128, 0.5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    Container price = Container(
      /* Price */
      margin: EdgeInsets.only(right: 10),
      child: Text(
        '${property.price.toString()}\$',
        style:
            TextStyle(color: Color.fromRGBO(0, 208, 174, 1.0), fontSize: 25.0),
      ),
    );

    ClipRRect propertyView = ClipRRect(
      /* property view */
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage('assets/login/logo.png'),
            image: NetworkImage(property.img),
          ),
          SizedBox(height: 10.0),
          address,
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [rooms, price]),
          SizedBox(height: 20.0),
          // _propertyButtons(context, bloc, property),
          // SizedBox(height: 10.0),
        ],
      ),
    );

    return GestureDetector(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey[200], spreadRadius: 2.0)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: propertyView,
      ),
      onTap: () {
        Navigator.pushNamed(context, 'edition', arguments: property);
      },
    );
  }

  /* property buttons have been commented until will be defined where do they go
  */
  // /* property buttons */
  // _propertyButtons(BuildContext context, PropertiesBloc bloc, property) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsets.only(right: 20),
  //         child: FloatingActionButton.extended(
  //           heroTag: null,
  //           elevation: 0,
  //           icon: Icon(Icons.delete),
  //           label: Text('Delete'),
  //           backgroundColor: Color.fromRGBO(0, 208, 174, 1.0),
  //           onPressed: () => bloc.deleteProperty(property.id),
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(right: 20),
  //         child: FloatingActionButton.extended(
  //           heroTag: null,
  //           elevation: 0,
  //           icon: Icon(Icons.mode_edit),
  //           label: Text('Edit'),
  //           backgroundColor: Color.fromRGBO(0, 208, 174, 1.0),
  //           onPressed: () => Navigator.popAndPushNamed(
  //             context,
  //             'edition',
  //             arguments: property,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _newHouseButton(BuildContext context) {
    /* Floating button to create a new House
    it goes to the view in charge to create a new one */
    return FloatingActionButton(
      heroTag: null,
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(0, 208, 174, 1.0),
      onPressed: () {
        Navigator.pushNamed(context, 'new_property');
      },
    );
  }

  dispose(bloc) {
    bloc.dispose();
  }
}
