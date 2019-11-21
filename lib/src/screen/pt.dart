import 'package:flutter/material.dart';

class PeriodicTest extends StatelessWidget {
  PeriodicTest(this.id);
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
              'الفحوصات الدورية',
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
              'الفحوصات القادمة',
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
                  'يتبقى على الموعد',
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
                    Text(
                      'فحص العين',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      '1/1/2020',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      '88 يوما',
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
                    Text(
                      'فحص الكلى',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Text(
                      '1/12/2019',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      '58 يوما',
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
              height: 20.0,
            ),
            new Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 200.0,
                decoration: new BoxDecoration(
                    color: Color(0xFFBDD22A),
                    borderRadius: new BorderRadius.circular(7.0)),
                child: new Text("اضافة",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: 30.0,
            ),
            new Text(
              'اخر النتائج',
              style: new TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
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
                  'التاريخ',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 90.0,
                ),
                new Text(
                  'النتيجة',
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
                    Text(
                      'فحص العين',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      '1/1/2019',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      'سليمة',
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
                    Text(
                      'فحص الكلى',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Text(
                      '1/12/2018',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
                    ),
                    Text(
                      'سليمة',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
