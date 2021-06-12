import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_sembast/bloc/fruit_bloc.dart';
import 'package:flutter_fruit_sembast/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FruitBloc>(
        create: (context) => FruitBloc(),
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.lime, accentColor: Colors.limeAccent),
          home: HomePage(),
        ));
  }
}
