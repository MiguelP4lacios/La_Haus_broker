import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.login(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/login/logoWhite.png',
              scale: 6.0,
            ),
            SizedBox(width: 1.0),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 3.0),
              child: Text('La Haus',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
