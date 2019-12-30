// Home file which contains the Home page, and its properties
// this file allows enter and navigate into the App features

//import 'dart:async';

import 'package:dtfbl/diabetes_icons_icons.dart';
import 'package:dtfbl/src/utils/database_helper.dart';
import 'package:flutter/material.dart'; // flutter main package
import 'homepage.dart'; //import homepage file
import 'meals.dart'; //import meals file
import 'instructions.dart'; //import instructions file
import 'medications.dart'; //import medications file
import '../widgets/fancy_fab.dart';
  DatabaseHelper helper = DatabaseHelper();

class MainPage extends StatefulWidget {
  MainPage(@required this.id,@required this.Update,@required this.BMI, this.A1c,@required this.carb,this.code,this.PAs,this.units);
  var id ;
  List<Map<String,dynamic>> BMI;
  double A1c;
  double carb;
  int code;
List<Map<String,dynamic>> Update;
  int units;
  double PAs;
  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  // if(A1c){

  // }
   Widget pages(_selectedPage) {
    final List<Widget> _pages = [
      new HomePage(widget.id,widget.Update, widget.BMI,widget.A1c, widget.carb,widget.code,widget.PAs,widget.units),
      new Meals(widget.id,widget.Update,widget.BMI,widget.A1c, widget.carb,widget.code,widget.PAs,widget.units),
      //new PhysicalActivity(),
      new Instructions(widget.id,widget.Update,widget.BMI,widget.A1c, widget.carb,widget.code,widget.PAs,widget.units),
      new Medications(widget.id,widget.Update,widget.BMI,widget.A1c, widget.carb,widget.code,widget.PAs,widget.units),
    ];
    return _pages[_selectedPage];
  }
  // final List<Widget> _pages = [
  //   new HomePage(widget.id),
  //   new Meals(),
  //   //new PhysicalActivity(),
  //   new Instructions(),
  //   new Medications(),
  // ];
  @override
  Widget build(BuildContext context) {

  // print("check in mainpage ${widget.A1c.toString()}, ${widget.BMI}, ${widget.carb},");
    return new Scaffold(
      body: pages(_selectedPage),
      floatingActionButton: new FancyFab(widget.id,widget.Update,widget.BMI, widget.A1c, widget.carb,widget.PAs,widget.units),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: new Text(
              'التقدم',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(// MyFlutterApp.meal,
            DiabetesIcons.dinner__4_,size: 35.0,
              color: Colors.black,
            ),
            title: new Text(
              'الوجبات',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: new Icon(
          //     Icons.directions_run,
          //     color: Colors.black,
          //   ),
          //   title: new Text(
          //     'النشاط البدني',
          //     style: new TextStyle(fontSize: 20.0, color: Colors.black87),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: new Icon(
              DiabetesIcons.instruction__1_,size: 30.0,
              color: Colors.black,
            ),
            title: new Text(
              'الارشادات',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              DiabetesIcons.pharmacy__2_,size: 30.0,
              color: Colors.black,
            ),
            title: new Text(
              'الادوية',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
