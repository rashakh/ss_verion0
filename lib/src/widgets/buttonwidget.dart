// This widget is a structure of SS app's buttons

import 'package:flutter/material.dart'; // flutter main package
import 'package:flutter/foundation.dart';

class ButtonWidget extends StatelessWidget {
  final String text; // button's text which is required input
  final double paddingvertical; // button's vertical lenght
  final double paddinghorizontal; // button's horizontal lenght
  final GestureTapCallback onPressed; // button's function which is required input
  final Icon icon; // button's icon if it needed
  final Color fillcolor; // button's color with defult value
  final Color splashcolor; // button's on pressed color with defult value

  ButtonWidget(
      {@required this.text,
      @required this.onPressed,
      this.paddingvertical: 9.0,
      this.paddinghorizontal: 17.0,
      this.fillcolor: const Color(0xFFBDD22A),
      this.splashcolor: const Color(0xFFEBF2BA),
      this.icon});

  @override
  Widget build(BuildContext contesxt) {
    return RawMaterialButton(
      shape: StadiumBorder(),
      fillColor: fillcolor,
      splashColor: splashcolor,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingvertical, horizontal: paddinghorizontal),
        child: Text(text,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
