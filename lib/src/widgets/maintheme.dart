import 'package:flutter/material.dart'; // flutter main package

class MainTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('T', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey])),
      ),
    );
    ;
  }
}

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
