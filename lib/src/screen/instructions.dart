import 'package:dtfbl/src/screen/profile.dart';
import 'package:dtfbl/src/screen/pt.dart';
import 'package:flutter/material.dart'; // flutter main package
//import 'package:dtfbl/src/widgets/styles.dart';
import 'dart:math';
import 'exportPDF.dart';
import 'medalert.dart'; // perform http request on API to get the into

class Instructions extends StatelessWidget {
  Instructions(this.id, this.BMI, this.A1c, this.carb);
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
                  MaterialPageRoute(
                      builder: (context) =>
                          MedAlert(id, BMI, A1c.toString(), carb)),
                );
              },
            ),
            new ListTile(
              title: Text('الفحوصات الدورية'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PeriodicTest(id, BMI, A1c.toString(), carb)),
                );
              },
            ),
            new ListTile(
              title: Text('التقارير'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ExportPDF(id, BMI, A1c.toString(), carb)),
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
      body: new SingleChildScrollView(
          child: new Body(id, BMI, A1c.toString(), carb)),
    );
  }
}

class Body extends StatefulWidget {
  Body(this.id, this.BMI, this.carb, this.A1c);
  var id;
  var BMI;
  var A1c;
  var carb;
  @override
  State createState() => new _Bodystate();
}

class _Bodystate extends State<Body> {

  bool _visible = true;
  double totalCarb = 0.0; // total carb for each day, for 7 days
  double totalPA = 0.0; // total PA for each day, for 7 days
  double totalA1c = 0.0; // total A1c for each day, for 7 days
  String title, info;
  List<Widget> insts = [];

  List<Widget> _behave() {
    double meanofTotalCarb = totalCarb / 7;
    
    double meanofTotalA1c = totalA1c / 7;
    if (widget.id[0]['gender'] == 0) {
      //here female
      if (widget.BMI[0]['bmi'] <= 29) {
        double meanofTotalPA = totalCarb / 3;
        double cCPercent = (meanofTotalCarb / 230) * 100;
        double paCPercent = (meanofTotalPA / 230) * 100;
        if (cCPercent < 50) {
          //here
          title = 'تم ملاحظة انك تأكل الكربوهيدرات اقل بكثير مما تحتاج';
          info =
              'ليست كربوهيدرات سيئة بحد ذاتها، بل الاكثار منها سيكون سيئا عليك.\n\nلكن التقليل من كربوهيدرات له سلبياته ايضا، منها : \n- الرغبة الشديدة في تناول السكر.\n- تذبذب في مستويات الأنسولين الطبيعية في الجسم.\n- قلة التركيز.\n- الصداع.\n\nيفضل لك ان تأكل بقدر ما يقترحه النظام لك.';
          insts.add(_instrTxt(title, info));

          title = 'الكربوهيدرات';
          info =
              'الكربوهيدرات البسيطة تتحلل بسرعة الى جلوكوز لترفع مستوى السكر في الدم.\n\nمثال: الاطعمة المصنعة و المكررة، الارز الابيض\n\n\nالكربوهيدرات المعقدة تتحل بشكل ابطئ مما يساعد على الشعور بالشبع ويبطئ ارتفاع مستوى السكر في الدم.\n\nمثال: الارز الاسمر، الدقيق الاسمر، الشوفان';
          insts.add(_instrTxt(title, info));
        } else if (cCPercent >= 50 && cCPercent <= 100) {
          //here
          title = 'الكربوهيدرات';
          info =
              'الكربوهيدرات البسيطة تتحلل بسرعة الى جلوكوز لترفع مستوى السكر في الدم.\n\nمثال: الاطعمة المصنعة و المكررة، الارز الابيض\n\n\nالكربوهيدرات المعقدة تتحل بشكل ابطئ مما يساعد على الشعور بالشبع ويبطئ ارتفاع مستوى السكر في الدم.\n\nمثال: الارز الاسمر، الدقيق الاسمر، الشوفان';
          insts.add(_instrTxt(title, info));
        } else if (cCPercent > 100) {
          //here
          title = 'تم ملاحظة انك تأكل الكربوهيدرات بكثرة';
          info =
              'كربوهيدرات مفيدة، وتناولها بشكل معتدل يساعد الجسم على القيام باعماله بشكل سليم.\n\nلكن الاكثار من كربوهيدرات له اضرار على صحتك، ايضا، منها : \n- زيادة فرص الاصابة بامراض القلب.\n- ارتفاع معدل السكر في الدم.\n- زيادة وزن الجسم، الذي بدوره سبب لامراض مثل سرطان البنكرياس.\n- عدم القدرة على اداء النشاط الجسدي.\n\nيفضل لك ان تأكل بقدر ما يقترحه النظام لك.';
          insts.add(_instrTxt(title, info));

          title = 'الكربوهيدرات';
          info =
              'الكربوهيدرات البسيطة تتحلل بسرعة الى جلوكوز لترفع مستوى السكر في الدم.\n\nمثال: الاطعمة المصنعة و المكررة، الارز الابيض\n\n\nالكربوهيدرات المعقدة تتحل بشكل ابطئ مما يساعد على الشعور بالشبع ويبطئ ارتفاع مستوى السكر في الدم.\n\nمثال: الارز الاسمر، الدقيق الاسمر، الشوفان';
          insts.add(_instrTxt(title, info));
        }
        if (paCPercent < 50) {
          title = 'تم ملاحظة انك لا تمارس النشاط البدني بكثرة';
          info =
              'الرياضة مفيدة بشكل عام ولكن مهمة بشكل خاص للمصابين بالسكري.\n\nمن منفاعها : \n- تساعد على التحكم في مستوى السكر في الدم و ضغط الدم و الكولسترول.\n- تساهم في الوقاية من مقاومة الانسولين.\n- تحسن من اداء القلب و الجهاز التنفسي.\n- تساهل في الوقاية والتقليل من مصاعفات السكري.\n\nيفضل لك ان تمارس النشاط البدني لمدة 45 دقيقة ثلاث مرات في الاسبوع.';
          insts.add(_instrTxt(title, info));
        }
        // else if (paCPercent >= 50 && paCPercent <= 100) {
        // } else if (paCPercent > 100) {

        // }
      } else if (widget.BMI[0]['bmi'] > 29) {
        //double meanofTotalPA = totalCarb / 7;
        double cCPercent = (meanofTotalCarb / 180) * 100;
      }
      if (meanofTotalA1c < 5) {
        title = 'تم ملاحظة نوابة انخفاض السكر في الدم بشكل متكرر';
        info =
            'سكر الجلوكوز هو مصرد ررئيسي للطاقة، يساعد في الجسم والعقل على اداء المهام بشكل فعال.\n\nمضاعفات انخفاض السكر في الدم خطيرة منها : \n- فشل وظيفي في الدماغ والاصابة بالخرف.\n- يؤدي الى خلل وظيفي عصبي.\n- زيادة خطر الاصابة بامراض القلب و الاوعية الدموية.\n- انخفاض في وظائف العين قد يصل الى فقدان البصر، وموت خلايا شبكية العين.\n\nالانخفاضات قد تكون بسبب نوعية الادوية، لذلك ننصحك ان تذهب الى الطبيب.';
        insts.add(_instrTxt(title, info));

        title = 'تحليل السكر التراكمي A1C';
        info =
            'هو تحليل يظهر مدى تحكم الفرد بمستوى السكر في الدم على مدار ثلاث اشهر.\n\nتتراوح قيمته بين ٤ و ١٤\n\nمن الجيد ان تكون قيمته بين ٥ و ٧، وكلما زاد عن ذلك كل ما كان الشخص معرض للمخاطر.\n\nاذا كان تحليل السكر التراكمي مرتفع عن ٨، يكون الشخص عرضه لامراض خطيرة مثل امراض الكلى و العين';
        insts.add(_instrTxt(title, info));
      } else if (meanofTotalA1c <= 5 && meanofTotalA1c >= 7) {
        title = 'تحليل السكر التراكمي A1C';
        info =
            'هو تحليل يظهر مدى تحكم الفرد بمستوى السكر في الدم على مدار ثلاث اشهر.\n\nتتراوح قيمته بين ٤ و ١٤\n\nمن الجيد ان تكون قيمته بين ٥ و ٧، وكلما زاد عن ذلك كل ما كان الشخص معرض للمخاطر.\n\nاذا كان تحليل السكر التراكمي مرتفع عن ٨، يكون الشخص عرضه لامراض خطيرة مثل امراض الكلى و العين';
        insts.add(_instrTxt(title, info));
      } else if (meanofTotalA1c > 7) {
        title = 'تم ملاحظة نوابة ارتفاع السكر في الدم بشكل متكرر';
        info =
            'سكر الجلوكوز هو مصرد ررئيسي للطاقة، يساعد في الجسم والعقل على اداء المهام بشكل فعال.\n\nمضاعفات ارتفاع السكر في الدم خطيرة منها : \n- الاصابة بسرطان القولون و البنكرياس.\n- امراض عصبية قد تصل الى الشلل.\n- اعتلال شبكية العين.\n- اعتلال الكلى.\n\nمن اسباب الارتفاعات الاكل غير الصحي، التوتر و الضغط النفسي، لذلك ننصحك ان تتجنب الاكل غير الصحي وان تزور طبيب نفسي ليساعدك في تخطي الازمات النفسية.';
        insts.add(_instrTxt(title, info));

        title = 'تحليل السكر التراكمي A1C';
        info =
            'هو تحليل يظهر مدى تحكم الفرد بمستوى السكر في الدم على مدار ثلاث اشهر.\n\nتتراوح قيمته بين ٤ و ١٤\n\nمن الجيد ان تكون قيمته بين ٥ و ٧، وكلما زاد عن ذلك كل ما كان الشخص معرض للمخاطر.\n\nاذا كان تحليل السكر التراكمي مرتفع عن ٨، يكون الشخص عرضه لامراض خطيرة مثل امراض الكلى و العين';
        insts.add(_instrTxt(title, info));
      }
      //here
      title = 'مواضع حقن الأنسولين';
      info =
          'افضل المواضع لحقن الأنسولين: الذراعين، البطن،الفخذين، الردفين.\n\nيحقن الأنسولين في النسيج تحت الجلد\n\nيجب مراعاة تغيير مواضع الحقن من فترة الى اخري، لان الحقن المستمر في نفس الموضع يسبب تليف الموضع، بالتالي لا يمر الأنسلين خلال الانسجة.\n\nقبل الحقن يجب ان تتأكد من تعقيم الموضع، وخلوه من اي اورام، وان شعرت بذلك لا تحقن في نفس الموضع حتى تزول الاورام';
      insts.add(_instrTxt(title, info));

      title = 'كن على اهبة الاستعداد';
      info =
          'من المهم ان تستعد و تعد احتياطاتك في جميع الظروف و الاسباب.\n\nدائما ارتدي سوارا وبطاقة تبين انك مصاب  سكري\n\n احمل دائما معك قطعه حلوى في حال شعرت باعراض انخفاض السكر.\n\nفي حاله السفر لا تنسى ان تستخدم حقيبة اليد لحمل الانسولين و الابر، و جهاز قياس السكر، وايضا خذ معك كمية اكبر من الانسولين';
      insts.add(_instrTxt(title, info));
    } else if (widget.id[0]['gender'] == 1) {
      //here male

    }
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
    _behave();
    print(insts.length);
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: <Widget>[
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                //itemCount: 1, //insts == null ? 0 : 1,
                itemCount: insts == null ? 0 : insts.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    child: Column(
                      children: <Widget>[
                        insts[index],
                      ],
                    ),
                    //_instrTxt('Issue','information about the issue'),
                  );
                }),
            // AnimatedOpacity(
            //   opacity: _visible ? 1.0 : 0.0,
            //   duration: Duration(milliseconds: 600),
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 250.0),
            //     child: new SpinKitThreeBounce(
            //       color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 3)
            //           .withOpacity(0.2),
            //       size: 100.0,
            //     ),
            //   ),
            // ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }
}
