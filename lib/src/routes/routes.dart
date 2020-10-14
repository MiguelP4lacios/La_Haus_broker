import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/pages/login_page.dart';
import 'package:login_bloc_pattern/src/pages/homa_page.dart';
import 'package:login_bloc_pattern/src/pages/register_page.dart';
import 'package:login_bloc_pattern/src/pages/profile.dart';
import 'package:login_bloc_pattern/src/pages/new_property.dart';
import 'package:login_bloc_pattern/src/pages/personal_info.dart';
import 'package:login_bloc_pattern/src/pages/security.dart';
import 'package:login_bloc_pattern/src/pages/settings.dart';
import 'package:login_bloc_pattern/src/pages/get_help.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'login'   : (BuildContext context) => LoginPage(),
    'home'    : (BuildContext context) => HomePage(),
    'register': (BuildContext context) => RegisterPage(),
    'profile' : ( BuildContext context ) => Perfil(),
    'property': ( BuildContext context ) => PropertyPage(),
    'personal': ( BuildContext context ) => PersonalPage(),
    'security': ( BuildContext context ) => SecurityPage(),
    'settings': ( BuildContext context ) => SettingsPage(),
    'help': ( BuildContext context ) => HelpPage(),
  };
}
