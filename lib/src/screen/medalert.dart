import 'package:flutter/material.dart';

class MedAlert extends StatelessWidget {
  MedAlert(this.id);
  var id;
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
            automaticallyImplyLeading: true,
            brightness: Brightness.light,
            title: new Text(
              'الادوية',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body(id)),
        ));
  }
}

class Body extends StatefulWidget {
  Body(this.id);
  var id;
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
  String _med;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Container(
          alignment: Alignment.centerRight,
          child: Column(children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            new Text(
              'الادوية و الجرعات',
              style: new TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            new Row(
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                ),
                new Text(
                  'الاسم',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 80.0,
                ),
                new Text(
                  'الموعد',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 80.0,
                ),
                new Text(
                  'عدد الوحدات',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'لانتوس',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      'الصباح',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 90.0,
                    ),
                    Text(
                      '24',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'هومولوج',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 45.0,
                    ),
                    Text(
                      'قبل او بعد الوجبة',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 45.0,
                    ),
                    Text(
                      '10,13,10',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'اسبرين',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      'قبل الغداء',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 90.0,
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 90.0, right: 90.0, top: 5.0, bottom: 5.0),
              child: new GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (
                        BuildContext context,
                      ) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    child: new DropdownButton<String>(
                                      iconEnabledColor: Color(0xFFBDD22A),
                                      hint: Text('اختر الدواء'),
                                      value: _med,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'دواء١',
                                          child: Text(
                                            'دواء١',
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'دواء٢',
                                          child: Text(
                                            'دواء٢',
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'دواء٣',
                                          child: Text(
                                            'دواء٣',
                                          ),
                                        ),
                                      ],
                                      onChanged: (e) {
                                        setState(() {
                                          _med = e;
                                        });
                                      },
                                      
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: new GestureDetector(
                                      onTap: () {
                                        //database
                                        Navigator.of(context).pop();
                                      },
                                      child: new Container(
                                          alignment: Alignment.center,
                                          height: 40.0,
                                          decoration: new BoxDecoration(
                                              color: Color(0xFFBDD22A),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      7.0)),
                                          child: new Text('حفظ',
                                              style: new TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      });
                },
                child: new Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    decoration: new BoxDecoration(
                        color: Color(0xFFBDD22A),
                        borderRadius: new BorderRadius.circular(7.0)),
                    child: new Text("اضافة",
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ]),
        ));
  }
}
