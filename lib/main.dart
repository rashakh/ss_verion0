// main file which contains and manages all other files

import 'package:flutter/material.dart'; // flutter main package
// package support RTL language
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/screen/mainpage.dart';
import 'src/screen/homepage.dart'; //import home page file
import 'src/screen/loginpage.dart'; //import login page file
import 'src/screen/registration.dart'; //import registration file
import 'src/screen/lostPassword.dart'; //import registration file
import 'src/screen/pt.dart';
import 'src/screen/meals.dart'; //import meals file
import 'src/screen/physical_activity.dart'; //import physical_activity file
import 'src/screen/instructions.dart'; //import instructions file
import 'src/screen/medications.dart'; //import medications file
import 'src/widgets/maintheme.dart';
import 'src/screen/medalert.dart';
import 'src/screen/glucose_measure.dart';
import 'src/widgets/fancy_fab.dart';
import 'src/screen/weight_input.dart';
import 'src/screen/pressure_input.dart';

void main() => runApp(new SS()); // the App main function call SS class

// the main class of the App
class SS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true, //debug sign
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale("en", "US"),
      //   Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
      // ],
      // routes files by name
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => new LoginPage(),
        // '/MainPage': (BuildContext context) => new MainPage(),
        // '/HomePage': (BuildContext context) => new HomePage(),
        '/Registration': (BuildContext context) => new Registration(),
        '/LostPassword': (BuildContext context) => new LostPassword(),
        '/PeriodicTest': (BuildContext context) => new PeriodicTest(),
        '/MedAlert' : (BuildContext context) => new MedAlert(),
        // '/meals': (BuildContext context) => new Meals(),
        // '/physical_activity': (BuildContext context) => new PhysicalActivity(),
        // '/instructions': (BuildContext context) => new Instructions(),
        // '/medications': (BuildContext context) => new Medications(),
        //'/FancyFab': (BuildContext context) => new FancyFab(),
        //'/GlucoseMeasure': (BuildContext context) => new GlucoseMeasure(),
        '/MainTheme': (BuildContext context) => new MainTheme(),
        //'/Weightinput': (BuildContext context) => new Weightinput(),
        //'/Pressureinput': (BuildContext context) => new Pressureinput(),
      },
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
