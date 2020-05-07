
import 'package:dupledemo/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({this.auth,this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  String userName,userID,email;

  getUsername(userName){
    this.userName=userName;
  }

  getuserID(userID){
    this.userID=userID;
  }

  getuseremail(email){
    this.email=email;
  }


  void _signOut()async{
    try{
      await auth.signOut();
      onSignedOut();
    }catch(e){
      print('Sign out Error $e');
    }

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Duple Demo'),
        actions: <Widget>[
          new FlatButton(onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0))
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: new Column(

          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0 )
                  )
                ),
                onChanged: (String name){
                  getUsername(name);
                }
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom:.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "user ID",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue,
                              width: 2.0 )
                      )
                  ),
                  onChanged: (String userID){
                    getuserID(userID);
                  }
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom:.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue,
                              width: 2.0 )
                      )
                  ),
                  onChanged: (String email){
                    getuseremail(email);
                  }
              ),

            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: new Text('Create'),
                  padding: EdgeInsets.all(6),
                  textColor: Colors.white,
                  onPressed: (){
                    createUser();
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),

                ),
                RaisedButton(
                  child: new Text('Read'),
                  textColor: Colors.white,
                  onPressed: (){
                    readUser();
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),

                ),
                RaisedButton(
                  child: new Text('Update'),
                  textColor: Colors.white,
                  onPressed: (){
                    updateUser();
                  },
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),

                ),
                RaisedButton(
                  child: new Text('Delete'),
                  textColor: Colors.white,
                  onPressed: (){
                    deleteUser();
                  },
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),

                )
              ],
            ),
            Row(children: <Widget>[
              Expanded(child: new Text("User Name"),),
              Expanded(child: new Text("User Email"),),
              Expanded(child: new Text("User ID"),),
            ],),
            StreamBuilder(
              stream: Firestore.instance.collection
                ("MyUsers").snapshots(),
              builder: (context, snapshots){
                if(snapshots.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: snapshots.data.documents.
                      length,
                      itemBuilder:(context, index){
                        DocumentSnapshot docementSnap=
                            snapshots.data.documents[index];
                        return Row(
                        children: <Widget>[
                          Expanded(child: Text(
                            docementSnap["userName"].toString()
                          )
                          ),
                          Expanded(child: Text(
                              docementSnap["userEmail"].toString()
                          )
                          ),
                          Expanded(child: Text(
                              docementSnap["userID"].toString()
                          )
                          ),
                        ],
                          );
                      });
                }else{
                  return null;
                }
              },
            )
          ],
        ),
      )
    );
  }

  void createUser() {
    print('created');
    try{
      DocumentReference documentReference=  Firestore.instance.collection("MyUsers").document("Duple Demo");

      //create Map
      Map<String,dynamic> dupleUsers ={
        "userName":userName,
        "userEmail":email,
        "userID":userID,
      };
      documentReference.setData(dupleUsers).whenComplete((){
        print('$dupleUsers created');
      });
    }catch(e){
      print('Error firestore $e');
    }

  }
  void readUser(){
    try{
      DocumentReference documentReference=  Firestore.instance.collection("MyUsers").document("Duple Demo");
      documentReference.get().then((datasnap){
        print(datasnap.data["userName"]);
        print(datasnap.data["userID"]);
        print(datasnap.data["userEmail"]);
      }
      );

    }catch(e){
      print('Error firestore $e');
    }


  }
  void deleteUser(){
    print('deleted');
    try{
      DocumentReference documentReference=  Firestore.instance.collection("MyUsers").document("Duple Demo");

      //create Map
      Map<String,dynamic> dupleUsers ={
        "userName":userName,
        "userEmail":email,
        "userID":userID,
      };
      documentReference.delete().whenComplete((){
        print('$dupleUsers deleted');
      });
    }catch(e){
      print('Error firestore $e');
    }

  }
  void updateUser(){
    print('updated');
    try{
      DocumentReference documentReference=  Firestore.instance.collection("MyUsers").document("Duple Demo");

      //create Map
      Map<String,dynamic> dupleUsers ={
        "userName":userName,
        "userEmail":email,
        "userID":userID,
      };
      documentReference.setData(dupleUsers).whenComplete((){
        print('$dupleUsers updated');
      });
    }catch(e){
      print('Error firestore $e');
    }
  }



}