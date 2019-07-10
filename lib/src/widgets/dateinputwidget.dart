import 'package:flutter/material.dart';
import 'packages:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DateInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return DatePicker.showDatePicker(
  context,
  showTitleActions: true,
  locale: 'zh',
  minYear: 1970,
  maxYear: 2020,
  initialYear: 2018,
  initialMonth: 6,
  initialDate: 21,
  dateFormat: 'yyyy-mm-dd'
  onChanged: (year, month, date) { },
  onConfirm: (year, month, date) { },
);
  }
}