// LogIn file which contains the LogIn page, and its properties
// this file allows user to log in into the App, represented by 'l_1' Use-Case

import 'package:flutter/material.dart'; // flutter main package
import 'package:http/http.dart' as http;
import '../widgets/aimagesize.dart'; //import animation widget

// StatefulWidget LoginPage class which has variable state
class LoginPage extends StatefulWidget {
  final String email, password;
  const LoginPage({Key key, this.email, this.password}) : super(key: key);
  @override
  State createState() => new _LoginPageState();
}

// variable states of LoginPage class will occur in LoginPageState class
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String re = 'r@gmail.com';
  String rpass = '123';

  //extEditingController _user = new TextEditingController();
  //TextEditingController _pass = new TextEditingController();

  //Future<List> _login() async{
  //final response = await http.post('http://51.36.79.20/mysql/data/ssdb/login.php',body:  {
  //'username': _user.text,
  //'password': _pass.text,
  // });
  //print(response.body);
  //if (validateAndSave()) {
  // Navigator.of(context).pushNamed('/MainPage');
  // _formKey.currentState.reset();
  // } else
  // print('form invalid, Email: $_email,  Passwoer: $_password');
  // }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate() &&
            _email == widget.email &&
            _password == widget.password ||
        _email == re && _password == rpass) {
      return true;
    } else
      return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      Navigator.of(context).pushNamed('/MainPage');
      _formKey.currentState.reset();
    } else
      print('form invalid, Email: $_email,  Passwoer: $_password');
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
              fit: BoxFit.none, // make image fit screen
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
        //controller: _user,
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
        //controller: _pass,
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
