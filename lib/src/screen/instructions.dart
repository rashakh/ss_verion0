import 'package:dtfbl/src/screen/profile.dart';
import 'package:dtfbl/src/screen/pt.dart';
import 'package:flutter/material.dart'; // flutter main package
//import 'package:dtfbl/src/widgets/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';
import 'dart:async';
import 'dart:convert'; // convert json into data
import 'package:http/http.dart'
    as http;

import 'exportPDF.dart';
import 'medalert.dart'; // perform http request on API to get the into

class Instructions extends StatelessWidget {
  Instructions(this.id, this.BMI, this.A1c,this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
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
                  MaterialPageRoute(builder: (context) => MedAlert(id,BMI,A1c,carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeriodicTest(id,BMI,A1c,carb)),
                );
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportPDF(id,BMI,A1c,carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(id, BMI,A1c,carb)),
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
      body: new SingleChildScrollView(child: new Body(id,BMI,A1c,carb)),
    );
  }
}

class Body extends StatefulWidget {
  Body(this.id,this.BMI,this.carb,this.A1c);
  var id;
  var BMI;
  var A1c;
  var carb;
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
  final String url =
      'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  var insts;
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
      insts = responseBoddy;
      _visible = !_visible;
      //['name of area in the database or in the json data']; // user for example
    });
    return 'Success!'; // tell whether|not get the json
  }

  Widget _instrTxt(String title, String info) {
    return new Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Container(
          margin: new EdgeInsets.only(top: 10.0),
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
        // new Container(
        //   width: 300.0,
        //   height: 100.0,
        //   margin: new EdgeInsets.symmetric(vertical: 7.0),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     shape: BoxShape.rectangle,
        //     borderRadius: new BorderRadius.circular(8.0),
        //     boxShadow: <BoxShadow>[
        //       new BoxShadow(
        //         color: Colors.black12,
        //         blurRadius: 50.0,
        //         offset: new Offset(0.0, 5.0),
        //       ),
        //     ],
        //   ),
        //   child: Center(
        //       child: Text(
        //     'صورة',
        //     style: Styles.productRowItemName,
        //   )),
        // ),
        Container(
          margin: new EdgeInsets.symmetric(vertical: 90.0, horizontal: 40.0),
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
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {  
  //  future: NoteProvider.getNoteList(),
  //     Builder: (context,snapshot){}
    return new Directionality(
        
        textDirection: TextDirection.rtl,
        
        child:  Stack(
          children: <Widget>[
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: insts == null ? 0 : 1,
                //itemCount: insts == null ? 0 : insts.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    child: Column(
                      children: <Widget>[
_instrTxt('الكربوهيدرات',
                        'الكربوهيدرات البسيطة تتحلل بسرعة الى جلوكوز لترفع مستوى السكر في الدم.\n\nمثال: الاطعمة المصنعة و المكررة، الارز الابيض\n\n\nالكربوهيدرات المعقدة تتحل بشكل ابطئ مما يساعد على الشعور بالشبع ويبطئ ارتفاع مستوى السكر في الدم.\n\nمثال: الارز الاسمر، الدقيق الاسمر، الشوفان'),
                  _instrTxt('تحليل السكر التراكمي A1C',
                        'هو تحليل يظهر مدى تحكم الفرد بمستوى السكر في الدم على مدار ثلاث اشهر.\n\nتتراوح قيمته بين ٤ و ١٤\n\nمن الجيد ان تكون قيمته بين ٥ و ٧، وكلما زاد عن ذلك كل ما كان الشخص معرض للمخاطر.\n\nاذا كان تحليل السكر التراكمي مرتفع عن ٨، يكون الشخص عرضه لامراض خطيرة مثل امراض الكلى و العين'),
                  
                  _instrTxt('مواضع حقن الأنسولين',
                        'افضل المواضع لحقن الأنسولين: الذراعين، البطن،الفخذين، الردفين.\n\nيحقن الأنسولين في النسيج تحت الجلد\n\nيجب مراعاة تغيير مواضع الحقن من فترة الى اخري، لان الحقن المستمر في نفس الموضع يسبب تليف الموضع، بالتالي لا يمر الأنسلين خلال الانسجة.\n\nقبل الحقن يجب ان تتأكد من تعقيم الموضع، وخلوه من اي اورام، وان شعرت بذلك لا تحقن في نفس الموضع حتى تزول الاورام'),
                  
                  _instrTxt('كن على اهبة الاستعداد',
                        'من المهم ان تستعد و تعد احتياطاتك في جميع الظروف و الاسباب.\n\nدائما ارتدي سوارا وبطاقة تبين انك مصاب  سكري\n\n احمل دائما معك قطعه حلوى في حال شعرت باعراض انخفاض السكر.\n\nفي حاله السفر لا تنسى ان تستخدم حقيبة اليد لحمل الانسولين و الابر، و جهاز قياس السكر، وايضا خذ معك كمية اكبر من الانسولين'),
                  
                      ],
                    ),
                    //_instrTxt('Issue','information about the issue'),
                    
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
