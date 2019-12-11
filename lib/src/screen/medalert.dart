import 'package:dtfbl/src/models/dug.dart';
import 'package:flutter/material.dart';
import 'package:dtfbl/src/utils/database_helper.dart';

class MedAlert extends StatelessWidget {
  MedAlert(this.id, this.BMI, this.A1c, this.carb);
  var id;
  var BMI;
  var A1c;
  var carb;
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
              'الادوية',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body(id, BMI, A1c, carb)),
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
  String _med;
  DatabaseHelper helper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Container(
          alignment: Alignment.centerRight,
          child: Column(children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            new Text(
              'الادوية و الجرعات',
              style: new TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            new Row(
              children: <Widget>[
                SizedBox(
                  width: 30.0,
                ),
                new Text(
                  'الاسم',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 80.0,
                ),
                new Text(
                  'الموعد',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 80.0,
                ),
                new Text(
                  'عدد الوحدات',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: helper.getDug(widget.id[0]['email']),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  // //        if (data.connectionState == ConnectionState.none && data.hasData == null) {
                  // //   //print('project snapshot data is: ${projectSnap.data}');
                  // //   return Container();
                  // // }
                  if (snapshot.connectionState == ConnectionState.done) {
                    print("hi list view 1");
                    final Pt = snapshot.data;
                    var l = 65.0 *
                        Pt.length; //lenght of the view for carunt record (to be flixable)
                    return new Row(children: <Widget>[
                      Expanded(
                          child: SizedBox(
                              height: l as double,
                              child: ListView.builder(
                                //   //   itemCount: data.data.length,
                                itemCount: Pt.length,
                                itemBuilder: (context, index) {
                                  // print("{Pt[index]['Name']}");
                                  return Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0, bottom: 10.0, top: 10.0),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '${Pt[index]['Name']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80.0,
                                          ),
                                          Text(
                                            'الصباح',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 90.0,
                                          ),
                                          Text(
                                            '${Pt[index]['dug']}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          new IconButton(
                                            padding: EdgeInsets.only(
                                                bottom: 30.0, right: 43.0),
                                            icon: Icon(Icons.delete,
                                                color: Colors.red,
                                                textDirection:
                                                    TextDirection.ltr,
                                                size: 20),
                                            onPressed: () async {
                                              // var result =
                                              //     await helper.deletExam(
                                              //         Pt[index]['id'],
                                              //         Pt[index]['email']
                                              //             .toString());
                                              // print(result);
                                              // Navigator.pop(context);
                                              //Navigator.of(context).popAndPushNamed(routeName)
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MedAlert(
                                                              widget.id,
                                                              widget.BMI,
                                                              widget.A1c
                                                                  .toString(),
                                                              widget.carb)));
                                              //
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },

//            itemCount: Pt.length,
                              )
//--
                              ))
                    ]);
                  } else {
                    return Card();
                    //C]enter(child: CircularProgressIndicator());
                  }
                }

                //future: getProjectDetails(),
                ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 90.0, right: 90.0, top: 5.0, bottom: 5.0),
              child: new GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (
                        BuildContext context,
                      ) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    child: new DropdownButton<String>(
                                      isExpanded: true,
                                      iconEnabledColor: Color(0xFFBDD22A),
                                      hint: Text(
                                        'اختر الدواء',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      value: _med,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'نوفورابيد',
                                          child: Text(
                                            'نوفورابيد',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'كلوفاج',
                                          child: Text(
                                            'كلوفاج',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'لانتوس',
                                          child: Text(
                                            'لانتوس',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'مومولوج',
                                          child: Text(
                                            'مومولوج',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                      onChanged: (e) {
                                        setState(() {
                                          _med = e;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: new GestureDetector(
                                      onTap: () async {
                                        //database
                                      print("wight from medalert: ${widget.BMI[0]['wit']}");
                                        double durg= widget.BMI[0]['wit'] *0.5;
int dd=durg.toInt();
                                      Dug medc= new Dug(widget.id[0]['email'],_med,dd); 
                                      var dur =await helper.insertDUB(medc);
                                      print("med isert from medalert: $dur");
                                        Navigator.of(context).pop();
                                      },
                                      child: new Container(
                                          alignment: Alignment.center,
                                          height: 40.0,
                                          decoration: new BoxDecoration(
                                              color: Color(0xFFBDD22A),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      7.0)),
                                          child: new Text('حفظ',
                                              style: new TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
          ]),
        ));
  }
}

// Card(
//   child: Padding(
//     padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
//     child: new Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: 10.0,
//         ),
//         Text(
//           'لانتوس',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 80.0,
//         ),
//         Text(
//           'الصباح',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 90.0,
//         ),
//         Text(
//           '24',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(
//   height: 5.0,
// ),
// Card(
//   child: Padding(
//     padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
//     child: new Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: 10.0,
//         ),
//         Text(
//           'هومولوج',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 45.0,
//         ),
//         Text(
//           'قبل او بعد الوجبة',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 45.0,
//         ),
//         Text(
//           '10,13,10',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Card(
//   child: Padding(
//     padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
//     child: new Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: 10.0,
//         ),
//         Text(
//           'اسبرين',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 80.0,
//         ),
//         Text(
//           'قبل الغداء',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//         SizedBox(
//           width: 90.0,
//         ),
//         Text(
//           '1',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
