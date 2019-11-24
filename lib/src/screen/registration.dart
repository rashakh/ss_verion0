// Registration file which contains the Registration page, and its properties
// this file allows user to register into the App, represented by 'r_1' Use-Case

import 'dart:convert';

import 'package:dtfbl/src/models/wieght.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'package:intl/intl.dart' as intl; // flutter main package
import 'package:flutter/cupertino.dart';
// import 'dart:async';
// import 'package:http/http.dart'
//     as http; // perform http request on API to get the into
import 'loginpage.dart';

// import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../utils/database_helper.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        brightness: Brightness.light,
        title: new Text(
          'ادخل البيانات المطلوبة',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: new RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  final DateTime initialDate = DateTime.now();
  @override
  State createState() => new _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  DatabaseHelper helper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  final String url =
      'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  final intl.DateFormat format = new intl.DateFormat('y-M-d');

  String _email, _password, _fName, _lName, _number;
  int _gender, _type;
  double _height, _weight;
  DateTime _birthday = new DateTime.now();
  DateTime _dd = new DateTime.now();
  // int _value = -1;
  bool _result;
  @override
  void initState() {
    super.initState();
    _birthday = widget.initialDate;
  }

  void _onChange(int value) {
    setState(() {
      _gender = value;
    });
  }

  void _onChanget(int value) {
    setState(() {
      _type = value;
    });
  }

  // Future<bool> _postData() async {
  //   // map data to converted to json data
  //   final Map<String, dynamic> userData = {
  //     '_id': _email,
  //     'password': _password,
  //     'fName': _fName,
  //     'lName': _lName,
  //     'weight': _weight,
  //     'height': _height,
  //     'gender': _gender,
  //     'type': _type,
  //     'bd': _birthday.toIso8601String(),
  //     'dd': _dd.toIso8601String(),
  //   };
  //   var jsonData = JsonCodec().encode(userData); // encode data to json
  //   var httpclient = new http.Client();
  //   var response = await httpclient.post(url,
  //       body: jsonData, headers: {'Content-type': 'application/json'});
  //   print('the body of the response = \n${response.body}\n.');
  //   _result =
  //       response.statusCode >= 200 || response.statusCode <= 400 ? true : false;
  // }

  bool validateAndSave() {
    final form = _formKey.currentState;
    form.save();
    //_postData();
    if (form.validate() &&
        //_result == true &&
        _gender != -1 &&
        format.format(_birthday) != format.format(DateTime.now())) {
      return true;
    } else
      return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      User user = User(
          _email,
          _password,
          _fName,
          _lName,
          (_dd.toIso8601String()).substring(0,9),
          (_birthday.toIso8601String()).substring(0,9),
          _gender,
          _type,
          _height,
          _number
          //_weight,
          //(((_weight / _height) / _height) * 10000)
          );
       BW bw= BW(_email,_weight.floor(),(((_weight / _height) / _height) * 10000)," ",new DateTime.now().toIso8601String()); 
      var id = await helper.insertUser(user);
      print('this result id : ${id}');
      var wi = await helper.insertBW(bw);
      print('this result id : ${wi}');
      var route = new MaterialPageRoute(builder: (context) => new LoginPage());

      Navigator.of(context).push(route);
      _formKey.currentState.reset();
    } else {
      print(
          'form invalid, Email: ${_email},  Passwoer: ${_password}, ${_fName}, ${_lName}, ${_gender}, ${_height}, ${_weight}, ${_birthday}');
    }
  }

  Widget _cupdate() {
    return CupertinoDatePicker(
      initialDateTime: _birthday,
      minimumDate: DateTime(2018),
      maximumDate: DateTime.now(),
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (e) {
        setState(() {
          if (e.isAfter(DateTime.now())) {
            e = DateTime.now();
          }
          _birthday = e;
        });
      },
    );
  }

  Widget _ddate() {
    return CupertinoDatePicker(
      initialDateTime: _dd,
      minimumDate: DateTime(2018),
      maximumDate: DateTime.now(),
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (e) {
        setState(() {
          if (e.isAfter(DateTime.now())) {
            e = DateTime.now();
          }
          _dd = e;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Stack(fit: StackFit.expand, // make Stack itself fit screen
          children: <Widget>[
            new Image(
              image: new AssetImage('assets/img.jpg'),
              fit: BoxFit.none, // make image fit screen
            ),
            new Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 0.0, right: 0.0),
                child: new Form(
                  key: _formKey,
                  child: new Theme(
                    data: new ThemeData(
                        brightness: Brightness.light,
                        primaryColor: Color(0xFFBDD22A),
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold))),
                    child: Container(
                      child: new SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Card(
                                elevation: 5.0,
                                color: Colors.white,
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 10.0),
                                      child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Expanded(
                                              child: new Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: new TextFormField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0),
                                                    hintText: 'الاسم الاول',
                                                    hintStyle: new TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.grey),
                                                    fillColor: Colors.white54
                                                        .withOpacity(0.5),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) =>
                                                      value.isEmpty
                                                          ? 'هذا الحقل مطلوب'
                                                          : null,
                                                  onSaved: (value) =>
                                                      _fName = value,
                                                ),
                                              ),
                                            ),
                                            new Expanded(
                                              child: new Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                ),
                                                child: new TextFormField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0),
                                                    hintText: 'الاسم الاخير',
                                                    hintStyle: new TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.grey),
                                                    fillColor: Colors.white54
                                                        .withOpacity(0.5),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) =>
                                                      value.isEmpty
                                                          ? 'هذا الحقل مطلوب'
                                                          : null,
                                                  onSaved: (value) =>
                                                      _lName = value,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20.0, bottom: 10.0),
                                      child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Expanded(
                                              child: new Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                ),
                                                child: new TextFormField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0),
                                                    hintText: 'وزنك',
                                                    hintStyle: new TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.grey),
                                                    fillColor: Colors.white54
                                                        .withOpacity(0.5),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) =>
                                                      value.isEmpty
                                                          ? 'هذا الحقل مطلوب'
                                                          : null,
                                                  onSaved: (value) => _weight =
                                                      double.tryParse(value),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 35.0,
                                              ),
                                              child: new Text('كغم'),
                                            ),
                                            new Expanded(
                                              child: new Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 3.0,
                                                ),
                                                child: new TextFormField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0),
                                                    hintText: 'طولك',
                                                    hintStyle: new TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.grey),
                                                    fillColor: Colors.white54
                                                        .withOpacity(0.5),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) =>
                                                      value.isEmpty
                                                          ? 'هذا الحقل مطلوب'
                                                          : null,
                                                  onSaved: (value) => _height =
                                                      double.tryParse(value),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: new Text('متر'),
                                            ),
                                          ]),
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        new Radio(
                                          activeColor: Colors.lightBlue,
                                          value: 0,
                                          groupValue: _gender,
                                          onChanged: (value) {
                                            _onChange(value);
                                          },
                                        ),
                                        new Text(
                                          'انثى',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                        new Radio(
                                          activeColor: Colors.lightBlue,
                                          value: 1,
                                          groupValue: _gender,
                                          onChanged: (value) {
                                            _onChange(value);
                                          },
                                        ),
                                        new Text(
                                          'ذكر',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        new Radio(
                                          activeColor: Colors.lightBlue,
                                          value: 0,
                                          groupValue: _type,
                                          onChanged: (value) {
                                            _onChanget(value);
                                          },
                                        ),
                                        new Text(
                                          'سكري النوع الاول',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                        new Radio(
                                          activeColor: Colors.lightBlue,
                                          value: 1,
                                          groupValue: _type,
                                          onChanged: (value) {
                                            _onChanget(value);
                                          },
                                        ),
                                        new Text(
                                          'سكري النوع الثاني',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        new Text(
                                          '    تاريخ الميلاد : ',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                        new IconButton(
                                          color: Colors.blue,
                                          icon: new Icon(
                                            Icons.calendar_today,
                                          ),
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _cupdate();
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(width: 100.0),
                                        new Text(
                                          intl.DateFormat.yMMMd()
                                              .format(_birthday),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        new Text(
                                          '    تاريخ التشخيص بالسكري : ',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                        new IconButton(
                                          color: Colors.blue,
                                          icon: new Icon(
                                            Icons.calendar_today,
                                          ),
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _ddate();
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(width: 15.0),
                                        new Text(
                                          intl.DateFormat.yMMMd().format(_dd),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 20.0,
                                          right: 20.0,
                                          left: 30.0),
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          hintText:
                                              'رقم احد افراد العائلة للطوارئ',
                                          hintStyle: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                          fillColor:
                                              Colors.white54.withOpacity(0.5),
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) => value.isEmpty
                                            ? 'هذا الحقل مطلوب'
                                            : null,
                                        onSaved: (value) =>
                                            _number = value,
                                      ),
                                    ),

                                  ],
                                )),
                            new Divider(
                              color: Color(0xFFBDD22A),
                              height: 10.0,
                            ),
                            new Card(
                                elevation: 5.0,
                                color: Colors.white,
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 10.0),
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          hintText: 'دخل ايميلك',
                                          hintStyle: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                          fillColor:
                                              Colors.white54.withOpacity(0.5),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) =>
                                            !value.contains('@') ||
                                                    !value.contains('.com') ||
                                                    value.isEmpty
                                                ? 'الايميل غير صحيح'
                                                : null,
                                        onSaved: (value) => _email = value,
                                      ),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 10.0),
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          hintText: 'ادخل كلمة المرور',
                                          hintStyle: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                          fillColor:
                                              Colors.white54.withOpacity(0.5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        validator: (value) => value.isEmpty
                                            ? 'هذا الحقل مطلوب'
                                            : null,
                                        onSaved: (value) => _password = value,
                                      ),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          bottom: 10.0),
                                      child: new TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          hintText: 'اكد كلمة المرور',
                                          hintStyle: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                          fillColor:
                                              Colors.white54.withOpacity(0.5),
                                        ),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        validator: (value) =>
                                            value.isEmpty || value != _password
                                                ? 'كلمة السر لا تتطابق'
                                                : null,
                                      ),
                                    ),
                                  ],
                                )),
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: new GestureDetector(
                                onTap: validateAndSubmit,
                                child: new Container(
                                    alignment: Alignment.center,
                                    height: 45.0,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFFBDD22A),
                                        borderRadius:
                                            new BorderRadius.circular(7.0)),
                                    child: new Text("تسجيل",
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ]),
    );
  }
}
