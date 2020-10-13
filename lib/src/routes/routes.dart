import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/pages/homa_page.dart';
import 'package:login_bloc_pattern/src/pages/login_page.dart';
import 'package:login_bloc_pattern/src/pages/register_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
  };
}
