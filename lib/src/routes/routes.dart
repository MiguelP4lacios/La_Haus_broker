import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/pages/bottom_bar.dart';
import 'package:login_bloc_pattern/src/pages/edit_page.dart';
import 'package:login_bloc_pattern/src/pages/form_p1_screen.dart';
import 'package:login_bloc_pattern/src/pages/home_page.dart';
import 'package:login_bloc_pattern/src/pages/initial_page.dart';
import 'package:login_bloc_pattern/src/pages/login_page.dart';
import 'package:login_bloc_pattern/src/pages/photoKitchen_page.dart';
import 'package:login_bloc_pattern/src/pages/phototour_page.dart';
import 'package:login_bloc_pattern/src/pages/register_page.dart';
import 'package:login_bloc_pattern/src/pages/profile.dart';
import 'package:login_bloc_pattern/src/pages/new_property.dart';
import 'package:login_bloc_pattern/src/pages/personal_info.dart';
import 'package:login_bloc_pattern/src/pages/security.dart';
import 'package:login_bloc_pattern/src/pages/settings.dart';
import 'package:login_bloc_pattern/src/pages/get_help.dart';
import 'package:login_bloc_pattern/src/pages/propertyReview_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'edition': (BuildContext context) => EditPage(),
    'form': (BuildContext context) => FormP1Screen(),
    'profile': (BuildContext context) => Perfil(),
    'new_property': (BuildContext context) => PropertyPage(),
    'personal': (BuildContext context) => PersonalPage(),
    'security': (BuildContext context) => SecurityPage(),
    'settings': (BuildContext context) => SettingsPage(),
    'help': (BuildContext context) => HelpPage(),
    'introslide': (BuildContext context) => IntroSlide(),
    'phototour': (BuildContext context) => PhotoTourPage(),
    'phototourKitchen': (BuildContext context) => PhotoKitchen(),
    'propertyReview': (BuildContext context) => PropertyReview(),
    'bottomBar': (BuildContext context) => BottomBar(),
  };
}
