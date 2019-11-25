import 'package:dtfbl/src/models/PT.dart';
import 'package:dtfbl/src/models/exams.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class PeriodicTest extends StatelessWidget {
  PeriodicTest(this.id);
  var id;
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
              'الفحوصات الدورية',
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
   DatabaseHelper helper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  String _pt;
  DateTime _ptDate = new DateTime.now();
  var _result;

  Widget _cupdate() {
    return CupertinoDatePicker(
      initialDateTime: _ptDate,
      minimumDate: DateTime(2018),
      maximumDate: DateTime(2025),
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (e) {
        setState(() {
          // if (e.isBefore(DateTime.now())) {
          //   e = DateTime.now();
          // }
          _ptDate = e;
        });
      },
    );
  }

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
              'الفحوصات القادمة',
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
                  'يتبقى على الموعد',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
           FutureBuilder(
             future: helper.getPT(widget.id[0]['email']),
             builder: (context, snapshot){
               print(snapshot.data);
      // //        if (data.connectionState == ConnectionState.none && data.hasData == null) {
      // //   //print('project snapshot data is: ${projectSnap.data}');
      // //   return Container();
      // // }
        if (snapshot.connectionState == ConnectionState.done) {
          print("hi list view 1");
        final Pt=snapshot.data;
        var l= 65.0*Pt.length; //lenght of the view for carunt record (to be flixable)
       return 
       new Row(
       children: <Widget>[
         Expanded(
           child:SizedBox(
             height: l as double,
      child: ListView.builder(
        
      //   //   itemCount: data.data.length,
                    itemCount: Pt.length,
         itemBuilder: (context, index) {
         // print("{Pt[index]['Name']}");

         // var project = snapshot.data[index];
           return Card(
               child: Padding(
               padding: EdgeInsets.only(right: 20.0, bottom: 6.0, top: 10.0),
               child: new Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       '${Pt[index]['Name']}',
                       style: TextStyle(
                         fontSize: 16.0,
                         color: Colors.black,
                       ),
                                           textAlign:TextAlign.center ,

                    ),
                    SizedBox(
                     width: 40.0,// height:20 ,
                   ),
                    Text(
                      '${Pt[index]['date']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    textAlign:TextAlign.center ,

                    ),
                    SizedBox(
                      width: 80.0,//height: 20,
                    ),
                    Text(
                      '${Pt[index]['dur']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                                          textAlign:TextAlign.center ,

                     ),
                     new Padding( // but didn't make any  cheng!
                      padding: EdgeInsets.only(left: 0),
                   child: 
                     IconButton(
                       icon:Icon( Icons.delete, textDirection:TextDirection.ltr,size:20),

                       onPressed:() async {
                       var result= await helper.deletExam(Pt[index]['id'],Pt[index]['email'].toString());
                       print(result);
                     // Navigator.pop(context);
                       //Navigator.of(context).popAndPushNamed(routeName)
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => PeriodicTest(widget.id)));
                      //
                       },)

                 )
                  ],
                ),
               ),
             );
           },
           

//            itemCount: Pt.length,
                  )
//--
         )  )  ] );
        }
        else{
          return Card();
          //C]enter(child: CircularProgressIndicator());
        }
             },

             //future: getProjectDetails(),
             ),
            SizedBox(
              height: 1.0,
            ),
            // Card(
            //   child: Padding(
            //     padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
            //     child: new Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           'here',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             color: Colors.black,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 35.0,
            //         ),
            //         Text(
            //           'here',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             color: Colors.black,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 80.0,
            //         ),
            //         Text(
            //           'here',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20.0,
            ),
            
            new Padding(
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
                                      bottom: 10.0,
                                    ),
                                    child: new DropdownButton<String>(
                                      iconEnabledColor: Color(0xFFBDD22A),
                                      hint: Text('اختر الفحص'),
                                      value: _pt,
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: 'التراكمي',
                                          child: Text(
                                            'التراكمي',
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'الكلى',
                                          child: Text(
                                            'الكلى',
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'العين',
                                          child: Text(
                                            'العين',
                                          ),
                                        ),
                                      ],
                                      onChanged: (e) {
                                        setState(() {
                                          _pt = e;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          intl.DateFormat.yMMMd()
                                              .format(_ptDate),
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        new IconButton(
                                          color: Colors.blue,
                                          icon: new Icon(
                                            Icons.calendar_today,
                                          ),
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _cupdate();
                                              },
                                            );
                                          },
                                        ),
                                        new Text(
                                          ': الموعد',
                                          style: new TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: new GestureDetector(
                                      onTap: () async{
                                          final date2= DateTime.now();
                                         final difference = _ptDate.difference(date2).inDays;
                                           int id;
                                            if(_pt=="العين"){
                                                id=3;
                                            }
                                            else if(_pt=="التراكمي"){
                                                id=1;
                                            }
                                            else{
                                              id=2;
                                            }
                                        Exam pts= new Exam.withId(id,_pt,widget.id[0]['email'],_ptDate.toIso8601String().substring(0,10),difference);
                                        print("exam: $_pt,${widget.id[0]['email']},${_ptDate.toIso8601String().substring(0,10)},$difference");
                                        var he= await helper.insertExam(pts);
                                       Navigator.pop(context,MaterialPageRoute(builder: (context) => PeriodicTest(widget.id)));
                                      // Navigator.pop(context,MaterialPageRoute(builder: (context) => PeriodicTest(widget.id)));

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
                                                  fontSize: 15.0,
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
          
          
            SizedBox(
              height: 30.0,
            ),
            new Text(
              'اخر النتائج',
              style: new TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
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
                  'التاريخ',
                  style: new TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  width: 90.0,
                ),
                new Text(
                  'النتيجة',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),





            
            SizedBox(
              height: 10.0,
            ),
           FutureBuilder(
             future: helper.getPT(widget.id[0]['email']),
             builder: (context, snapshot){
               print(snapshot.data);
      // //        if (data.connectionState == ConnectionState.none && data.hasData == null) {
      // //   //print('project snapshot data is: ${projectSnap.data}');
      // //   return Container();
      // // }
        if (snapshot.connectionState == ConnectionState.done) {
          print("hi list view 1");
        final Pt=snapshot.data;
        var l= 60.0*Pt.length;
       return 
       new Row(
       children: <Widget>[
         Expanded(
           child:SizedBox(
             height: l as double,
      child: ListView.builder(
        
      //   //   itemCount: data.data.length,
                    itemCount: Pt.length,
         itemBuilder: (context, index) {
         // print("{Pt[index]['Name']}");

         // var project = snapshot.data[index];


            Card(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'فحص العين',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      '1/1/2019',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      'سليمة',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
            SizedBox(
              height: 5.0,
            );
            Card(
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'فحص الكلى',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Text(
                      '1/12/2018',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
                    ),
                    Text(
                      'سليمة',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );

           },
           

//            itemCount: Pt.length,
                  )
//--
         )  )  ] );
        }
        else{
          return Card();
          //C]enter(child: CircularProgressIndicator());
        }
             },

             //future: getProjectDetails(),
             ),


          ]),
        ));
  }
}
