import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';
import 'package:login_bloc_pattern/src/bloc/properties_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.home(context);
    bloc.getProperties();
    return StreamBuilder(
        stream: bloc.connectionStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: _getProperties(bloc),
            //floatingActionButton: _newHouseButton(context, bloc),
            //floatingActionButtonLocation:
            //FloatingActionButtonLocation.centerFloat,
          );
        });
  }

  Widget _getProperties(PropertiesBloc bloc) {
    /* it is in charge to create a widget which will receive all the houses once
    the server have been send the properties or a view soliciting the user
    refresh the page when the http request fails */
    return StreamBuilder(
      stream: bloc.propertiesStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData != true) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data.length == 0) {
          bloc.changeConnection(true);
          return _emptyProperties(bloc);
        } else if (snapshot.data[0] == 'error_connection') {
          bloc.changeConnection(false);
          return _connectionLost(bloc);
        } else {
          bloc.changeConnection(true);
          return _propertyList(bloc, snapshot.data);
        }
      },
    );
  }

  Widget _emptyProperties(bloc) {
    /* This view is showd to the user when it does not have any propertie
    published yet */
    return RefreshIndicator(
      onRefresh: () => bloc.getProperties(),
      child: ListView(
        children: [
          SizedBox(height: 60),
          Image.asset('assets/images/new-property.png'),
          SizedBox(height: 30),
          Center(
            child: Text(
              'Aún no tienes Propiedades publicadas',
              style: TextStyle(
                color: Color.fromRGBO(0, 40, 32, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              'Presiona para comenzar a',
              style: TextStyle(
                color: Color.fromRGBO(0, 40, 32, 0.8),
                fontSize: 18,
              ),
            ),
          ),
          Center(
            child: Text(
              'vender tus inmuebles',
              style: TextStyle(
                color: Color.fromRGBO(0, 40, 32, 0.8),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectionLost(PropertiesBloc bloc) {
    /* If the HTTP response fails, the application manage that error by showing
    this view that ask the user to review his connection and try refeshing the
    app again, thats the reason why this widget is using a refreshindicator */
    return Center(
      child: RefreshIndicator(
        onRefresh: () => bloc.getProperties(),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            Column(
              children: [
                Text(
                  'No se pudo comunicar con el servidor',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 208, 174, 0.4), fontSize: 15),
                ),
                Text(
                  'Verifique su conexión',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 208, 174, 0.4), fontSize: 15),
                ),
                Image.asset(
                  'assets/icons/no-wifi.png',
                  scale: 9,
                  color: Color.fromRGBO(0, 208, 174, 0.3),
                ),
              ],
            ),
            SizedBox(height: 90),
            Column(
              children: [
                Text(
                  'Deslice hacia abajo para refrescar',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 208, 174, 1.0),
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 30),
                Image.asset('assets/icons/down-arrow.png',
                    scale: 6, color: Color.fromRGBO(0, 208, 174, 1.0)),
              ],
            ),
          ],
        ),
      ),
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
            property.rooms,
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
            property.parkingLot,
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
            image: NetworkImage(property.img != null
                ? property.img
                : 'https://cdn.thinglink.me/gfx/icons/missing-thumbnail.png'),
          ),
          SizedBox(height: 10.0),
          address,
          SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [rooms, price]),
          SizedBox(height: 20.0),
        ],
      ),
    );

    return GestureDetector(
      /* This is the shell when the preview of the property will showed to the
      broker, once the user tab in any part of the shell it will be redirected
      to the edit page in which they will can edit the house information or 
      change the photos */
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
}
