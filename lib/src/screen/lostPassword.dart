import 'package:flutter/material.dart'; // flutter main package

class LostPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        brightness: Brightness.light,
        title: new Text(
          'نسيت كلمة المرور',
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
    );
  }
}
