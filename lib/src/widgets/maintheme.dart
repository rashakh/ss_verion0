import 'package:flutter/material.dart'; // flutter main package
import 'package:flutter/cupertino.dart';

class MainTheme extends StatelessWidget {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Title',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/MainPage');
          },
        ),
      ),
          // Container(
          //   child: FlatButton(
          //       onPressed: () {
          //         DatePicker.showDatePicker(
          //           context,
          //           minDateTime: DateTime(2018),
          //           maxDateTime: DateTime.now(),
          //           // onChange: (date) {
          //           //   print('change $date');
          //           // },
          //           // onConfirm: (date) {
          //           //   print('confirm $date');
          //           // },
          //           initialDateTime: DateTime.now(),
          //         );
          //       },
          //       child:Text('press')),
          // )
      //     new CupertinoButton.filled(
      //   //color: Colors.lightBlue,
      //   child: Text("Press Me"),
      //   //icon: new Icon(Icons.date_range),
      //   onPressed: () async {
      //     await showModalBottomSheet(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return _cupdate();
      //       },
      //     );
      //     print("Hello Printed");
      //   },
      // ),
      // Container(
      //   decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //           colors: [Colors.white, Colors.grey])),
      // ),
    );
  }

  // Widget _cupdate() {
  //   return CupertinoDatePicker(
  //     initialDateTime: date,
  //     minimumDate: DateTime(1900),
  //     maximumDate: DateTime.now(),
  //     mode: CupertinoDatePickerMode.date,
  //     onDateTimeChanged: (e) {
  //       // _setState(() {
  //          date = e;
  //          print(date); 
  //       // }
  //       // );
  //     },
  //   );
  // }
}

// showPicker(BuildContext context) {
//     Picker picker = new Picker(
//       adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData)),
//       changeToFirst: true,
//       textAlign: TextAlign.left,
//       columnPadding: const EdgeInsets.all(8.0),
//       onConfirm: (Picker picker, List value) {
//         print(value.toString());
//         print(picker.getSelectedValues());
//       }
//     );
//     picker.show(_scaffoldKey.currentState);
//   }

//   showPickerModal(BuildContext context) {
//     new Picker(
//       adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData)),
//       changeToFirst: true,
//       hideHeader: false,
//       onConfirm: (Picker picker, List value) {
//         print(value.toString());
//         print(picker.adapter.text);
//       }
//     ).showModal(this.context); //_scaffoldKey.currentState);
//   }

//   showPickerIcons(BuildContext context) {
//     new Picker(
//       adapter: PickerDataAdapter(data: [
//         new PickerItem(text: Icon(Icons.add), value: Icons.add, children: [
//           new PickerItem(text: Icon(Icons.more)),
//           new PickerItem(text: Icon(Icons.aspect_ratio)),
//           new PickerItem(text: Icon(Icons.android)),
//           new PickerItem(text: Icon(Icons.menu)),
//         ]),
//         new PickerItem(text: Icon(Icons.title), value: Icons.title, children: [
//           new PickerItem(text: Icon(Icons.more_vert)),
//           new PickerItem(text: Icon(Icons.ac_unit)),
//           new PickerItem(text: Icon(Icons.access_alarm)),
//           new PickerItem(text: Icon(Icons.account_balance)),
//         ]),
//         new PickerItem(text: Icon(Icons.face), value: Icons.face, children: [
//           new PickerItem(text: Icon(Icons.add_circle_outline)),
//           new PickerItem(text: Icon(Icons.add_a_photo)),
//           new PickerItem(text: Icon(Icons.access_time)),
//           new PickerItem(text: Icon(Icons.adjust)),
//         ]),
//         new PickerItem(text: Icon(Icons.linear_scale), value: Icons.linear_scale, children: [
//           new PickerItem(text: Icon(Icons.assistant_photo)),
//           new PickerItem(text: Icon(Icons.account_balance)),
//           new PickerItem(text: Icon(Icons.airline_seat_legroom_extra)),
//           new PickerItem(text: Icon(Icons.airport_shuttle)),
//           new PickerItem(text: Icon(Icons.settings_bluetooth)),
//         ]),
//         new PickerItem(text: Icon(Icons.close), value: Icons.close),
//       ]),
//       title: new Text("Select Icon"),
//       onConfirm: (Picker picker, List value) {
//         print(value.toString());
//         print(picker.getSelectedValues());
//       }
//   ).show(_scaffoldKey.currentState);
// }

// showPickerDialog(BuildContext context) {
//   new Picker(
//       adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData)),
//       hideHeader: true,
//       title: new Text("Select Data"),
//       onConfirm: (Picker picker, List value) {
//         print(value.toString());
//         print(picker.getSelectedValues());
//       }
//   ).showDialog(context);
// }

// showPickerArray(BuildContext context) {
//   new Picker(
//       adapter: PickerDataAdapter<String>(pickerdata: new JsonDecoder().convert(PickerData2), isArray: true),
//       hideHeader: true,
//       title: new Text("Please Select"),
//       onConfirm: (Picker picker, List value) {
//         print(value.toString());
//         print(picker.getSelectedValues());
//       }
//   ).showDialog(context);
// }


class MyTheme extends Theme {}
// class AnimatedBackground extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track("color1").add(Duration(seconds: 3),
//           ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
//       Track("color2").add(Duration(seconds: 3),
//           ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
//     ]);

//     return ControlledAnimation(
//       playback: Playback.MIRROR,
//       tween: tween,
//       duration: tween.duration,
//       builder: (context, animation) {
//         return Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [animation["color1"], animation["color2"]])),
//         );
//       },
//     );
//   }
// }
