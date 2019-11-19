import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/styles.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:async';
import 'dart:convert'; // convert json into data
import 'package:http/http.dart'
    as http; // perform http request on API to get the into
import 'mainpage.dart';
class Weightinput extends StatelessWidget {
  Weightinput(this.id);
  var id;
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
          body: new SingleChildScrollView(child: new Body(id)),
        ));
  }
}

class Body extends StatefulWidget {
  Body(this.id);
  var id;
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {
  final String url =
      'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  bool _result;
  int weight = 57;
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  DateTime dateTime = DateTime.now();
  String note = '';

  Future<bool> _postData() async {
    // map data to converted to json data
    final Map<String, dynamic> userData = {
      'email': widget.id[0]['email'],
      'Weight': weight,
      'DateTime': dateTime.toIso8601String(),
      'Note': note,
    };
    var jsonData = JsonCodec().encode(userData); // encode data to json
    var httpclient = new http.Client();
    var response = await httpclient.post(url,
        body: jsonData, headers: {'Content-type': 'application/json'});
    print('the body of the response = \n${response.body}\n.');
    _result =
        response.statusCode >= 200 || response.statusCode <= 400 ? true : false;
  }

  Widget _weight() {
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
                const EdgeInsets.symmetric(vertical: 68.0, horizontal: 10.0),
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
                  onPressed: () => setState(() {
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(widget.id)),
                        );
                  }),
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
