// Registration file which contains the Registration page, and its properties
// this file allows user to register into the App, represented by 'r_1' Use-Case

import 'package:flutter/material.dart'; // flutter main package
import 'package:intl/intl.dart' as intl; // flutter main package
import 'package:flutter/cupertino.dart';
import 'loginpage.dart';

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
  final _formKey = GlobalKey<FormState>();
  final intl.DateFormat format = new intl.DateFormat('y-M-d');
  String _email, _password, _fName, _lName;
  int _gender;
  double _height, _weight;
  DateTime _birthday = new DateTime.now();
  int _value = -1;
  @override
  void initState() {
    super.initState();
    _birthday = widget.initialDate;
  }

  void _onChange(int value) {
    setState(() {
      _gender = value;
      print(_gender);
      print(_birthday);
      print(DateTime.now());
      print(format.format(new DateTime.now()));
    });
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate() &&
        _gender != -1 &&
        format.format(_birthday) != format.format(DateTime.now())) {
      return true;
    } else
      return false;
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      print(
          'form valid, Email: ${_email},  Passwoer: ${_password}, ${_fName}, ${_lName}, ${_gender}, ${_height}, ${_birthday}');
      var route = new MaterialPageRoute(
          builder: (context) => new LoginPage(
                email: _email,
                password: _password,
              ));
      Navigator.of(context).push(route);
      _formKey.currentState.reset();
    } else
      print(
          'form invalid, Email: ${_email},  Passwoer: ${_password}, ${_fName}, ${_lName}, ${_gender}, ${_height}, ${_weight}, ${_birthday}');
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
                                                        fontSize: 20.0,
                                                        color: Colors.black87),
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
                                                        fontSize: 20.0,
                                                        color: Colors.black87),
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
                                                        fontSize: 20.0,
                                                        color: Colors.black87),
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
                                                        fontSize: 20.0,
                                                        color: Colors.black87),
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
                                    new Column(
                                      children: <Widget>[
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
                                                  fontSize: 20.0,
                                                  color: Colors.black87),
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
                                                  fontSize: 20.0,
                                                  color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                        left: 175.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          new Text(
                                            '    تاريخ الميلاد : ',
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black87),
                                          ),
                                          new IconButton(
                                            color: Colors.blue,
                                            icon: new Icon(Icons.date_range),
                                            onPressed: () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return _cupdate();
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            new Divider(
                              color: Color(0xFFBDD22A),
                              height: 30.0,
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
                                              fontSize: 20.0,
                                              color: Colors.black87),
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
                                              fontSize: 20.0,
                                              color: Colors.black87),
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
                                              fontSize: 20.0,
                                              color: Colors.black87),
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
                              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 35.0),
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
