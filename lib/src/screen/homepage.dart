import 'package:flutter/material.dart'; // flutter main package
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  HomePage(this.id);
  var id;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'الرئيسية',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(id[0]['fname'].toString()),
              accountEmail: Text(id[0]['email'].toString()),
            ),
            new ListTile(
              title: Text('الادوية'),
              onTap: () {
                Navigator.of(context).pushNamed('/MedAlert');
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.of(context).pushNamed('/PeriodicTest');
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {},
            ),
            new ListTile(
              title: Text('الاعدادات'),
              onTap: () {},
            ),
            new ListTile(
              title: Text('تسجيل الخروج'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/LoginPage');
              },
            )
          ],
        ),
      ),
      body: new SingleChildScrollView(child: new Body()),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
  var dd = 45 * 0.55;
  var bgratio;
  Widget icon = Icon(
    Icons.mood,
    color: Colors.green,
    size: 40.0,
  );
  Color color = Colors.green;
  double a1c = 4.0;

  double _a1c() {
    var n = a1c / 14;
    print(n);
    _bgratio();
    return n;
  }

  void _bgratio() {
    if (a1c <= 6.0) {
      icon = Icon(
        Icons.mood,
        color: Colors.green,
        size: 40.0,
      );
      color = Colors.green;
    } else if (a1c > 6.0 && a1c <= 8.0) {
      icon = Icon(
        Icons.mood,
        color: Colors.orangeAccent,
        size: 40.0,
      );
      color = Colors.orangeAccent;
    } else {
      icon = Icon(
        Icons.mood_bad,
        color: Colors.redAccent,
        size: 40.0,
      );
      color = Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Column(
        children: <Widget>[
          new SizedBox(height: 10.0),
          new Column(
            children: <Widget>[
              icon,
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: _a1c(),
                  center: Text((_a1c() * 14).toString() + 'التراكمي',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: color,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: _a1c(),
                  center: Text('الكابرو هيدرات',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: color,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: _a1c(),
                  center: Text('النشاط البدني',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: color,
                ),
              ),
            ],
          ),
          // new Container(
          //     width: 380.0,
          //     height: 114.0,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(begin: Alignment.bottomLeft, colors: [
          //         Colors.white70.withOpacity(0.3),
          //         Colors.white10.withOpacity(0.3)
          //       ]),
          //       shape: BoxShape.rectangle,
          //       borderRadius: new BorderRadius.circular(8.0),
          //       boxShadow: <BoxShadow>[
          //         new BoxShadow(
          //           color: Colors.black12,
          //           blurRadius: 50.0,
          //           offset: new Offset(0.0, 5.0),
          //         ),
          //       ],
          //     ),
          //     child: new Column(
          //       children: <Widget>[
          //         new Row(
          //           children: <Widget>[
          //             Container(
          //               padding: EdgeInsets.only(
          //                   top: 15.0, bottom: 15.0, right: 20.0),
          //               child: Text(
          //                 'مجموع جرعات الانسولين اليومي: ',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //             new Container(
          //               padding: EdgeInsets.only(
          //                 bottom: 15.0,
          //                 top: 15.0,
          //               ),
          //               child: Text(
          //                 dd.toInt().toString() + ' وحدة',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w800,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         new Row(
          //           children: <Widget>[
          //             new Container(
          //               padding: EdgeInsets.only(bottom: 15.0, right: 20.0),
          //               child: Text(
          //                 'مجموع جرعات الصافي: ',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //             new Container(
          //               padding: EdgeInsets.only(
          //                 bottom: 15.0,
          //               ),
          //               child: Text(
          //                 (dd / 2).toInt().toString() + ' وحدة',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w800,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         new Row(
          //           children: <Widget>[
          //             new Container(
          //               padding: EdgeInsets.only(bottom: 15.0, right: 20.0),
          //               child: Text(
          //                 'مجموع جرعات العكر: ',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //             new Container(
          //               padding: EdgeInsets.only(
          //                 bottom: 15.0,
          //               ),
          //               child: Text(
          //                 (dd / 2).toInt().toString() + ' وحدة',
          //                 style: TextStyle(
          //                   fontSize: 13.0,
          //                   fontWeight: FontWeight.w800,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     )),
        ],
      ),
    );
  }
}
