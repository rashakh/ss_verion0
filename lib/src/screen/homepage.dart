import 'package:dtfbl/src/models/A1C.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'package:percent_indicator/percent_indicator.dart';
import './medalert.dart';
import './pt.dart';
import './profile.dart';
import 'exportPDF.dart';
//import 'package:intl/intl.dart';


class HomePage extends StatelessWidget {
  HomePage(this.id,this.BMI,this.A1c);
  var BMI;
  var id;
  var A1c;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'تقدمك اليومي',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedAlert(id)),
                );
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeriodicTest(id)),
                );
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportPDF(id)),
                );
              },
            ),
            new ListTile(
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(id,BMI)),
                );
              },
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
      body: new SingleChildScrollView(child: new Body(id,BMI,A1c)),
    );
  }
}

class Body extends StatefulWidget {
  Body(this.id,this.BMI,this.A1c);
  var id;
  var BMI;
  var A1c;
  @override
  State createState() => new _Bodystate();
}

 double _a1c = 0;
 double a1c = 0;
 
class _Bodystate extends State<Body> {
   DatabaseHelper helper = DatabaseHelper();
  var _sum=0;
  var _num=0;
  var dd = 45 * 0.55;
  var bgratio;
  Widget icon = Icon(
    Icons.mood,
    color: Colors.green,
    size: 40.0,
  );
  

  Color color = Colors.green;
  // double _a1c() {
  //   _getA1c();
  //   var n = a1c/ 14;
  //   print('n: $n');
  //   _bgratio();
  //   return alc;
  // }

  // Future _bgratio() {
  //   if (_a1c <= 6.0) {
  //     icon = Icon(
  //       Icons.mood,
  //       color: Colors.green,
  //       size: 40.0,
  //     );
  //     color = Colors.green;
  //   } else if (_a1c > 6.0 && _a1c <= 8.0) {
  //     icon = Icon(
  //       Icons.mood,
  //       color: Colors.orangeAccent,
  //       size: 40.0,
  //     );
  //     color = Colors.orangeAccent;
  //   } else {
  //     icon = Icon(
  //       Icons.mood_bad,
  //       color: Colors.redAccent,
  //       size: 40.0,
  //     );
  //     color = Colors.redAccent;
  //   }
  // }

  // void initState() { 
  //  super.initState();
  //   //this._getA1c();
  //   this._bgratio();}
  
  @override
  Widget build(BuildContext context) {
//  setState(() {
//     //super.initState();
//     _getA1c();    
//     _bgratio();  
//  });
  // initState(){ 
  //   _getA1c();
  //  super.initState();
  //   this._getA1c();
  //   // this._bgratio();
  //   }
  _getA1c(); 
  // setState(() {
  //     _a1c = a1c ;
  //      print('this $_a1c and this $a1c');
  //   });
  // somfun(){
  //   setState(() {
  //     _getA1c();  
  //     _a1c = a1c ;
  //      print('this $_a1c and this $a1c');
  //   });
  // }
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
                  lineHeight: 30.0,
                  animationDuration: 2000,
                   percent: double.parse(widget.A1c)/14,//  _a1c/14, //_a1c(),
                  center: Text(( widget.A1c).toString() + 'التراكمي',
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
                  lineHeight: 30.0,
                  animationDuration: 2000,
                  // percent: _a1c(),
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
                  lineHeight: 30.0,
                  animationDuration: 2000,
               //   percent: _a1c(),
                  center: Text('الانسولين',
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
                  lineHeight: 30.0,
                  animationDuration: 2000,
                //  percent: _a1c(),
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

// void _BGTotal() async{
//   var total = (await helper.BGTotal())[0]['Total'];
//     print("num3: $total");

//   setState(() => _sum = total);
// }

 Future _getA1c() async{
String re= (await helper.getA1C(widget.id[0]['email'].toString()))[0]['a1C'];
print("_getA1c :$re"); 

   a1c= double.parse(re);
print("******************_getA1c :$_a1c"); 
// setState(() => a1c=double.parse(re));
//   setState(() => _num=num);
 }

//  a11c()  {

// _getA1c();

// }  

}


