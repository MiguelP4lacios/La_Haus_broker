import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.login(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Divider(),
          Text('Pass: ${bloc.password}'),
          Container(
            color: Colors.blue,
            child: FloatingActionButton(
                child: Text('press here'),
                onPressed: () => Navigator.pushNamed(context, 'phototour')),
          )
        ],
      ),
    );
  }
}
