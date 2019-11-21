// Home file which contains the Home page, and its properties
// this file allows enter and navigate into the App features

import 'package:flutter/material.dart'; // flutter main package
import 'homepage.dart'; //import homepage file
import 'meals.dart'; //import meals file
import 'physical_activity.dart'; //import physical_activity file
import 'instructions.dart'; //import instructions file
import 'medications.dart'; //import medications file
import '../widgets/fancy_fab.dart';

class MainPage extends StatefulWidget {
  MainPage(@required this.id);
  var id;
  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
   Widget pages(_selectedPage) {
    final List<Widget> _pages = [
      new HomePage(widget.id),
      new Meals(widget.id),
      //new PhysicalActivity(),
      new Instructions(widget.id),
      new Medications(widget.id),
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
    return new Scaffold(
      body: pages(_selectedPage),
      floatingActionButton: new FancyFab(widget.id),
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
              'الرئيسية',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.local_dining,
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
              Icons.library_books,
              color: Colors.black,
            ),
            title: new Text(
              'الارشادات',
              style: new TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.add_circle_outline,
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
