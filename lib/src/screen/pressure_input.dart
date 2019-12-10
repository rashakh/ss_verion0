import 'package:dtfbl/diabetes_icons_icons.dart';
import 'package:dtfbl/src/models/A1C.dart';
import 'package:dtfbl/src/models/pressure.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/styles.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:async';
import 'dart:convert'; // convert json into data
// import 'package:http/http.dart'
//     as http; // perform http request on API to get the into
import 'package:rflutter_alert/rflutter_alert.dart';

import 'mainpage.dart';
class Pressureinput extends StatelessWidget {
  Pressureinput(this.id, this.BMI, this.A1c,this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            title: new Text(
              'اضافة ضغط الدم',
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
  List<Map<String,dynamic>> BMI;
  double A1c;
  var carb;
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
    DatabaseHelper helper = DatabaseHelper();

  // final String url =
  //     'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
// bool _result;
  int pressureSys = 120;
  int pressureDia = 85;
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  DateTime dateTime = DateTime.now();
  String note = '';
  AlertType alerttype = AlertType.success;
  String decision = '';
  String titel = ' : نقترح عليك ان';
  // Future<bool> _postData() async {
  //   // map data to converted to json data
  //   final Map<String, dynamic> userData = {
  //     'email': widget.id[0]['email'],
  //     'PressureSys': pressureSys,
  //     'pressureDia': pressureDia,
  //     'DateTime': dateTime.toIso8601String(),
  //     'Note': note,
  //   };
  //   var jsonData = JsonCodec().encode(userData); // encode data to json
  //   var httpclient = new http.Client();
  //   var response = await httpclient.post(url,
  //       body: jsonData, headers: {'Content-type': 'application/json'});
  //   print('the body of the response = \n${response.body}\n.');
  //   _result =
  //       response.statusCode >= 200 || response.statusCode <= 400 ? true : false;
  // }

  void decisionFun() {
    setState(() {
      
      print('this is the pressureDia = $pressureDia');
      print('this pressureSys = $pressureSys');
      if (pressureSys <90 && pressureDia<=60) {
        alerttype = AlertType.warning;
        titel='لديك انخفاض ضغط';
        decision =
            ' اكثر من شرب الماء- \n  تناول طعام حامض -';
      } else if ((pressureSys>=91 && pressureSys<=129) && (pressureDia>60 && pressureDia<80)) {
        alerttype = AlertType.success;
        decision =
            ' ان تحافظ دائما على مستوى الضغط الحالي ';
      } else if (pressureSys == 130 && pressureDia == 80) {
        alerttype = AlertType.success;
        decision =
            ' مستوى الضغط لديك جيد، لكن حاول أن يكون هدفك مابين (91-120 )/(60-80) ';
      } else if ((pressureSys >130 && pressureSys <= 179) || (pressureDia >=80 && pressureDia <=89)) {
        alerttype = AlertType.warning;
        titel='لديك ارتفاع ضغط';
        decision =
            ' اكثر من شرب الماء -\n تناول اطعمة غنية بالبوتاسيوم كالموز - \n حاول الجلوس  والاسترخاء -\n ابتعد الكافيين والاطعمة المالحة -';
      }
        else if (pressureSys >=180 || pressureDia>120) {
        alerttype = AlertType.warning;
        titel='لديك نوبة ارتفاع ضغط';
        decision =
            ' تناول ادويتك لارتفاع الضغط اذا كان لديك -\nاو اطلب العناية الطبية فوراً -';
        }
    });
  }

  void _onChangedSys(e) {
    setState(() {
      print('this is pressure ${widget.id}');
      if (e > 140 || e < 120) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا جيد';
      }
      pressureSys = e;
    });
  }

  void _onChangedDia(e) {
    setState(() {
      if (e > 90 || e < 80) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا جيد';
      }
      pressureDia = e;
    });
  }

  Widget _pressure() {
   print("check in pressuer ${widget.BMI}, ${widget.A1c}");

    return Card(
        child: Padding(
      padding: const EdgeInsets.only(right: 50.0, top: 15.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: TextSpan(
              text: 'ضغط الدم ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(الانبساطي / الانقباضي)',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              _pressureBackground(_onChangedDia, pressureDia, 110),
              Text(
                '\t/\t',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              _pressureBackground(_onChangedSys, pressureSys, 180),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            evaluation,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: slider,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _pressureBackground(Function fun, pressure, max) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          height: 90.0,
          width: 130.0,
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius: new BorderRadius.circular(
              (80.0),
            ),
          ),
          child: new Center(
            child: new Theme(
              data: ThemeData(
                accentColor: slider,
              ),
              child: new NumberPicker.horizontal(
                  initialValue: pressure,
                  minValue: 0,
                  maxValue: max,
                  itemExtent: 41,
                  onChanged: (e) => fun(e)),
            ),
          ),
        ),
        Icon(
          DiabetesIcons.swipe,
          color: slider,
          size: 28,
        ),
      ],
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'وقت القياس :',
          style: Styles.productRowItemName,
        ),
        Row(
          children: <Widget>[
            new Text(
              '(',
              style: Styles.productRowItemName,
            ),
            new IconButton(
              icon: Icon(
                Icons.access_time,
                color: CupertinoColors.activeBlue,
                size: 28,
              ),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _cupDate();
                  },
                );
              },
            ),
            new Text(
              ')',
              style: Styles.productRowItemName,
            ),
            SizedBox(width: 10.0),
          ],
        ),
        new Text(
          intl.DateFormat.yMMMd().add_jm().format(dateTime),
          style: Styles.productRowItemName,
        ),
        SizedBox(width: 5.0)
      ],
    );
  }

  Widget _cupDate() {
    return CupertinoDatePicker(
      initialDateTime: dateTime,
      minimumDate: DateTime(2018),
      maximumDate: DateTime.now(),
      mode: CupertinoDatePickerMode.dateAndTime,
      onDateTimeChanged: (e) => setState(() {
        if (e.isAfter(DateTime.now())) {
          e = DateTime.now();
        }
        dateTime = e;
      }),
    );
  }

  Widget _buildNoteField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.pen,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'ملاحظات',
      onChanged: (e) => setState(() {
        note = e;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          _pressure(),
          SizedBox(height: 40.0),
          _buildDateAndTimePicker(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 38.0, horizontal: 10.0),
            child: _buildNoteField(),
          ),
          SizedBox(height: 20.0),
          new ButtonTheme.bar(
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: Icon(Icons.check,size: 30.0,),
                  // Text('تمام',
                  //     style: TextStyle(
                  //       fontSize: 20.0,
                  //     )),
                  onPressed: ()  async{

                    print("click 1 BP BPruss=BG(${widget.id[0]['email'].toString()}, $pressureSys, $pressureDia, $note,${dateTime.toIso8601String()}");
                    BP bp=BP(widget.id[0]['email'].toString(), pressureSys, pressureDia, note,dateTime.toIso8601String());
                      var mealw = await helper.insertBP(bp);
                    print("click 2: $mealw");

                        decisionFun();
                        Alert(
                          style: AlertStyle(
                            isCloseButton: false,
                          ),
                          context: context,
                          type: alerttype,
                          title: titel,
                          desc: decision,
                          buttons: [
                            DialogButton(
                              child: Text(
                                'حسنا',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(widget.id,
                                        widget.BMI, widget.A1c, widget.carb)),
                              ),
                              width: 120,
                            )
                          ],
                        ).show();
                       }

                ),
                SizedBox(width: 160.0),
                new FlatButton(
                  child: Icon(Icons.close,size: 30.0,color: Colors.red),
                  // Text('الغاء',
                  //     style: TextStyle(fontSize: 20.0, color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
