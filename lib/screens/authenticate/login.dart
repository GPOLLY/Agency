import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sweetalert/sweetalert.dart';
import 'package:vision_agency/screens/home/home.dart';




class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String username ='';
  String msg ='';
  int index = 1;



  Future<List>_login() async{
    final response = await http.post("http://realtimetechnology.co.ke/agency/login.php", body:{
      "username":user.text,
      "password":pass.text,
    });

    var datauser = json.decode(response.body);


    if(datauser.length !=0){
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Home(agent: username,);}));


      setState(() {
        username = datauser[0]['username'];

        print(username);
      });

    }else{
      SweetAlert.show(context, title: "Please Enter The Entire Data");

    }
    return datauser;

  }

  //Database Connection


  //UI
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
                color: Colors.white, //   Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 100.0, right: 100.0, top: 1.0),

                child: Row(
                  children: <Widget>[
//                    CircleAvatar(
//                      backgroundImage: AssetImage("assets/images/visionafrika.jpg"),
//                      maxRadius: 80,
//                      minRadius: 30,
//                    ),
                  ],
                ),
              ),
            ),



            Padding(

              padding: EdgeInsets.all(10.0),

              child: TextField(
                controller: user,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:'User Name',
                  fillColor: Colors.white,
                  filled: true,
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),
                  icon: Icon(Icons.person,),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),

              child: TextField(
                controller: pass,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:'Password',
                  fillColor: Colors.white,
                  filled: true,
                  suffixText: '*',
                  suffixStyle: TextStyle(
                    color: Colors.red,
                  ),

                  icon: Icon(Icons.lock),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 130.0),
              child: RaisedButton(
                onPressed: (){
                  _login();
                },
                color: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                child: Text("Login",style: TextStyle(color: Colors.white70),),
              ),

            ),
            Text(msg,style: TextStyle(fontSize: 25.0,color: Colors.red),)

          ],
        ),



      ),
    );


  }
}
class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'User Login',
      routes: <String,WidgetBuilder>{
        '/home':(BuildContext context)=> new Home(agent: User,),
      },

    );
  }
}



class User{
  String agent;

  User({this.agent});
}


