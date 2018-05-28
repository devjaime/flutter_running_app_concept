import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

final Color baseBlack = Color(0xFF383838);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Splash(),
      title: 'Running App',
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  double _percentageVisible = 0.0;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation = new Tween<double>(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {
          _percentageVisible = ui.lerpDouble(0.0, 1.0, _animation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward(from: 0.0);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: new Container(
        color: baseBlack,
        height: double.infinity,
        width: double.infinity,
        child: new Transform(
          transform: new Matrix4.translationValues(
              0.0, size.height * (1.0 - _percentageVisible), 0.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new BarsLogo(),
              new NameLogo(),
            ],
          ),
        ),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  Bar({this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: this.color,
      height: 126.0,
      width: 14.0,
    );
  }
}

class BarsLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Bar(
          color: Colors.white,
        ),
        new Bar(
          color: Colors.transparent,
        ),
        new Bar(
          color: Colors.white,
        ),
        new Bar(
          color: Colors.transparent,
        ),
        new Bar(
          color: Colors.white,
        ),
      ],
    );
  }
}

class NameLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Transform(
      alignment: Alignment.center,
      transform: new Matrix4.rotationZ(math.pi / 2)
        ..translate(60.0, -10.0, 0.0),
      child: new Text(
        'adidas',
        style: new TextStyle(
          color: Colors.white,
          fontFamily: 'TeXGyreAdventor',
          fontSize: 54.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
