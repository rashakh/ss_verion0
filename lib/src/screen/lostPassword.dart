import 'package:flutter/material.dart'; // flutter main package

class LostPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        title: new Text(
          'هل نسيت كلمة السر؟',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: new Directionality(
        textDirection: TextDirection.rtl,
        child: new Stack(
          fit: StackFit.expand, // make Stack itself fit screen
          children: <Widget>[
            new Image(
              image: new AssetImage('assets/img.jpg'),
              fit: BoxFit.none, // make image fit screen
            ),
            new Container(
              padding: const EdgeInsets.all(40.0),
              alignment: Alignment.topCenter,
              child: new SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    new Text(
                        "لا تقلق! من فضلك ادخل ايميلك ليتم ارسال رابط عادة تعين كلمة المرور اليك",
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 40.0),
                    new TextFormField(
                      //controller: _user,
                      decoration: InputDecoration(
                        hintText: 'ادخل ايميلك',
                        hintStyle: new TextStyle(
                            fontSize: 20.0, color: Colors.black87),
                        fillColor: Colors.white54.withOpacity(0.5),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => !value.contains('@') ||
                              !value.contains('.com') ||
                              value.isEmpty
                          ? 'الايميل غير صحيح'
                          : null,
                      //onSaved: (value) => _email = value,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 3.0, top: 50.0),
                      child: new GestureDetector(
                        //onTap: _validateAndSubmit,
                        child: new Container(
                            alignment: Alignment.center,
                            height: 45.0,
                            decoration: new BoxDecoration(
                                color: Color(0xFF2A79D2),
                                borderRadius: new BorderRadius.circular(7.0)),
                            child: new Text("ارسال",
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
