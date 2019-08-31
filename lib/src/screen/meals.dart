import 'package:flutter/material.dart'; // flutter main package
import 'package:dtfbl/src/widgets/styles.dart';
import 'dart:math';

class Meals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'الوجبات',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: new SingleChildScrollView(child: new Body()),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State createState() => new Bodystate();
}

class Bodystate extends State<Body> {
  Widget _foodTxt() {
    return Column(
      children: <Widget>[
        new Stack(
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(right: 20.0, top: 20.0, left: 5.0),
              width: 380.0,
              height: 230.0,
              decoration: BoxDecoration(
                color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
                    .withOpacity(0.3),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 50.0,
                    offset: new Offset(0.0, 5.0),
                  ),
                ],
              ),
            ),
            new Container(
              width: 120.0,
              height: 120.0,
              margin: new EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(80.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 50.0,
                    offset: new Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                'صورة',
                style: Styles.productRowItemName,
              )),
            ),
            new Container(
              margin:
                  new EdgeInsets.symmetric(horizontal: 80.0, vertical: 80.0),
              child: Column(
                children: <Widget>[
                  new Text(
                    'الطبق',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  new Text(
                    'معلومات عن الطبق',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  new Container(
                      margin: new EdgeInsets.only(top: 10.0),
                      height: 2.0,
                      width: 27.0,
                      color: Colors.blueGrey),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      new Text(
                        'الكاربوهيدرات:',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 80.0),
                      new Text(
                        'الكالوري:',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
            _foodTxt(),
          ],
        ));
  }
}
