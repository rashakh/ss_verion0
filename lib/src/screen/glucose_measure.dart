import 'package:flutter/material.dart'; // flutter main package
import 'dart:math';
import 'dart:ui';
//import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import '../widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart'; // NEW

// import '../widgets/flutter_fluid_slider.dart'; // NEW

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  // SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
  //     AppStateModel model) {
  //   return SliverChildBuilderDelegate(
  //     (context, index) {
  //       switch (index) {
  //         case 0:
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: _buildNameField(),
  //           );
  //         case 1:
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: _buildEmailField(),
  //           );
  //         case 2:
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: _buildLocationField(),
  //           );
  //         case 3:
  //           return Padding(
  //             padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
  //             child: _buildDateAndTimePicker(context),
  //           );
  //         default:
  //         // Do nothing. For now.
  //       }
  //       return null;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return null;
    // return Consumer<AppStateModel>(
    //   builder: (context, model, child) {
    //     return CustomScrollView(
    //       slivers: <Widget>[
    //         const CupertinoSliverNavigationBar(
    //           largeTitle: Text('Shopping Cart'),
    //         ),
    //         SliverSafeArea(
    //           top: false,
    //           minimum: const EdgeInsets.only(top: 4),
    //           sliver: SliverList(
    //             delegate: _buildSliverChildBuilderDelegate(model),
    //           ),
    //         )
    //       ],
    //     );
    //   },
    // );
  }
}

class GlucoseMeasure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        title: new Text(
          'اضافة قراءة السكر',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Body()
      ),
    );
  }
}

class Body extends StatelessWidget {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  
  Widget _buildNameField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.pen,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'ملاحظات',
      onChanged: (newName) {
        // setState(() {
        //   name = newName;
        // });
      },
    );
  }

  Widget _buildEmailField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.mail_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Email',
    );
  }

  Widget _buildLocationField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Location',
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'وقت القياس',
                  //style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              //style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              // setState(() {
              //   dateTime = newDateTime;
              // });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: new MySlider(),
          ),
           _buildNameField(),
           _buildDateAndTimePicker(context),
          // new ListTile(
          //   title: new Text("كم السكر في الدم"),
          //   subtitle: new Text("Decription : You may go now!!"),
          // ),
          new ButtonTheme.bar(
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('الغاء'),
                  onPressed: () {/* ... */},
                ),
                new FlatButton(
                  child: const Text('تمام'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MySlider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MySliderState();
}

class MySliderState extends State<MySlider>{
  String message ='ادخل نسبة الجولوكوز في الدم';
  double val = 180.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column( children: <Widget>[
      new Slider(
        value: val,
        onChanged: (double e)=> changed(e),
        activeColor: Colors.redAccent,
        inactiveColor: Colors.grey,
        divisions: 383,
        label: val.round().toString(),
        max: 400.0,
        min: 17.0,
      ),
      new Text(message),
    ],

    );
  }
void changed(e){
      setState(() {
          val = e;
          if(val < 90 || val > 200){
            message = 'هذا ليس جيد، يجب عليك الانتباه';
          }
          else{message ='هذا رائع انت تبلي جيدا';}
        });}

}  

// class Homep extends StatefulWidget {
//   @override
//   HomepState createState() {
//     return new HomepState();
//   }
// }

// class HomepState extends State<Homep> {
//   double _value1 = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             FluidSlider(
//               value: _value1,
//               onChanged: (double newValue) {
//                 setState(() {
//                   _value1 = newValue;
//                 });
//               },
//               min: 17.0,
//               max: 400.0,
//               sliderColor: Color(0xFF2A79D2),
//             ),
//             SizedBox(
//               height: 100.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
