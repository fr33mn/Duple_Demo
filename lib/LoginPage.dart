import 'package:dupledemo/auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({this.auth,this.onSignedIn});
  final  BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new LoginPageState();
}
enum FormType{
  login,
  register
}

class LoginPageState extends State<LoginPage>{

  final formKey =new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType= FormType.login;

  bool validateAndSave(){
    final form=formKey.currentState;
    if(form.validate()) {
      form.save();
     return true;
    }
    else{
      return false;
    }

  }
  void validateAndSubmit() async{
    if(validateAndSave()) {
      try{
        if(_formType==FormType.login){
          String userId=await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in user $userId');
        }else{
          String userId=await widget.auth.createWithEmailAndPassword(_email, _password);
          print('Registered User ID $userId');
        }
        widget.onSignedIn();

      }catch(e){
        print('User signin error $e');
      }


    }

  }
  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.register;
    });

  }
  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Duple Login'),),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            )),
      ),
    );
  }
  List<Widget> buildInputs(){
    return[
      new TextFormField(
        decoration: new InputDecoration(labelText:'Email'),
        validator: (value) =>value.isEmpty ? 'Email is empty': null,
        onSaved: (value) => _email= value,
      ),
      new TextFormField(
        decoration:new InputDecoration(labelText:'Password'),
        validator: (value) =>value.isEmpty ? 'Password is empty': null,
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    ];
  }
  List<Widget> buildSubmitButtons() {
    if(_formType ==FormType.login){
      return[
        new RaisedButton(
            child: new Text('Login',style: new TextStyle(fontSize: 20.0),),
            onPressed: validateAndSubmit),
        new FlatButton(
            onPressed: moveToRegister,
            child: new Text('Create account', style: new TextStyle(fontSize: 20.0),))
      ];
    }else{
      return[
        new RaisedButton(
            child: new Text('Create an account',style: new TextStyle(fontSize: 20.0),),
            onPressed: validateAndSubmit),
        new FlatButton(
            onPressed: moveToLogin,
            child: new Text('Have an account ? Login', style: new TextStyle(fontSize: 20.0),))
      ];
    }

  }

}





