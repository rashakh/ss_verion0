// LogIn file which contains the LogIn page, and its properties
// this file allows user to log in into the App, represented by 'l_1' Use-Case

import 'package:dtfbl/src/models/A1C.dart';
import 'package:flutter/material.dart'; // flutter main package
// import 'dart:async';
// import 'dart:convert'; // convert json into data
// import 'package:http/http.dart';
    // as http; // perform http request on API to get the into
import '../widgets/aimagesize.dart'; //import animation widget
import 'mainpage.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/user.dart';
import '../utils/database_helper.dart';

// StatefulWidget LoginPage class which has variable state
class LoginPage extends StatefulWidget {
  @override
  State createState() => new _LoginPageState();
}

// variable states of LoginPage class will occur in LoginPageState class
class _LoginPageState extends State<LoginPage> {
  DatabaseHelper helper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  // final String url =
  //     'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection

  // list item to get from http request:
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email, _password;

  // Future<bool> _postData() async {
  //   // map data to converted to json data
  //   final Map<String, dynamic> authData = {
  //     'email': _email,
  //     'password': _password
  //   };
  //   var jsonData = JsonCodec().encode(authData); // encode data to json
  //   var httpclient = new http.Client();
  //   var response = await httpclient.post(url,
  //       body: jsonData, headers: {'Content-type': 'application/json'});
  //   _result =
  //       response.statusCode >= 200 || response.statusCode <= 400 ? true : false;
  // }

  bool _validateAndSave(var id) {
    final form = _formKey.currentState;
    form.save();
    if (form.validate() &&
        id[0]['email'] == emailController.text &&
        id[0]['Pass'] == passwordController.text) {
      return true;
    } else
      return false;
  }

  void _validateAndSubmit() async {
    var id =
        await helper.getUser(emailController.text, passwordController.text);
    if (id == null) {
      print(
          'form invalid, Email: ${emailController.text}, Passwoer: ${passwordController.text}');
    } else if (_validateAndSave(id)) {
      print('here is login id : ${id}');
var BMI;
double  A1c;
var carb=0.0;
    //  setState(() async{
          BMI=(await helper.getWight(id[0]['email']));
         
         if(((await helper.getA1C(id[0]['email']))).isNotEmpty)
         {
         var a1ca= (await helper.getA1C(id[0]['email']))[0]['a1C'];
         print("A1c now : $a1ca");
         A1c=double.parse( a1ca);
         print("A1c now : $A1c");
          }
          else{ A1c=0.0;}

          if(((await helper.getCarb(id[0]['email']))).isNotEmpty)
          {
         carb=(await helper.getCarb(id[0]['email']))[0]['carb'];
          }
          else{ carb=0.0;} 
      // print("A1c list: null");

        // }
     // });
      print("A1c list: $A1c");
      print("BMI list: $BMI");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => new MainPage(id,BMI,A1c,carb)),
      );
      //Navigator.of(context).pushNamed('/MainPage',arguments: _email);
      _formKey.currentState.reset();
    } else
      print(
          'form invalid, Email: ${emailController.text},  Passwoer: ${passwordController.text}');
  }

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
                      padding: const EdgeInsets.only(top: 20.0)), // logo & form
                  new Form(
                    key: _formKey,
                    child: new Theme(
                      data: new ThemeData(
                          brightness: Brightness.light,
                          primaryColor: Color(0xFFBDD22A),
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold))),
                      child: Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: buildInput() +
                              buildSubmit() +
                              buildRegistration(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ), // secondr widget (object or child) in the Stack which is Column contine other widgets vertically
          ],
        ),
      ),
    );
  } // build widget

// logIn form
  List<Widget> buildInput() {
    return [
      new TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'ادخل ايميلك',
          hintStyle: new TextStyle(fontSize: 20.0, color: Colors.black87),
          fillColor: Colors.white54.withOpacity(0.5),
          filled: true,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) =>
            !value.contains('@') || !value.contains('.com') || value.isEmpty
                ? 'الايميل غير صحيح'
                : null,
        onSaved: (value) => _email = value,
      ),
      new Padding(padding: const EdgeInsets.only(top: 20.0)),
      new TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'ادخل كلمة المرور',
          hintStyle: new TextStyle(fontSize: 20.0, color: Colors.black87),
          fillColor: Colors.white54.withOpacity(0.5),
          filled: true,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value) => value.isEmpty ? 'كلمة المرور غير صحيحة' : null,
        onSaved: (value) => _password = value,
      )
    ];
  }

// logIn button
  List<Widget> buildSubmit() {
    return [
      new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 10.0),
            child: new Container(
                alignment: Alignment.center,
                height: 60.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/LostPassword');
                  },
                  child: new Text("هل نسيت كلمة السر؟",
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
                )),
          ),
        ),
        new Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 3.0, top: 10.0),
            child: new GestureDetector(
              onTap: _validateAndSubmit,
              child: new Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  decoration: new BoxDecoration(
                      color: Color(0xFF2A79D2),
                      borderRadius: new BorderRadius.circular(7.0)),
                  child: new Text("سجل الدخول",
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
            ),
          ),
        ),
      ])
    ];
  }

// Registration button
  List<Widget> buildRegistration() {
    return [
      new Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: new GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/Registration');
          },
          child: new Container(
              alignment: Alignment.center,
              height: 45.0,
              decoration: new BoxDecoration(
                  color: Color(0xFFBDD22A),
                  borderRadius: new BorderRadius.circular(7.0)),
              child: new Text("انشئ حساب جديد",
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
        ),
      )
    ];
  }
} // LoginPageState
