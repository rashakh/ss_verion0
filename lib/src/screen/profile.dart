import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../utils/database_helper.dart';

class Profile extends StatelessWidget {
  Profile(this.id, this.BMI, this.A1c,this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
  DatabaseHelper helper = DatabaseHelper();

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
              'الملف الشخصي',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body(id,BMI,A1c,carb)),
        ));
  }
}

class Body extends StatefulWidget {
  Body(this.id, this.BMI, this.A1c,this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;

   // String gender,type;

  @override


  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {

 DatabaseHelper helper = DatabaseHelper();

//  initState() {
//    super.initState();
//    _weight =_getwight() as int;
//  }
    
      String gender,type;
      @override
     
     
    
      Widget build(BuildContext context) {
     //   _getwight();
print(widget.BMI[0]['wit']);
                var weight=widget.BMI[0]['wit'];

      if((widget.id[0]['gender'])==0){
       gender="أنثى"; 
      }
      else{
       gender="ذكر";
      }
      if((widget.id[0]['type'])==0){
        type= "نوع 1";
      }
      else{
        type = "نوع 2";
      }
    
        return new Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(top: 20.0, left: 1.0, right: 1.0),
            child: Column(
              children: <Widget>[
                new Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      new Text(
                                        'الاسم الاول : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      new Text(
                                        '${widget.id[0]['fname'].toString()}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                new Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      new Text(
                                        'الاسم الاخير : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      new Text(
                                        '${widget.id[0]['lname'].toString()}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20.0, top: 10.0),
                          child: new Row(children: <Widget>[
                            new Expanded(
                              child: Row(
                                children: <Widget>[
                                  new Text(
                                    'الوزن : ',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  new Text(
                                    '$weight',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 50.0,
                              ),
                              child: new Text(
                                'كغم',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(
                                  left: 3.0,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    new Text(
                                      'الطول : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    new Text(
                                     '${widget.id[0]['hight'].toString()}',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: new Text(
                                'متر',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ]),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'نوع الجنس : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                                '$gender',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'نوع السكري : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                                '$type',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'تاريخ الميلاد : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                               '${(widget.id[0]['bd'].toString()).substring(0,10)}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'تاريخ التشخيص : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                                '${(widget.id[0]['dd'].toString()).substring(0,10)}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'رقم الطوارئ : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                                '${widget.id[0]['number'].toString()}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Divider(
                          color: Color(0xFFBDD22A),
                          height: 30.0,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 15.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                'البريد الإلكتروني : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700],
                                ),
                              ),
                              new Text(
                                '${widget.id[0]['email'].toString()}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      }
    
    void _getwight() async{

    var weight= (await helper.getWight(widget.id[0]['email']))[0]['wit'];
    //print(weight);
 //  return weight;
setState(() {
  weight= weight;});
      }

       
}
