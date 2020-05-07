import 'package:dupledemo/auth.dart';
import 'package:dupledemo/root_page.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Duple Demo App',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home:new RootPage(auth: new Auth())
    );
  }

}