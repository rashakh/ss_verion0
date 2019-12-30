// LogIn file which contains the LogIn page, and its properties
// this file allows user to log in into the App, represented by 'l_1' Use-Case

//import 'package:dtfbl/src/models/A1C.dart';
import 'package:flutter/material.dart'; // flutter main package
// import 'dart:async';
// import 'dart:convert'; // convert json into data
// import 'package:http/http.dart';
    // as http; // perform http request on API to get the into
import '../widgets/aimagesize.dart'; //import animation widget
import 'loginpage.dart';
//import 'mainpage.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/user.dart';
//import '../utils/database_helper.dart';

// StatefulWidget LoginPage class which has variable state
class Language extends StatefulWidget {
  @override
  State createState() => new _LanguagePageState();
}

// variable states of LoginPage class will occur in LoginPageState class
class _LanguagePageState extends State<Language> {


  
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => new MainPage(id,Update,BMI,A1c,carb,0,PAs,units)),
      // );

 
  

// String  newd(String s){
// String r=s.substring(8,10);
// int i=int.parse(r);
// int start =15; 
// int end=start+7;
// if(i==end){
//   start=end;
// int diff= i-start;
// i-=diff;
// print("date: $i");
// }
// else{
//   int diff= i-start;
// i-=diff;
// print("date: $i");
// }
// return s.substring(0,8)+i.toString();;
//   }
  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        // Stack widget helps overlap objects
        body: new Stack(
          fit: StackFit.expand, // make Stack itself fit screen
          children: <Widget>[
            new Image(
              image: new AssetImage('assets/img.jpg'),
              fit: BoxFit.fill, // make image fit screen
              //color: Colors.black87,
              //colorBlendMode: BlendMode.darken, // show opacity
            ), // first widget (object or child) in the Stack
            new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 70),
                  ),
                  new SizeAnimation(
                    new Image(
                      image: new AssetImage('assets/icon12.png'),
                    ),
                  ),
                  new Padding(
                      padding: const EdgeInsets.only(top: 200.0)), // logo & form
    
new Row(
  mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max,
  children: <Widget>[
                     new MaterialButton(
                     child: new Text("العربية"),
minWidth: 60.0,
height: 44.0,
color: Colors.grey, onPressed: () {

      var route = new MaterialPageRoute(builder: (context) => new LoginPage());

      Navigator.of(context).push(route);
},
        ),

    new Padding(
                      padding: const EdgeInsets.only(left: 20.0)), // logo & form
    
               new MaterialButton(
                     child: new Text("EN"),
minWidth: 60.0,
height: 44.0,
color: Colors.grey, onPressed: () {
        var route = new MaterialPageRoute(builder: (context) => new LoginPage());

      Navigator.of(context).push(route);
},
        ),

   new Padding(
                      padding: const EdgeInsets.only(left: 20.0)), // logo & form
            

               new MaterialButton(
                     child: new Text("FR"),
minWidth: 60.0,
height: 44.0,
color: Colors.grey, onPressed: () {
        var route = new MaterialPageRoute(builder: (context) => new LoginPage());

      Navigator.of(context).push(route);
},
        ),
  ],
)
  ,
                ],
              ),
            ), // secondr widget (object or child) in the Stack which is Column contine other widgets vertically
          ],
        ),
      ),
    );
  } // build widget

// logIn form
 


} // LoginPageState
