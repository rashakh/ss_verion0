import 'package:dtfbl/src/models/wieght.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/styles.dart';
import 'package:intl/intl.dart' as intl;

import 'mainpage.dart';
class Weightinput extends StatelessWidget {
  Weightinput(this.id, this.BMI, this.A1c,this.carb);
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
              'اضافة وزن',
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
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
    DatabaseHelper helper = DatabaseHelper();
  // final String url =
  //     'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  // bool _result;
  int weight = 57;
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  DateTime dateTime = DateTime.now();
  String note = '';

  // Future<bool> _postData() async {
  //   // map data to converted to json data
  //   final Map<String, dynamic> userData = {
  //     'email': widget.id[0]['email'],
  //     'Weight': weight,
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

  Widget _weight() {
    print("check wighgt ${widget.A1c}");
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: TextSpan(
              text: 'الوزن ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(كيلوغرام)',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          _weightBackground(),
          SizedBox(height: 10.0),
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

  Widget _weightBackground() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          height: 130.0,
          width: 190.0,
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
                textTheme: TextTheme(),
              ),
              child: new NumberPicker.horizontal(
                  initialValue: weight,
                  minValue: 10,
                  maxValue: 400,
                  itemExtent: 60,
                  onChanged: (e) => setState(() {
                        print('this is weight ${widget.id}');
                        if (e > 130 || e < 30) {
                          slider = Colors.redAccent[400];
                          evaluation = 'هذا ليس جيد';
                        } else {
                          slider = Colors.greenAccent[400];
                          evaluation = 'هذا جيد';
                        }
                        weight = e;
                      })),
            ),
          ),
        ),
        Icon(
          Icons.arrow_drop_up,
          color: slider,
          size: 40,
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
          _weight(),
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
                  onPressed: ()  async {
                          print("click 1 wb wb=BG(${widget.id[0]['email'].toString()}, $weight, ${(((weight / widget.id[0]['hight']) / widget.id[0]['hight']) * 10000)}, $note,${dateTime.toIso8601String()}");
                    BW bw=BW(widget.id[0]['email'].toString(), weight, (((weight / widget.id[0]['hight']) / widget.id[0]['hight']) * 10000), note,dateTime.toIso8601String());
                      var mealw = await helper.insertBW(bw);
                    print("click 2: $mealw");
                    print("A1c:${widget.A1c}");
                    // if(widget.A1c==null){
                    //   var A1cr=await helper.getA1C(widget.id[0]['email'].toString()).toString();
                    //   print("new A1c: $A1cr");
                    // }
                    var f=await helper.getWight(widget.id[0]['email'].toString());
                    var d= await helper.getA1C(widget.id[0]['email'].toString());
                    var bmii=(((weight / widget.id[0]['hight']) / widget.id[0]['hight']) * 10000);
                    setState(()  {
                      widget.BMI=f;
                      widget.BMI=[{'wit':weight},{'bmi':bmii}];
                      //widget.BMI[0]['wit'];
                      widget.A1c= d;
                      print("hi: ${widget.BMI},${widget.A1c}");});
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(widget.id,widget.BMI,widget.A1c,widget.carb)),
                        );
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





// // new BMI:
//   Future a11c() {
//     double wBMI;
//     print("$_sum  : $_num");
//     if (_num == 0 && _sum == 0) {
//       double average = 0;
//       print("average0: $average");
//       wA1c = (46.7 + average) / 28.7;
//     } else {
//       double average = _sum / _num;
//       print("average1: $average");
//       wA1c = (46.7 + average) / 28.7;
//     }
//     print("wA1c: $wA1c");

//     double mod = pow(10.0, 1); 
//     var nwe =((wA1c * mod).round().toDouble() / mod);
//     print("wA1c After: $nwe");
//     widget.A1c=nwe;
//     if(_rec==0){ //if new user 
//     DateTime newdate = dateTime.add(new Duration(days: 90));
//     A1C ss = A1C(nwe,widget.id[0]['email'].toString() ,dateTime.toIso8601String(), newdate.toIso8601String());
//     print("ss: ${ss.dS}, : ${ss.dE} :${ss.a1C}");
//     _A1CIn(ss);
//       print("insert");
//     }
//     else{  //else update the number:
//     _A1CUP(nwe);
//     print("update");

//     }
//   }
  
//   //insert A1C:
//   void _A1CIn(A1C a) async {
//     var ree = await helper.insertA1C(a);
//     print("insert: $ree");
//   }

// //Update A1C:
//  void _A1CUP(double a) async {
//     var ree = await helper.UpdatetA1C(a,widget.id[0]['email'].toString());
// print("update: $ree");
//   }


}
