import 'package:dtfbl/src/screen/profile.dart';
import 'package:dtfbl/src/screen/pt.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'package:dtfbl/src/widgets/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert'; // convert json into data
import 'package:http/http.dart'
    as http;

import 'exportPDF.dart';
import 'medalert.dart'; // perform http request on API to get the into

class Medications extends StatelessWidget {
  Medications(this.id);
  var id;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'الادوية',
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
                  MaterialPageRoute(builder: (context) => Profile(id)),
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
      body: Container(
        alignment: Alignment.topCenter,
        child: new SingleChildScrollView(child: new Body()),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
  final String url =
      'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  var meds;
  bool _visible = true;
  // function make the http request
  Future<String> getData() async {
    var response = await http // .get(url)
        .get(Uri.encodeFull(url), headers: {
      'Accept': 'application/json' // 'key': 'ur key'
    }); // .get(encode the response data as json) with headers which tell the code should be json
    // after response back, setup the state for the application
    setState(() {
      var responseBoddy = json.decode(response.body);
      print(responseBoddy);
      meds = responseBoddy;
      _visible = !_visible;
      //['name of area in the database or in the json data']; // user for example
    });
    return 'Success!'; // tell whether|not get the json
  }

  Widget _medicTxt(String title, String info, AssetImage image) {
    return Column(
      children: <Widget>[
        new Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(top: 7.0),
              width: 360.0,
              height: 470.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomLeft, colors: [
                  Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
                      .withOpacity(0.3),
                  Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
                      .withOpacity(0.3)
                ]),
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
              height: 140.0,
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
                child: new Image(
                  image: image,
                ),
                //     Text(
                //   'Medicine Pic',
                //   style: Styles.productRowItemName,
                // )
              ),
            ),
            Container(
              margin:
                  new EdgeInsets.only(left: 40.0, right: 40.0, top: 180.0, bottom: 70.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    new Text(
                      title,
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
                      info,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: <Widget>[
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: meds == null ? 0 : 1,
                // itemCount: meds == null ? 0 : meds.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    child: Column(
                      children: <Widget>[
_medicTxt('اكاربوز (جلوكوباي)',
                        'يستخدم للنوع الثاني من مرض السكري.\nيقلل من متسوى السكر في الدم.\n\nاذا شعرت بهذه الاعراض اخبر الطبيب:\n-ارتفاع في درجه الحرارة.\n-غثيان ومغص وفقدان شهية.\n-اصفرار الجلد.',new AssetImage('assets/acarbose.png')),
                   
                   _medicTxt('ريباجلينايد (نوفونورم)',
                        'يستخدم للنوع الثاني من مرض السكري، ولا يستخدم للنوع الاول.\nيحفز البنكرياس لإفراز هرمون الانسولين.\n\nاذا شعرت بهذه الاعراض اخبر الطبيب:\n- تشنجات.\n-اصفرار الجلد او العين.\n-صداع الم في الظهر او المفاصل.',new AssetImage('assets/novonorm.jpg')),
                   
                   _medicTxt('انسولين قصير التأثير (الصافي)',
                        'هو الانسولين المنتظم و يعد اكثر انواع الانسولين استقرارا .\n\nيؤخذ قبل الوجبة بـ ٣٠ دقيقة.\n\nاذا كان السائل معكرا فيجب التخلص من الزجاجة.',new AssetImage('assets/insulin1.jpg')),
                   
                   _medicTxt('انسولين متوسط التأثير (العكر)',
                        'هذا النوع من الانسولين يجب تحريكه داخل الزجاجه قبل الاستخدام.\n\nيؤخذ قبل الافطار، ،قبل النوم .\n\nيجب ان تتبع تعليمات طبيبك عند استخدام هذا الانسولين.',new AssetImage('assets/insulin2.jpg')),
                   
                      ],
                    )
                    
                    //_medicTxt(meds[index]["Medicine"], meds[index]["info"]),
                  );
                }),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 600),
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: new SpinKitThreeBounce(
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
                      .withOpacity(0.2),
                  size: 100.0,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}
