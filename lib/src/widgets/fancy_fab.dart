import 'package:flutter/material.dart';
import '../screen/glucose_measure.dart';
import '../screen/weight_input.dart';
import '../screen/pressure_input.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  IconData icon;
  List<Map<String, dynamic>> id;

  FancyFab(
    this.id, {
    this.onPressed,
    this.tooltip,
    this.icon,
  });

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  IconData icon = Icons.add;
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      icon = Icons.clear;
      _animationController.forward();
    } else {
      icon = Icons.add;
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget _addGlucose() {
    return Container(
      child: FloatingActionButton(
        mini:true,
        heroTag: "btn1",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GlucoseMeasure(widget.id)),
          );
          //Navigator.of(context).pushNamed('/GlucoseMeasure');
        },
        tooltip: 'اضافة قراءة السكر في الدم',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _addWeight() {
    return Container(
      child: FloatingActionButton(
        mini:true,
        heroTag: "btn2",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Weightinput(widget.id)),
          );
          //Navigator.of(context).pushNamed('/Weightinput');
        },
        tooltip: 'اضافة الوزن',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _addPressure() {
    return Container(
      child: FloatingActionButton(
        mini:true,
        heroTag: "btn3",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Pressureinput(widget.id)),
          );
          //Navigator.of(context).pushNamed('/Pressureinput');
        },
        tooltip: 'اضافة ضغط الدم',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        mini:true,
        heroTag: "btn4",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'اضافة',
        child: Icon(
          icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.59,
            0.0,
          ),
          child: _addGlucose(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 1.70,
            0.0,
          ),
          child: _addWeight(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 0.87,
            0.0,
          ),
          child: _addPressure(),
        ),
        toggle(),
      ],
    );
  }
}
