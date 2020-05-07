
import 'package:dupledemo/LoginPage.dart';
import 'package:dupledemo/auth.dart';
import 'package:dupledemo/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {

  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
  }

  enum AuthStatus{
    notSignedIn,
    signedIn

  }

  class _RootPageState extends State<RootPage>{

    AuthStatus _authStatus=AuthStatus.notSignedIn;

    @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userID){
      setState(() {
       _authStatus= userID == null ? AuthStatus.notSignedIn:AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
      setState(() {
        _authStatus=AuthStatus.signedIn;
      });
  }
  void _signOut(){
      setState(() {
        _authStatus=AuthStatus.notSignedIn;
      });

  }

    @override
    Widget build(BuildContext context) {
   if(_authStatus==AuthStatus.notSignedIn){
     return new LoginPage(
         auth: widget.auth,
          onSignedIn: _signedIn,
     );
   }else if(_authStatus==AuthStatus.signedIn){
     return  new HomePage(
       auth: widget.auth,
       onSignedOut: _signOut,
     );


   }

  }
  }

