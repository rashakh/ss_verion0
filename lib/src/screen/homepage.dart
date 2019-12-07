import 'dart:developer';

import 'package:dtfbl/src/screen/mainpage.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'package:percent_indicator/percent_indicator.dart';
import './medalert.dart';
import './pt.dart';
import './profile.dart';
import 'exportPDF.dart';
//import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage(this.id, this.BMI, this.A1c, this.carb);
  var id;
  var BMI;
  double A1c;
  var carb;

  @override
  Widget build(BuildContext context) {
    print("this is a1c ${this.A1c}");
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
                  MaterialPageRoute(
                      builder: (context) => MedAlert(id, BMI, A1c, carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PeriodicTest(id, BMI, A1c.toString(), carb)),
                );
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExportPDF(id, BMI, A1c.toString(), carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(id, BMI, A1c.toString(), carb)),
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
      body: new SingleChildScrollView(child: new Body(id,
       BMI,
        A1c,
         carb)),
    );
  }
}

class Body extends StatefulWidget {
  Body(this.id, this.BMI, this.A1c, this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
  @override
  State createState() => new _Bodystate();
}
// double a1c = 0;
int i=0;
class _Bodystate extends State<Body> {
  DatabaseHelper helper = DatabaseHelper();
  double a1c =0.0;
  var _sum = 0;
  var _num = 0;
  var dd = 45 * 0.55;
  var bgratio;
  Widget icon = Icon(
    Icons.mood,
    color: Colors.green,
    size: 40.0,
  );
  int mealid;
  Color colorA1c = Colors.green;
  Color colorcarb = Colors.green;
 
   double _a1c() {
setState(() {  a1c=widget.A1c;});
    var n = a1c / 14;
    print('n: $n');
    _bgratio();
        mea();

    return n;
  }

  // doub le _carb() {
  // // _getA1c();
  //   var n = widget / 100;
  //   print('n: $n');
  //   _bgratiocarb();
  //   return n;
  // }

  Future _bgratio() {
    if (widget.A1c <= 6.5) {
      icon = Icon(
        Icons.mood,
        color: Colors.green,
        size: 40.0,
      );
      colorA1c = Colors.green;
    }


     else if (widget.A1c> 6.5 &&
     widget.A1c <= 8.0) {
      icon = Icon(
        Icons.mood,
        color: Colors.orangeAccent,
        size: 40.0,
      );
      colorA1c = Colors.orangeAccent;
    } else {
      icon = Icon(
        Icons.mood_bad,
        color: Colors.redAccent,
        size: 40.0,
      );
      colorA1c = Colors.redAccent;
    }
  }

  Future _bgratiocarb() {
    if (widget.A1c <= 6.0) {
      icon = Icon(
        Icons.mood,
        color: Colors.green,
        size: 40.0,
      );
      colorcarb = Colors.green;
    } else if (widget.A1c > 6.0 && widget.A1c <= 8.0) {
      icon = Icon(
        Icons.mood,
        color: Colors.orangeAccent,
        size: 40.0,
      );
      colorcarb = Colors.orangeAccent;
    } else {
      icon = Icon(
        Icons.mood_bad,
        color: Colors.redAccent,
        size: 40.0,
      );
      colorcarb = Colors.redAccent;
    }
  }

  // void initState() {
  //  super.initState();
  //   //this._getA1c();
  //   this._bgratio();}

  @override

  Widget build(BuildContext context) {

    print("crunt widget.A1c in homepage :${ widget.A1c}");
  
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
                  percent: 
                      _a1c(), 
                  center: Text('$a1c :التراكمي',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: colorA1c,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 30.0,
                  animationDuration: 2000,
                  percent: 0.2,// _carb(),
                  center: Text('30 / 220 :الكاربوهيدرات',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: colorcarb,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 30.0,
                  animationDuration: 2000,
                     percent:0.25,  //_a1c(),
                  center: Text('الانسولين: 10/40 وحدة',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor:   Colors.green,  //colorA1c,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 35.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70,
                  animation: true,
                  lineHeight: 30.0,
                  animationDuration: 2000,
                    percent: 0.5, //_a1c(),
                  center: Text('النشاط البدني: 70/135 دقيقة',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.yellow, //colorA1c,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 1.0, right: 1.0),
                child: Column(
                  children: <Widget>[
                    new Card(
                      elevation: 5.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.only(
                                left: 234.0,
                                right: 30.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: new Text(
                              'الوجبة الاخيرة : ',
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),

          FutureBuilder(
            future: helper.getfood(widget.id[0]['email']),
            builder: (context, snapshot) {
            print("meal id of list : ${snapshot.data==null}");
          if (snapshot.connectionState == ConnectionState.done && snapshot.data!=null ) {
            print("hi list view");
              final foods=snapshot.data;
            print("meal id of list : ${foods.length}");
              var i= ((foods.length==null)? 0:foods.length) *50.0 ;
        return new Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: SizedBox(
                                        height: i,
                                        child:    
               ListView.builder(
                 
                itemBuilder: (context, index){
               print(foods[index]['varcarb']);
                return  
                new Padding(
                              padding: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              child: new Row(
                                children: <Widget>[
                                  new Text(
                                    '${foods[index]['eat']}',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  new Container(
                                      margin: new EdgeInsets.only(
                                          top: 10.0, left: 5.0, right: 5.0),
                                      height: 2.0,
                                      width: 10.0,
                                      color: Colors.blueGrey),
                                  new Text(
                                    'الكاربوهيدرات: ',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  new Text(
                                    '${foods[index]['varcarb']}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_forever,
                                        size: 30.0, color: Colors.red),
                                    onPressed: () async {
                                      
                                      var result =await helper.deleteVariety(
                                        foods[index]['id'],foods[index]['email'].toString(),foods[index]['mealId']);
                                                print(result);
                                                // Navigator.pop(context);
                                                //Navigator.of(context).popAndPushNamed(routeName)
                                                Navigator.pushReplacement(
                                                    context,MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPage(widget.id,widget.BMI,widget.A1c,widget.carb)));
                                    },
                                  ),
                                ],
                              ),
                            );
                       
                           
                },
                itemCount:foods.length ,
              ),
//--------------------------------------------------------
                                      ),
                                      ),
                                    ],
                                      );
          }
          else{
            return new Container();
          }
         // return Center(child: CircularProgressIndicator());
            },
         )


                  ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }                            
                              // ),
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
                          //     ))

// void _BGTotal() async{
//   var total = (await helper.BGTotal())[0]['Total'];
//     print("num3: $total");

//   setState(() => _sum = total);
// }

  // Future _getA1c() async {
  //   String re =
  //       (await helper.getA1C(widget.id[0]['email'].toString()))[0]['a1C'];
  //   print("_getA1c :$re");

  //   a1c = double.parse(re);
  //   print("******************_getA1c :$_a1c");
// setState(() => a1c=double.parse(re));
//   setState(() => _num=num);
  // }

//  a11c()  {

// _getA1c();

// 

// void hi()async{
// var hi= await helper.getMeal(widget.id[0]['email']);

// print("get hi: $hi");

// }

//git heal id:
void mea() async {
                     var meali = await helper.getMeal(widget.id[0]['eamil']);
                      print('last meal result id of homepage : $meali');
                      if(!meali.isEmpty){
                      var mealid= meali[0]["mealId"];
                      print('meal result id : $mealid');

//setState(() {
  meali=mealid;
  print("meali is :$meali");
//});
}
else{
//setState(() {
  meali=0;
  print("meali is :$meali");
//});
}
}
}

