// This widget is a structure of SS app's text input form

import 'package:flutter/material.dart'; // flutter main package
import 'package:flutter/foundation.dart';

class TextForm extends StatelessWidget {
  final String text; // input's text which is required input
  final String errorText; // input's error text which is required input
  final TextInputType inputType; // input's type which is required input
  final double paddingvertical; // input's vertical lenght
  final double paddinghorizontal; // input's horizontal lenght
  var _inputValue;

  TextForm({
    @required this.text,
    @required this.errorText,
    @required this.inputType,
    this.paddingvertical: 9.0,
    this.paddinghorizontal: 17.0,
  });

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
          decoration: InputDecoration(labelText: text),
          keyboardType: inputType,
          validator: (value) => value.isEmpty? errorText: null,
          onSaved: (value)=> _inputValue = value,
        );
  }
  get inputValue =>  _inputValue;
}
