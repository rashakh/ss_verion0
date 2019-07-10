import 'package:flutter/material.dart'; // flutter main package

class Meals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        title: new Text(
          'الوجبات',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: Center(
        child: new Text("هذا التطبيق قيد الانشاء",
                style: new TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}