import 'package:flutter/material.dart';

class SizeAnimation extends StatefulWidget {
  Widget child;
  SizeAnimation(this.child);
  @override
  State<StatefulWidget> createState() => new SizeAnimationState();
}

class SizeAnimationState extends State<SizeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _sizeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 700), vsync: this);
    _sizeAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.addListener(() => this.setState(() {}));
    _controller.forward();
  } // init state function

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 140.0 * _sizeAnimation.value,
      height: 140.0 * _sizeAnimation.value,
      child: widget.child,
    );
  }
}
