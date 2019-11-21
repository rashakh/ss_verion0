import 'package:flutter/material.dart'; // flutter main package
import 'package:dtfbl/src/widgets/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math';
import 'dart:async';
import 'dart:convert'; // convert json into data
import 'package:http/http.dart'
    as http; // perform http request on API to get the into
import 'mainpage.dart';

List<Map<String, double>> _carbs = [];
double _sum = 0.0;
int _inter = 0;

class Meals extends StatelessWidget {
  Meals(this.id);
  var id;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'الوجبات',
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
      body: new SingleChildScrollView(child: new Body(id)),
    );
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
  // Db db = new Db("mongodb://localhost:27017/mongo_dart-blog");
  // await db.open();
  var meals;
  bool _visible = true;
  DateTime dateTime = DateTime.now();
  String note = '';
  int slot = _slot();
  List<String> slots = const <String>[
    'الفطور',
    'الغداء',
    'العشاء',
    'وجبة خفيفة',
  ];
  static int _slot() {
    int slot;
    if (DateTime.now().hour >= 6 && DateTime.now().hour < 12)
      slot = 0;
    else if (DateTime.now().hour >= 12 && DateTime.now().hour < 17)
      slot = 1;
    else if (DateTime.now().hour >= 17 && DateTime.now().hour < 20)
      slot = 3;
    else if (DateTime.now().hour >= 20 || DateTime.now().hour < 00)
      slot = 2;
    else
      slot = 0;
    return slot;
  }

  Widget _buildSlotPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'وجبة :',
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
                Icons.fastfood,
                color: CupertinoColors.activeBlue,
                size: 28,
              ),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _cupPicker();
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
        SizedBox(width: 90.0),
        new Text(
          slots[slot],
          style: Styles.productRowItemName,
        ),
        SizedBox(width: 20.0),
      ],
    );
  }

  Widget _cupPicker() {
    return CupertinoPicker(
      itemExtent: 40.0,
      backgroundColor: Colors.white,
      children: new List<Widget>.generate(slots.length, (slot) {
        return new Center(
          child: new Text(
            slots[slot],
            style: Styles.productRowItemName,
          ),
        );
      }),
      onSelectedItemChanged: (e) => setState(() {
        slot = e;
      }),
    );
  }

  // function make the http request
  Future<String> getData() async {
    _sum = 0.0;
    _carbs = [];
    _inter = 0;
    var response = await http // .get(url)
        .get(Uri.encodeFull(url), headers: {
      'Accept': 'application/json' // 'key': 'ur key'
    }); // .get(encode the response data as json) with headers which tell the code should be json

    // after response back, setup the state for the application
    setState(() {
      var responseBoddy = json.decode(response.body);
      meals = responseBoddy;
      print(responseBoddy);
      _visible = !_visible;
      //['name of area in the database or in the json data']; // user for example
    });

    return 'Success!'; // tell whether|not get the json
  }

  // @override
  // void dispose() {
  //   _ischange();
  //   super.dispose();
  // }

  Widget _carbsCalculator() {
    return new CupertinoTextField(
      readOnly: true,
      prefix: new Row(
        children: <Widget>[
          const Icon(
            Icons.functions,
            color: CupertinoColors.activeBlue,
            size: 28,
          ),
          new SizedBox(
            width: 10.0,
          ),
          new Text(
            'مجموع الكربوهيدرات: \t\t' + _sum.toStringAsFixed(1),
            style: Styles.productRowItemName,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'وقت الوجبة :',
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
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

  Widget _insider() {
    return new Stack(children: [
      Column(
        children: <Widget>[
          new Container(
            height: 35.0,
            color: Colors.grey[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // new Container(
                //   alignment: Alignment.centerRight,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: new BorderRadius.circular(80.0),
                //     boxShadow: <BoxShadow>[
                //       new BoxShadow(
                //         color: Colors.black12,
                //         blurRadius: 50.0,
                //         offset: new Offset(0.0, 5.0),
                //       ),
                //     ],
                //   ),
                //   height: 40.0,
                //   width: 290.0,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                //     child: new CupertinoTextField(
                //       prefix: Icon(
                //         Icons.search,
                //         color: CupertinoColors.activeBlue,
                //       ),
                //       placeholder: 'بـحـث',
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 10.0, vertical: 5.0),
                //       decoration: BoxDecoration(
                //         border: Border(
                //           bottom: BorderSide(
                //             width: 0,
                //             color: CupertinoColors.activeBlue,
                //           ),
                //         ),
                //       ),
                //       onChanged: (e) {
                //       },
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: new IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Color(0xFF2A79D2),
                      onPressed: () {
                        setState(() {
                          _inter = 0;
                        });
                      }),
                )
              ],
            ),
          ),
          new Expanded(
            child: new ListView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: meals == null ? 0 : meals.length,
                itemBuilder: (BuildContext context, int index) {
                  var meal = MealCard('تفاح', 30, 50, this);
                  return Column(
                    children: <Widget>[
                      MealCard('تفاح', 25.1, 95, this),
                      MealCard('القهوة', 0, 2, this),
                      MealCard('الموز', 34.3, 134, this),
                      MealCard('البيض', 0.7, 134, this),
                      MealCard('حليب', 10.9, 149, this),
                      MealCard('رز ابيض', 44.5, 205, this),
                      MealCard('الدجاج', 0, 114, this),
                      MealCard('تفاح', 30, 50, this)
                    ],
                  );
                }),
          ),
        ],
      ),
      new AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 600),
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: new SpinKitThreeBounce(
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
                .withOpacity(0.2),
            size: 100.0,
          ),
        ),
      ),
    ]);
  }

  Widget _grouping() {
    return Column(
      children: <Widget>[
        Expanded(
          child: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext contex, int index) {
              return new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 3.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          setState(() {
                            _inter = 1;
                          });
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 170.0,
                          height: 134.0,
                          decoration: BoxDecoration(
                            color: Colors.brown[400],
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
                          child: Text(
                            'كربوهيدرات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 15.0,
                      ),
                      new GestureDetector(
                        onTap: () {
                          setState(() {
                            _inter = 1;
                          });
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 170.0,
                          height: 134.0,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
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
                          child: Text(
                            'الياف',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          setState(() {
                            _inter = 1;
                          });
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 170.0,
                          height: 134.0,
                          decoration: BoxDecoration(
                            color: Colors.orange[400],
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
                          child: Text(
                            'دهون',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 15.0,
                      ),
                      new GestureDetector(
                        onTap: () {
                          setState(() {
                            _inter = 1;
                          });
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 170.0,
                          height: 134.0,
                          decoration: BoxDecoration(
                            color: Colors.pink[300],
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
                          child: Text(
                            'بروتينات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _wid() {
    return [_grouping(), _insider()];
  }

  var check = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Column(
        children: <Widget>[
          new SizedBox(
            height: 282,
            child: _wid()[_inter],
          ),
          new Card(
            child: new Column(
              children: <Widget>[
                _carbsCalculator(),
                _buildDateAndTimePicker(context),
                _buildSlotPicker(context),
                _buildNoteField(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 180.0, top: 5.0, bottom: 5.0),
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {
                        _carbs = [];
                        _sum = 0.0;
                        _inter = 0;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(widget.id)),
                        );
                      });
                    },
                    child: new Container(
                        alignment: Alignment.center,
                        height: 40.0,
                        decoration: new BoxDecoration(
                            color: Color(0xFFBDD22A),
                            borderRadius: new BorderRadius.circular(7.0)),
                        child: new Text("اضافة",
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            ),
          ),
          // MealCard('تفاح', 25.1, 95),
          // MealCard('القهوة', 0, 2),
          // MealCard('الموز', 34.3, 134),
          // MealCard('البيض', 0.7, 134),
          // MealCard('حليب', 10.9, 149),
          // MealCard('رز ابيض', 44.5, 205),
          // MealCard('الدجاج', 0, 114),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }
}

class MealCard extends StatefulWidget {
  String name;
  double carbs;
  int caloris;
  _Bodystate parent;
  MealCard(this.name, this.carbs, this.caloris, this.parent);
  @override
  MealCardState createState() => MealCardState();
}

class MealCardState extends State<MealCard> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        new Container(
          width: 380.0,
          height: 60.0,
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
          margin: new EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              new Container(
                  margin: new EdgeInsets.only(bottom: 7.0),
                  height: 2.0,
                  width: 55.0,
                  color: Colors.blueGrey),
              new Row(
                children: <Widget>[
                  new Text(
                    'الكاربوهيدرات: ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  new Text(
                    widget.carbs.toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 50.0),
                  new Text(
                    'الكالوري: ',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  new Text(
                    widget.caloris.toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.only(right: 300.0, top: 5.0),
          child: new Checkbox(
            activeColor: Color(0xFFBDD22A),
            checkColor: Colors.black,
            value: check,
            onChanged: (bool e) {
              setState(() {
                check = e;
                if (check == true) {
                  _carbs.add({widget.name: widget.carbs});
                  _sum += widget.carbs;
                }
                if (check == false) {
                  var index = _carbs.indexWhere((item)=>item.containsKey(widget.name));
                  _carbs.removeAt(index);
                  _sum -= widget.carbs;
                }
              });
              widget.parent.setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
