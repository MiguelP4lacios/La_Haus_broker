import 'package:flutter/material.dart';
import 'package:login_bloc_pattern/src/bloc/bloc_form.dart';
export 'package:login_bloc_pattern/src/bloc/bloc_form.dart';
import 'package:login_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:login_bloc_pattern/src/bloc/register_bloc.dart';
export 'package:login_bloc_pattern/src/bloc/login_bloc.dart';

/* Bloc Provider is used to send each bloc
through all the trees in the project 

inherit all the blocs throught each page (view) of the project
so that you can user the streams when you need*/

class BlocProvider extends InheritedWidget {
  static BlocProvider _instance;
  factory BlocProvider({Key key, Widget child}) {
    /* This factory is used to create an instance of the BlocProvider
    which keep the streams in his current state even when the page in
    which it is used has been closed */
    if (_instance == null) {
      _instance = new BlocProvider._internal(key: key, child: child);
    }
    return _instance;
  }
  BlocProvider._internal({Key key, Widget child})
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  /* Bloc instantiations */
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final fromBloc = FormBloc();

  /* Blocs should be here */
  static LoginBloc login(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>().loginBloc;
  }

  static RegisterBloc register(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlocProvider>()
        .registerBloc;
  }

  static FormBloc form(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>().fromBloc;
  }
}
