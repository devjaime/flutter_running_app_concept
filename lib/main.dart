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

  static final double endContentAnim = 0.725;
  static final double endLogoAnim = 1.0;
  static final double iniAnim = 0.0;

  Animation<double> _contentAnimation;
  Animation<double> _logoAnimation;
  AnimationController _contentController;
  AnimationController _logoController;

  @override
  void initState() {
    super.initState();
    _contentController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
    _logoController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);

    final CurvedAnimation contentCurve = new CurvedAnimation(
        parent: _contentController, curve: Curves.fastOutSlowIn);
    final CurvedAnimation logoCurve = new CurvedAnimation(
        parent: _logoController, curve: Curves.fastOutSlowIn);

    _contentAnimation =
        new Tween<double>(begin: iniAnim, end: endContentAnim).animate(contentCurve)
          ..addListener(() {
            setState(() {
              // Required to notify the animation changes
            });
          });

    _logoAnimation = new Tween<double>(begin: iniAnim, end: endLogoAnim).animate(logoCurve)
      ..addListener(() {
        setState(() {
          // Required to notify the animation changes
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _contentController.forward();
        }
      });

    _logoController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size screenSize = data.size;
    final EdgeInsets edges = data.padding;
    return new Container(
      color: baseBlack,
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new Icon(Icons.account_circle),
          title: new Text('This week'),
          actions: <Widget>[new Icon(Icons.sort)],
        ),
        body: new Container(
          height: double.infinity,
          width: double.infinity,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0,
                screenSize.height *
                        (1.0 - ui.lerpDouble(iniAnim, endLogoAnim, _logoAnimation.value)) -
                    edges.top,
                0.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, -screenSize.height * ui.lerpDouble(iniAnim, endContentAnim, _contentAnimation.value), 0.0),
                  child: new BarsLogo(),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, screenSize.height * ui.lerpDouble(iniAnim, endContentAnim, _contentAnimation.value), 0.0),
                  child: new NameLogo(),
                ),
              ],
            ),
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
