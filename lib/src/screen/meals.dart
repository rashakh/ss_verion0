import 'dart:ffi';

import 'package:dtfbl/src/models/carb.dart';
import 'package:dtfbl/src/models/meal.dart';
import 'package:dtfbl/src/models/variety.dart';
import 'package:dtfbl/src/models/variety.dart' as prefix0;
import 'package:dtfbl/src/screen/profile.dart';
import 'package:dtfbl/src/screen/pt.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
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
import 'exportPDF.dart';
import 'mainpage.dart';
import 'medalert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

DatabaseHelper helper = DatabaseHelper();

List<Map<String, double>> _carbs = [];
double _sum = 0.0;
int _inter = 0;
double dbcarb, dbvarycarb;
String dbemail, dbslot, dbnote, dbdm, dbeat;
int dbvarId;
int dbamount = 1;
int coun = 0;
List<List> varty = [];
List<Map<int, dynamic>> food = [];

// var varty =<Map>[];
// varty['id'];
//int sr;
class Meals extends StatelessWidget {
  Meals(this.id, this.BMI, this.A1c, this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
  @override
  Widget build(BuildContext context) {
    dbemail = id[0]['email'].toString();
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
                      builder: (context) => PeriodicTest(id, BMI, A1c, carb)),
                );
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExportPDF(id, BMI, A1c, carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الملف الشخصي'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Profile(id, BMI, A1c.toString(), carb)),
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
      body: new SingleChildScrollView(child: new Body(id, BMI, A1c, carb)),
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

class _Bodystate extends State<Body> {
  DatabaseHelper helper = DatabaseHelper();

  // final String url =
  //     'https://jsonplaceholder.typicode.com/posts'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  // Db db = new Db("mongodb://localhost:27017/mongo_dart-blog");
  // await db.open();
  //var meals;
  bool _visible = true;
  DateTime dateTime = DateTime.now();

  String note;
  int slot = _slot();
  AlertType alerttype = AlertType.success;
  String decision = '';
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

  //dbslot= slots[slot];
  void decisionFun() {
    setState(() {
double insulin = insulinUnit(_sum,  widget.BMI[0]['bmi']);
      if (widget.id[0]['gender'] == 0) {
        if (widget.BMI[0]['bmi'] <= 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 230; // it should be in database
          // insulin
         // double insulin = insulinUnit(_sum,  widget.BMI[0]['bmi']);
          String insu = '\nعدد جرعات الانسولين هي $insulin وحدة';
          if (slot == 0 || slot == 1) {
            double mealCarb = neededcarb * 0.2;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 2) {
            double mealCarb = neededcarb * 0.3;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 3) {
            double mealCarb = neededcarb * 0.1;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          }
        } else if (widget.BMI[0]['bmi'] > 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 180; // it should be in database
          // insulin
        //  double insulin = insulinUnit(_sum,  widget.BMI[0]['bmi']);
          String insu = '\nعدد جرعات الانسولين هي $insulin وحدة';
          if (slot == 0 || slot == 1) {
            double mealCarb = neededcarb * 0.2;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 2) {
            double mealCarb = neededcarb * 0.3;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 3) {
            double mealCarb = neededcarb * 0.1;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          }
        }
      } else if (widget.id[0]['gender'] == 1) {
        if (widget.BMI[0]['bmi'] <= 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 330; // it should be in database
          // insulin
         // double insulin = 0.0;
          String insu = '\nعدد جرعات الانسولين هي $insulin وحدة';
          if (slot == 0 || slot == 1) {
            double mealCarb = neededcarb * 0.2;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 2) {
            double mealCarb = neededcarb * 0.3;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 3) {
            double mealCarb = neededcarb * 0.1;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          }
        } else if (widget.BMI[0]['bmi'] > 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 220; // it should be in database
          // insulin
        //  double insulin = 0.0;
          String insu = '\nعدد جرعات الانسولين هي $insulin وحدة';
          if (slot == 0 || slot == 1) {
            double mealCarb = neededcarb * 0.2;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 2) {
            double mealCarb = neededcarb * 0.3;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          } else if (slot == 3) {
            double mealCarb = neededcarb * 0.1;
            if (mealCarb == _sum) {
              alerttype = AlertType.success;
              decision = insu;
            } else if (mealCarb < _sum) {
              alerttype = AlertType.warning;
              decision = 'تقلل من الكربوهيدرات في الوجبة التالية' + insu;
            } else if (mealCarb > _sum) {
              alerttype = AlertType.warning;
              decision = 'تزود من الكربوهيدرات في الوجبة التالية' + insu;
            }
          }
        }
      }
    });
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
                //print("clik 1");
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    //print("1:");
                    //print(_cupPicker);
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
        onSelectedItemChanged: (e) => {
              //print("clik 2"),
              setState(() {
                slot = e;
                dbslot = slots[slot];
              }),
            });
  }

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
                // print(
                //     "click 6: sum= $_sum and inter= $_inter and meals= $meals  and $_cupDate");

                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    print("click 7: $_cupDate");
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
        dbdm = e.toIso8601String();
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
        dbnote = note;
      }),
    );
  }

  /// ----------------------fayber list
  Widget _insiderfiber() {
    return new Stack(children: [
      Column(
        children: <Widget>[
          new Container(
            height: 35.0,
            color: Colors.grey[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //her was countenar of search
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
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  // var meal = MealCard(9, 'تفاح', 30, 50,1,this);
                  return Column(
                    children: <Widget>[
                      MealCard(1, 'القرنبيط', 25.1, 1, this),
                      MealCard(2, 'الكرفس', 63.7, 1, this),
                      MealCard(3, 'عصير برتقال', 13.41, 1, this),
                      MealCard(4, 'سبانخ مطبوخة', 7, 1, this),
                      MealCard(5, 'فلفل رومي', 6, 1, this),
                      MealCard(6, 'افوكادو', 17, 1, this),
                      MealCard(7, 'باذنجان مطبوخ', 9, 1, this)
                    ],
                  );
                }),
          ),
        ],
      ),
      new AnimatedOpacity(
        opacity: 0.0, // _visible ? 1.0 :0.0
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

//--------------- fat list
  Widget _insiderfat() {
    return new Stack(children: [
      Column(
        children: <Widget>[
          new Container(
            height: 35.0,
            color: Colors.grey[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  //              var meal = MealCard(9, 'تفاح', 30, 50,1,this);
                  return Column(
                    children: <Widget>[
                      MealCard(1, 'زيت الزيتون', 0, 1, this),
                      MealCard(2, 'مايونيز', 3.51, 1, this),
                      MealCard(3, 'زبدة المارجرين ( بدون ملح )', 0.02, 1, this),
                      MealCard(4, 'زبدة المارجرين (  مملحة )', 0.04, 1, this)
                    ],
                  );
                }),
          ),
        ],
      ),
      new AnimatedOpacity(
        opacity: 0.0, // _visible ? 1.0 :0.0

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

//------------- carb list
  Widget _insidercarb() {
    return new Stack(children: [
      Column(
        children: <Widget>[
          new Container(
            height: 35.0,
            color: Colors.grey[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //search
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
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  // var meal = MealCard(9, 'تفاح', 30, 50,1,this);
                  return Column(
                    children: <Widget>[
                      MealCard(1, 'البطاطا الحلوة', 23.61, 1, this),
                      MealCard(2, 'الذرة', 25, 1, this),
                      MealCard(3, 'الموز', 13.41, 1, this),
                      MealCard(7, 'التفاح', 25.13, 1, this),
                      MealCard(4, ' أرز البني', 36, 1, this),
                      MealCard(5, 'أرز ابيض', 44.5, 1, this),
                      MealCard(6, 'سلطة سيزر', 50, 1, this),
                    ],
                  );
                }),
          ),
        ],
      ),
      new AnimatedOpacity(
        opacity: 0.0, // _visible ? 1.0 :0.0

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

//----------- proten list

  Widget _insiderproten() {
    return new Stack(children: [
      Column(
        children: <Widget>[
          new Container(
            height: 35.0,
            color: Colors.grey[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //search
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
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  // var meal = MealCard(9, 'تفاح', 30, 50,1,this);
                  return Column(
                    children: <Widget>[
                      MealCard(1, 'حليب', 25.1, 1, this),
                      MealCard(2, 'جبنة', 63.7, 1, this),
                      MealCard(3, 'لبنة', 13.41, 1, this),
                      MealCard(4, 'لبن', 7, 1, this),
                      MealCard(5, 'لحم دجاج مطبوخ', 40, 1, this),
                      MealCard(6, 'لحم بقر مطبوخ ', 34, 1, this)
                    ],
                  );
                }),
          ),
        ],
      ),
      new AnimatedOpacity(
        opacity: 0.0, // _visible ? 1.0 :0.0

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

// الفئات:
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
                    height: 5.0,
                  ),
                  Text(
                    'اختر صنف الطعام :',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
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
                            _inter = 4;
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
                            _inter = 2;
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
                            _inter = 3;
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
    // print(
    //     "click 20: grouping:$_grouping()  , insider: $_insider(), meal:$MealCard(name, carbs, Amunt, parent)");

    //  if(sr==0){
    return [
      _grouping(),
      _insidercarb(),
      _insiderfat(),
      _insiderproten(),
      _insiderfiber()
    ];
  }

  var check = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Column(
        children: <Widget>[
          new SizedBox(
            height: 330,
            //print("click 21: inter:$_inter");
            //print("click 21: inter:$_wid()[_inter]");
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
                    onTap: () async {
                      double mod = pow(10.0, 1);
                      double nwe = ((_sum * mod).round().toDouble() / mod);
                      dbcarb = nwe;
                      //widget.carb=_sum;
                      dbslot = slots[slot];
                      dbdm = dateTime.toIso8601String();

                      Meal meal = Meal(dbemail, dbslot, dbcarb, dbnote, dbdm);
                      var mealw = await helper.insertMeal(meal);
                      var meali = await helper.getMeal(dbemail);
                      print('last meal result id : ${meali}');
                      var mealid = meali[0]["mealId"];
                      print('meal result id : $mealid');

// ------------------------------------------------------------------------------------------------------------
                      for (int i = 0; i < food.length; i++) {
                        var f = food.elementAt(i);
                        Variety vat = new Variety(f[0], meali[0]['mealId'],
                            f[1], dbemail, f[2], f[3]);
                        var vary = await helper.insertVariety(vat);
                        print(" FOOD ARE SAVE : vary");
                      }
                      // //get
                      // var vartget=await helper.getfood(dbemail);
                      // print("vart get: $vartget");

                      String date = dbdm.substring(0, 10);
                      var carb = await helper.getCarb(dbemail);
                      print("carb date: ${carb}");
                      //CARB:
                      print("carb date: ${carb.isNotEmpty}");
                      if (carb.isNotEmpty) {
                        if ((await helper.getCarb(dbemail))[0]['date'] ==
                            date) {
                          var update =
                              await helper.updataCarb(dbemail, dbcarb, date);
                          print("update carb: $update");
                        } else {
                          Carb carba = new Carb(dbcarb, dbemail, date);
                          //insert
                          var inser = await helper.insertCARB(carba);
                          print("inser carb: $inser");
                        }
                      } else {
                        Carb carba = new Carb(dbcarb, dbemail, date);
                        //insert
                        var inser = await helper.insertCARB(carba);
                        print("inser carb: $inser");
                      }
                      var cget = (await helper.getCarb(dbemail))[0]['curnt'];
                      double newcarb = cget as double;
//-----------------------------------------------------------------------------------------------------------------------------
                      setState(() {
                        decisionFun();
                        Alert(
                          style: AlertStyle(
                            isCloseButton: false,
                          ),
                          context: context,
                          type: alerttype,
                          title: ' : نقترح عليك ان',
                          desc: decision,
                          buttons: [
                            DialogButton(
                              child: Text(
                                'حسنا',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                food = [];
                                _carbs = [];
                                _sum = 0.0;
                                _inter = 0;
                                widget.carb = newcarb;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage(widget.id,
                                          widget.BMI, widget.A1c, widget.carb)),
                                );
                              },
                              width: 120,
                            )
                          ],
                        ).show();
                      });
                    },
                    child: new Container(
                        alignment: Alignment.center,
                        height: 47.0,
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
        ],
      ),
    );
  
  }

  @override
  void initState() {
    // print(
    //     "click 23: grouping:$_grouping()  , insider: $_insider(), meal:$MealCard($this.name, $this.carbs, $this.Amunt, $this.parent)");

    super.initState();
    // this.getData();
  }
}
  double insulinUnit(double totalcarb,double wit){
  //insulin unit:
double unit= wit *0.5;

double coff= 500/unit;

double durg= totalcarb/coff;
 double mod = pow(1.0, 1);
                      double nwe = ((durg * mod).round().toDouble() / mod);
return nwe ;
}


class MealCard extends StatefulWidget {
  String name;
  double carbs;
  int id;
  int Amunt;
  _Bodystate parent;

  MealCard(this.id, this.name, this.carbs, this.Amunt, this.parent);
  @override
  MealCardState createState() => MealCardState();
}

class MealCardState extends State<MealCard> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    //  print("click 21: check: $check, meal:$MealCard(name, carbs, Amunt, parent)");
    // print("click 22: chech: $check, meal: $MealCard(this.name, this.carbs, this.Amunt, this.parent)");

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
                  SizedBox(width: 40.0),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(
                        left: 60.0,
                      ),
                      child: new TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          hintText: 'الكمية: ${widget.Amunt}',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (e) {
                          widget.Amunt = int.parse(e);
                        },
                      ),
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
                print("click 28: check: $check ");
                check = e;
                if (check == true) {
                  print(
                      "click 24: check: $check , carb list lenght: ${_carbs.length}");
                  _carbs.add({widget.name: widget.carbs});
                  print("_carbs: $_carbs");
                  print(
                      "click 25: check: $check , carb list lenght: ${_carbs.length}");
                  //     var index = _carbs.indexWhere((item) => item.containsKey(widget.name));

                  // Variety vary = new Variety(_id, _mealId, _email, _eat, _carb, _amount)
                  //   Variety f  = Variety(widget.id,1,dbemail ,widget.name,widget.carbs, widget.Amunt);
                  //   var rt= await helper.insertVariety(f);
                  //  print("vary has insert: $rt");
                  //   varty.add({
                  //  'id':widget.id,
                  //   'name':widget.name,
                  //   'carb':widget.carbs,
                  //   'amunt':widget.Amunt});
                  print("befor add: $food");
                  Map<int, dynamic> varr = {
                    0: widget.id,
                    1: widget.name,
                    2: widget.carbs,
                    3: widget.Amunt
                  };
                  print("Afer varr: ${varr}");
                  // food.add({widget.id,
                  //   widget.name,
                  //   widget.carbs,
                  //   widget.Amunt});

                  food.add(varr);

                  print("Afer add: ${food}");
                  // print("hi index $index");
                  // print("befor add: ${varty}");
                  // varty.insert(index, varr);
                  // print("Afer add: ${varty[index]}");

                  _sum += widget.carbs;
                }
                if (check == false) {
                  print(
                      "click 26: chech: $check , carb list: $_carbs, widget: $widget.name, $widget.carbs,");
                  //varty.remove;

                  print(
                      "click 27: chech: $check , carb list: $_carbs.length, widget: $widget.name, $widget.carbs,");

                  var index = _carbs
                      .indexWhere((item) => item.containsKey(widget.name));
                  _carbs.removeAt(index);
                  food.removeAt(index);
                  // //  Variety f= Variety(widget.id,1,dbemail ,widget.name,widget.carbs, widget.Amunt);
                  //    var rt= await helper.deleteVariety(widget.id,1,dbemail);
                  //    print("vary has deleted: $rt");
                  print(
                      "click 30: chech: $check , food list: ${food.length}, $food");
                  //  ({widget.id,widget.name, widget.carbs,widget.Amunt});

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

//----------------- counterar of search:

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

// function make the http request
// Future<String> getData() async {
//   _sum = 0.0;
//   _carbs = [];
//   _inter = 0;

// print("click 3: sum= $_sum and inter= $_inter");
// var response = await http // .get(url)
//     .get(Uri.encodeFull(url), headers: {
//   'Accept': 'application/json' // 'key': 'ur key'
// }
//         //    print("sum= $_sum and inter= $_inter");
//         ); // .get(encode the response data as json) with headers which tell the code should be json

// after response back, setup the state for the application
//   setState(() {
//     //print("click 4: sum= $_sum and inter= $_inter and meals= $meals");
//     var responseBoddy = json.decode(response.body);
//     meals = responseBoddy;
//     print("res: $responseBoddy");
//     _visible = !_visible;
//     //print("click 5: sum= $_sum and inter= $_inter and meals= $meals");

//     //['name of area in the database or in the json data']; // user for example
//   });

//   return 'Success!'; // tell whether|not get the json
// }

// @override
// void dispose() {
//   _ischange();
//   super.dispose();
// }
