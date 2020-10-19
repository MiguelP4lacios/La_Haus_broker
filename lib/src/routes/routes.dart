import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/pages/homa_page.dart';
import 'package:login_bloc_pattern/src/pages/initial_page.dart';
import 'package:login_bloc_pattern/src/pages/login_page.dart';
import 'package:login_bloc_pattern/src/pages/photoKitchen_page.dart';
import 'package:login_bloc_pattern/src/pages/phototour_page.dart';
import 'package:login_bloc_pattern/src/pages/register_page.dart';
import 'package:login_bloc_pattern/src/pages/propertyReview_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'introslide': (BuildContext context) => IntroSlide(),
    'phototour': (BuildContext context) => PhotoTourPage(),
    'phototourKitchen': (BuildContext context) => PhotoKitchen(),
    'propertyReview': (BuildContext context) => PropertyReview(),
  };
}
