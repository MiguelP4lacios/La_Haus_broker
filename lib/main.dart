import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_provider.dart';

import 'package:login_bloc_pattern/src/routes/routes.dart';
import 'package:login_bloc_pattern/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userPref = new UserPreferences();
  await userPref.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userPref = new UserPreferences();
    print(_userPref.token);
    return BlocProvider(
      child: MaterialApp(
        title: 'La Haus Brokers',
        debugShowCheckedModeBanner: false,
        initialRoute: 'introslide',
        routes: getAppRoutes(),
        theme: ThemeData(primaryColor: Color.fromRGBO(0, 208, 174, 1.0)),
      ),
    );
  }
}
