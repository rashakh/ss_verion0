import 'dart:math';
import 'package:dtfbl/diabetes_icons_icons.dart';
import 'package:dtfbl/src/models/A1C.dart';
import 'package:dtfbl/src/models/BG.dart';
import 'package:dtfbl/src/models/PA.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'dart:ui';
import '../widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart' as intl; // flutter main package
//import 'package:flutter_sms/flutter_sms.dart';
import 'package:dtfbl/src/screen/sms.dart';
// import 'dart:async';
// import 'dart:convert'; // convert json into data
// import 'package:http/http.dart'
//     as http; // perform http request on API to get the into
import 'mainpage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//=import 'package:flutter_sms/flutter_sms.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
class GlucoseMeasure extends StatelessWidget {
  GlucoseMeasure(this.id, this.BMI, this.A1c, this.carb);
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
              'اضافة قراءة السكر',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body(id, BMI, A1c, carb)),
          // Padding(padding: const EdgeInsets.only(top: 100), child: Body()),
        ));
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
  // final String url =
  //     'mongodb+srv://ghida:ghida@cluster0-xskul.mongodb.net/test?retryWrites=true&w=majority'; //'http://127.0.0.1:8000/'; // apiURL ghida connection
  DatabaseHelper helper = DatabaseHelper();
  var _sum = 0;
  var _num = 0;
  var _rec = 0;
  //bool _result;
  int gm = 110;
  AlertType alerttype = AlertType.success;
  String decision = '';
  DateTime dateTime = DateTime.now();
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  String note = '';
  int slot = _slot();
  int pa = 0;
  Duration dur = new Duration(
    hours: 0,
    minutes: 30,
  );
  List<String> pas = const <String>[
    'المشي',
    'تمارين هوائية',
    'ركوب الدراجة',
    'السباحة',
  ];
  List<String> slots = const <String>[
    'قبل النوم',
    'بعد الاستيقاظ',
    'قبل الفطور',
    'بعد الفطور',
    'قبل الغداء',
    'بعد الغداء',
    'قبل العشاء',
    'بعد العشاء',
    'قبل الرياضة',
    'بعد الرياضة',
    'قبل وجبة خفيفة',
    'بعد وجبة خفيفة',
  ];

  static int _slot() {
    int slot;
    if (DateTime.now().hour >= 21 || DateTime.now().hour < 5) {
      slot = 0;
    } else if (DateTime.now().hour >= 5 && DateTime.now().hour < 7) {
      slot = 1;
    } else if (DateTime.now().hour >= 7 && DateTime.now().hour < 9) {
      slot = 2;
    } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 12) {
      slot = 3;
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 14) {
      slot = 4;
    } else if (DateTime.now().hour >= 14 && DateTime.now().hour < 20) {
      slot = 5;
    } else if (DateTime.now().hour >= 20 && DateTime.now().hour < 23) {
      slot = 6;
    } else if (DateTime.now().hour >= 23 || DateTime.now().hour < 00) {
      slot = 7;
    }
    return slot;
  }

  void decisionFun() {
    setState(() {

      if (widget.id[0]['gender'] == 0) {
        //here female
        if (widget.BMI[0]['bmi'] <= 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 230; // it should be in database
          // insulin
            double insulin = 0.0;
          if (slot == 1 || slot == 2 || slot == 4) {
            double mealCarb = neededcarb * 0.2;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              print("object 2");
                FlutterSms.sendSMS(recipients: "0562790017", message: "من بسيط وحلو مرحبا رشا");
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 6) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 10) {
            double mealCarb = neededcarb * 0.1;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 8) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 100) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تقوم بنشاط بدني الان, لانه سيؤدي الى انخفاض السكر في الدم\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (100 < gm && gm <= 240) {
              if (widget.carb == 0.0) {
                // last carb from database
                alerttype = AlertType.success;
                decision = 'تمارس النشاط البدني لمده 45 دقيقه';
              } else {
                alerttype = AlertType.warning;
                decision =
                    'تنتظر لمدة 1 ساعه بعد الاكل, قبل ان تمارس النشاط البدني';
              }
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =  insulinUnit(gm,  widget.BMI[0]['wit'],180);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 0) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 120) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تنام الان, لانه سيكون هناك انخفاض في السكر اثناء نومك\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (120 < gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'نوما هنيئا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 3 || slot == 5 || slot == 7 || slot == 11) {
            if (gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'لقد احسنت ادارة مستوى السكر لديك';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  ',ان تمارس الرياضه\n او ان تاخذ عدد $insulin جرعة من الانسولين';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 9) {
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision =
                  'تتناول وجبة خفيفة تحتوي على الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه بعد الرياضه سينخفض السكر في الدم تدريجيا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.success;
              decision =
                  'تتناول من 15 الى 30  من الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه قد ينخفض السكر في الدم تدريجيا';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],170);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          }
        } else if (widget.BMI[0]['bmi'] > 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 180; // it should be in database
          // insulin
          double insulin = 0.0;
          if (slot == 1 || slot == 2 || slot == 4) {
            double mealCarb = neededcarb * 0.2;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 6) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 10) {
            double mealCarb = neededcarb * 0.1;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 8) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; 
                  
                  // phonenumber from database
            } else if (54 <= gm && gm <= 100) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تقوم بنشاط بدني الان, لانه سيؤدي الى انخفاض السكر في الدم\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (100 < gm && gm <= 240) {
              if (widget.carb == 0.0) {
                // last carb from database
                alerttype = AlertType.success;
                decision = 'تمارس النشاط البدني لمده 30 دقيقه';
              } else {
                alerttype = AlertType.warning;
                decision =
                    'تنتظر لمدة 1 ساعه بعد الاكل, قبل ان تمارس النشاط البدني';
              }
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],180);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 0) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 120) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تنام الان, لانه سيكون هناك انخفاض في السكر اثناء نومك\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (120 < gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'نوما هنيئا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 3 || slot == 5 || slot == 7 || slot == 11) {
            if (gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'لقد احسنت ادارة مستوى السكر لديك';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  ',ان تمارس الرياضه\n او ان تاخذ عدد $insulin جرعة من الانسولين';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 9) {
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision =
                  'تتناول وجبة خفيفة تحتوي على الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه بعد الرياضه سينخفض السكر في الدم تدريجيا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.success;
              decision =
                  'تتناول من 15 الى 30  من الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه قد ينخفض السكر في الدم تدريجيا';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],170);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          }
        }
      } else if (widget.id[0]['gender'] == 1) {
        //here male
        if (widget.BMI[0]['bmi'] <= 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 330; // it should be in database
          // insulin
          double insulin = 0.0;
          if (slot == 1 || slot == 2 || slot == 4) {
            double mealCarb = neededcarb * 0.2;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              String g='';
              String f='';
               print("object male");

                FlutterSms.sendSMS(recipients: "0554540056", message: "hi");
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 6) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 10) {
            double mealCarb = neededcarb * 0.1;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 8) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 100) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تقوم بنشاط بدني الان, لانه سيؤدي الى انخفاض السكر في الدم\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (100 < gm && gm <= 240) {
              if (widget.carb == 0.0) {
                // last carb from database
                alerttype = AlertType.success;
                decision = 'تمارس النشاط البدني لمده 45 دقيقه';
              } else {
                alerttype = AlertType.warning;
                decision =
                    'تنتظر لمدة 1 ساعه بعد الاكل, قبل ان تمارس النشاط البدني';
              }
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =  insulinUnit(gm,  widget.BMI[0]['wit'],180);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 0) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 120) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تنام الان, لانه سيكون هناك انخفاض في السكر اثناء نومك\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (120 < gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'نوما هنيئا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 3 || slot == 5 || slot == 7 || slot == 11) {
            if (gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'لقد احسنت ادارة مستوى السكر لديك';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  ',ان تمارس الرياضه\n او ان تاخذ عدد $insulin جرعة من الانسولين';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 9) {
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision =
                  'تتناول وجبة خفيفة تحتوي على الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه بعد الرياضه سينخفض السكر في الدم تدريجيا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.success;
              decision =
                  'تتناول من 15 الى 30  من الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه قد ينخفض السكر في الدم تدريجيا';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],170);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          }
        } else if (widget.BMI[0]['bmi'] > 29) {
          // this should be the total carb, and needed to decrease each time
          double neededcarb = 220; // it should be in database
          // insulin
          double insulin = 0.0;
          if (slot == 1 || slot == 2 || slot == 4) {
            double mealCarb = neededcarb * 0.2;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],100);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 6) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130 ){
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = 0.0;
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 10) {
            double mealCarb = neededcarb * 0.1;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 130) {
              alerttype = AlertType.success;
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (130 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'تتناول $mealCarb من الكربوهيدرات لهذة الوجبة \n عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 8) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 100) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تقوم بنشاط بدني الان, لانه سيؤدي الى انخفاض السكر في الدم\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (100 < gm && gm <= 240) {
              if (widget.carb == 0.0) {
                // last carb from database
                alerttype = AlertType.success;
                decision = 'تمارس النشاط البدني لمده 45 دقيقه';
              } else {
                alerttype = AlertType.warning;
                decision =
                    'تنتظر لمدة 1 ساعه بعد الاكل, قبل ان تمارس النشاط البدني';
              }
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =  insulinUnit(gm,  widget.BMI[0]['wit'],180);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 0) {
            double mealCarb = neededcarb * 0.3;
            neededcarb -= mealCarb; // to show the concept
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm <= 120) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'لا تنام الان, لانه سيكون هناك انخفاض في السكر اثناء نومك\n' +
                      'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (120 < gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'ن��ما هنيئا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],120);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 3 || slot == 5 || slot == 7 || slot == 11) {
            if (gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision = 'لقد احسنت ادارة مستوى السكر لديك';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision =
                  ',ان تمارس الرياضه\n او ان تاخذ عدد $insulin جرعة من الانسولين';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection = insulinUnit(gm,  widget.BMI[0]['wit'],150);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          } else if (slot == 9) {
            if (gm < 54) {
              alerttype = AlertType.warning;
              decision =
                  'تم ارسال رساله نصية الى ...'; // phonenumber from database
            } else if (54 <= gm && gm < 70) {
              alerttype = AlertType.warning;
              // 15 X 15
              decision =
                  'تناول ملعقة من العسل (او 15 غرام من الكربوهيدرات البسيط) لزيادة مستوى السكر \nلاتنسى القياس مجددا بعد 15 دقيقة';
            } else if (70 <= gm && gm <= 180) {
              alerttype = AlertType.success;
              decision =
                  'تتناول وجبة خفيفة تحتوي على الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه بعد الرياضه سينخفض السكر في الدم تدريجيا';
            } else if (180 < gm && gm <= 240) {
              alerttype = AlertType.success;
              decision =
                  'تتناول من 15 الى 30  من الكربوهيدرات المعقدة مثل الفواكة او الشوفان، لانه قد ينخفض السكر في الدم تدريجيا';
            } else if (gm > 240) {
              alerttype = AlertType.warning;
              double insulinCorrection =insulinUnit(gm,  widget.BMI[0]['wit'],170);
              insulin += insulinCorrection; // insulin + correction dosage
              decision = 'ترتاح وتشرب الماء \n' +
                  'عدد جرعات الانسولين هي $insulin وحدة';
            }
          }
        }
      }
    });
  }
 
// void foot(){

// var last_date_foot= (await helper.getpA(email))[0]['date'];
// final date2 = DateTime.now();
// final difference = _ptDate.difference(date2).inDays;

// if(difference>29){
//   alerttype = AlertType.success;
//               decision = 'لقد احسنت ادارة مستوى السكر لديك';


// }
// else {



// }
// }
  // Future<bool> _postData() async {
  //   // map data to converted to json data
  //   final Map<String, dynamic> userData = {
  //     'email': widget.id[0]['email'],
  //     'Glucose Measure': gm,
  //     'DateTime': dateTime.toIso8601String(),
  //     'Slot': slot,
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

  String message = 'ادخل نسبة الجولوكوز في الدم';

  void _changed(e) {
    setState(() {
      gm = e;
      if (gm < 70 || gm > 180) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد، سكرك مرتفع';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا رائع انت تبلي جيدا';
      }
    });
  }

  Widget _glucose() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: TextSpan(
              text: 'نسبة السكر ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(mg/dL)',
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
          _glucoseBackground(),
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

  Widget _glucoseBackground() {
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
                  initialValue: gm,
                  minValue: 17,
                  maxValue: 400,
                  itemExtent: 60,
                  onChanged: (e) => _changed(e)),
            ),
          ),
        ),
        Icon(
          DiabetesIcons.swipe,
          color: slider,
          size: 35,
        ),
      ],
    );
  }

  Widget _mySlider() {
    return Column(
      children: <Widget>[
        new Slider(
          value: 50.3,
          onChanged: (double e) => _changed(e),
          activeColor: slider,
          inactiveColor: Colors.grey,
          divisions: 383,
          label: gm.round().toString(),
          max: 400.0,
          min: 17.0,
        ),
        new Text(
          message,
          style: Styles.productRowItemName,
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

  Widget _buildSlotPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'فترة القياس :',
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
                Icons.outlined_flag,
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
          slots[slot] + '\t',
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

  Widget _buildActivityPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'مدة الرياضة :',
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
                Icons.timer,
                color: CupertinoColors.activeBlue,
                size: 28,
              ),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _activityPicker();
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
          '${dur.inHours.remainder(60)}:${dur.inMinutes.remainder(60)}:${dur.inSeconds.remainder(60)}\t\t\t\t\t',
          style: Styles.productRowItemName,
        ),
        SizedBox(width: 20.0),
      ],
    );
  }

  Widget _activityPicker() {
    return CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hms,
        initialTimerDuration: dur,
        onTimerDurationChanged: (e) => setState(() {
              dur = e;
            }));
  }

  Widget _buildActivityType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 8.0),
        new Text(
          'نوع الرياضة :',
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
                Icons.directions_run,
                color: CupertinoColors.activeBlue,
                size: 28,
              ),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _cupType();
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
        SizedBox(width: 80.0),
        new Text(
          pas[pa] + '\t',
          style: Styles.productRowItemName,
        ),
        SizedBox(width: 20.0),
      ],
    );
  }

  Widget _cupType() {
    return CupertinoPicker(
      itemExtent: 40.0,
      backgroundColor: Colors.white,
      children: new List<Widget>.generate(pas.length, (pa) {
        return new Center(
          child: new Text(
            pas[pa],
            style: Styles.productRowItemName,
          ),
        );
      }),
      onSelectedItemChanged: (e) => setState(() {
        pa = e;
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
          _glucose(),
          SizedBox(height: 40.0),
          _buildDateAndTimePicker(context),
          _buildSlotPicker(context),
          if (slot == 8) _buildActivityType(context),
          if (slot == 9) _buildActivityPicker(context),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            child: _buildNoteField(),
          ),
          SizedBox(height: 30.0),
          new ButtonTheme.bar(
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                    ),
                    // Text('تمام',
                    //     style: TextStyle(
                    //       fontSize: 20.0,
                    //     )),
                    onPressed: () async {
                      int code=0;
                      if (slot == 8) {
                        PA padb = new PA(widget.id[0]['email'].toString(),
                            pas[pa], 0, dateTime.toIso8601String());
                        var palw = await helper.insertPA(padb);
                        BG bg = BG(widget.id[0]['email'].toString(),
                            slots[slot], gm, note, dateTime.toIso8601String());
                        var mealw = await helper.insertBG(bg);
                        setState(() {
                          _BGRe();
                          _BGTotal();
                          a11c();

                        });
                      } else if (slot == 9) {
                        int padu = dur.inMinutes;
                        var palw = await helper.UpdatetPA(padu);
                        BG bg = BG(widget.id[0]['email'].toString(),
                            slots[slot], gm, note, dateTime.toIso8601String());
                        var mealw = await helper.insertBG(bg);
                          code=1;
                        setState(() {
                          _BGRe();
                          _BGTotal();
                          a11c();

                        });

                      } else {
                        BG bg = BG(widget.id[0]['email'].toString(),
                            slots[slot], gm, note, dateTime.toIso8601String());
                        var mealw = await helper.insertBG(bg);
                        setState(() {
                          _BGRe();
                          _BGTotal();
                          a11c();
                        });
                      }
                      widget.A1c = (await helper
                          .getA1C(widget.id[0]['email']))[0]['a1C'];
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
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(widget.id,
                                        widget.BMI, widget.A1c, widget.carb,code)),
                              ),
                              width: 120,
                            )
                          ],
                        ).show();
                      });
                    }),
                SizedBox(width: 160.0),
                new FlatButton(
                  child: Icon(Icons.close, size: 30.0, color: Colors.red),
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

  //get total BG:
  void _BGTotal() async {
    var total = (await helper.BGTotal(widget.id[0]['email']))[0]['Total'];
    _sum = total;
    _BGRe();
    // setState(() => _sum = total);
  }

//get total record in BG table:
  void _BGRe() async {
    var num = (await helper.BGRecord(widget.id[0]['email'].toString()))[0]['r'];

    _num = num;
    _A1CRe();
    // setState(() => {});
  }

//get total record in A1C table:
  void _A1CRe() async {
    var num =
        (await helper.A1CRecord(widget.id[0]['email'].toString()))[0]['r'];

    _rec = num;
    a11c();
    // setState(() => {});
  }

// new A1C:
  Future a11c() {
    double wA1c;
    if (_num == 0 && _sum == 0) {
      double average = 0;
      wA1c = (46.7 + average) / 28.7;
    } else {
      double average = _sum / _num;
      wA1c = (46.7 + average) / 28.7;
    }

    double mod = pow(10.0, 1);
    double nwe = ((wA1c * mod).round().toDouble() / mod);
    setState(() {
      widget.A1c = nwe;
    });

    if (_rec == 0) {
      //if new user
      DateTime newdate = dateTime.add(new Duration(days: 90));
      A1C ss = A1C(nwe, widget.id[0]['email'].toString(),
          dateTime.toIso8601String(), newdate.toIso8601String());
      _A1CIn(ss);
    } else {
      //else update the number:
      _A1CUP(nwe);
    }
  }

  //insert A1C:
  void _A1CIn(A1C a) async {
    var ree = await helper.insertA1C(a);
  }

//Update A1C:
  void _A1CUP(double a) async {
    var ree = await helper.UpdatetA1C(a, widget.id[0]['email'].toString());
  }

// void foot(){
// String decision='تقوم بتأكد من سلامة قدمك';
// AlertType alerttype= AlertType.warning;
//           Alert(
//                           style: AlertStyle(isCloseButton: false,),
//                           context: context,
//                           type: alerttype,
//                           title: ' : نقترح عليك ان',
//                           desc: decision,
//                           buttons: [
//                             DialogButton(
//                               child: Text('حسنا', style: TextStyle(color: Colors.white, fontSize: 20),
//                               ),
//                               onPressed: () => Navigator.pushReplacement(
//                                 context, 
//                                 MaterialPageRoute(builder: (context) => MainPage(widget.id,widget.BMI, widget.A1c, widget.carb)),
//                               ),width: 120,
//                             )
//                           ],
//                         ).show();
                      

// }

    double insulinUnit(int BG,int wit, var correct){
  //insulin unit:
  print("wit: $wit");
double unit= wit *0.5;
print("unit: $unit");

double ISF= 1800/unit;
double durg= (BG-correct)/ISF;
print("durg: $durg");
double mod = pow(10.0, 1);
double nwe = ((durg * mod).round().toDouble() / mod);

return nwe ;
}
}

