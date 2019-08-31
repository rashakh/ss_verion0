import 'package:flutter/material.dart'; // flutter main package
import 'package:dtfbl/src/widgets/styles.dart';
import 'dart:math';

class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'الارشادات',
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
  Widget _instrTxt() {
    return Column(
      children: <Widget>[
        new Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(top: 40.0),
              width: 360.0,
              height: 470.0,
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
              width: 300.0,
              height: 100.0,
              margin: new EdgeInsets.symmetric(vertical: 7.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Center(
                  child: Text(
                'صورة',
                style: Styles.productRowItemName,
              )),
            ),
            Container(
              margin:
                  new EdgeInsets.symmetric(vertical: 150.0, horizontal: 40.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    new Text(
                      'العنوان',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    new Divider(
                      color: Colors.black45,
                      height: 30.0,
                    ),
                    new Text(
                      'بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا\nبلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلابلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا\nبلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا بلا',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
            _instrTxt(),
          ],
        ));
  }
}
