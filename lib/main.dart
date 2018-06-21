import 'dart:math' as math;

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
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size screenSize = data.size;
    final EdgeInsets systemPadding = data.padding;
    return new Container(
      color: baseBlack,
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            new FullLogoAnimation(),
            new Column(
              children: <Widget>[
                new CustomAppBar(
                  paddingTop: systemPadding.top,
                ),
                new Expanded(
                  child: new Container(
                    padding: const EdgeInsets.only(
                        left: 32.0,
                        top: 10.0,
                        right: 32.0,
                        bottom: 15.0,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(10.0),
                        topRight: new Radius.circular(10.0),
                      ),
                      color: new Color(0xFFF5F5F5),
                    ),
                    child: new Column(
                      children: <Widget>[
                        new Flexible(
                          flex: 2,
                          child: new Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding: const EdgeInsets.all(35.0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: new Container(
                              padding: const EdgeInsets.all(40.0),
                              decoration: new BoxDecoration(
                                border: new Border.all(
                                  color: new Color(0xFF9B9B9B),
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: new Container(
                                decoration: new BoxDecoration(
                                  color: new Color(0xFFF5F5F5),
                                  shape: BoxShape.circle,
                                ),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      'Steps this week',
                                      style: new TextStyle(
                                        color: new Color(0xFF052C29),
                                        fontFamily: 'AvenirLTStd',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                                      child: new Text(
                                        '80 456',
                                        style: new TextStyle(
                                          color: new Color(0xFF4A4A4A),
                                          fontFamily: 'AvenirLTStd',
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    new Text(
                                      'steps',
                                      style: new TextStyle(
                                        color: new Color(0xFF052C29),
                                        fontFamily: 'AvenirLTStd',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 30.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _createValuesColumn(
                                  'Total Distance', '78,45', 'kilometers'),
                              _createValuesColumn('Total Runs', '3', 'runs'),
                              _createValuesColumn(
                                  'Total Time', '712,30', 'minuts'),
                            ],
                          ),
                        ),
                        new Flexible(
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.black,
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createValuesColumn(String title, String value, String subtitle) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          title,
          style: new TextStyle(
            color: new Color(0xFF052C29),
            fontFamily: 'AvenirLTStd',
            fontSize: 12.0,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: new Text(
            value,
            style: new TextStyle(
              color: new Color(0xFF4A4A4A),
              fontFamily: 'AvenirLTStd',
              fontSize: 24.0,
            ),
          ),
        ),
        new Text(
          subtitle,
          style: new TextStyle(
            color: new Color(0xFF052C29),
            fontFamily: 'AvenirLTStd',
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  static const double rightBarsHeight = 3.0;
  static const double rightBarsSpace = 8.0;
  final double paddingTop;

  CustomAppBar({this.paddingTop});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(
        bottom: paddingTop,
        top: paddingTop + 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundColor: new Color(0xFFD8D8D8),
            child: new Icon(Icons.group),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: new Text(
                'This week',
                style: new TextStyle(
                  color: new Color(0xFFABABAB),
                  fontFamily: 'AvenirLTStd',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _createSortBar(30.0),
              _createSortBarDivision(),
              _createSortBar(24.0),
              _createSortBarDivision(),
              _createSortBar(18.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createSortBar(double width) {
    return new Container(
      height: 3.0,
      width: width,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        color: new Color(0xFF7D7D7D),
        shape: BoxShape.rectangle,
      ),
    );
  }

  Widget _createSortBarDivision() {
    return new Container(
      height: 5.0,
    );
  }
}

class FullLogoAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new BarsLogo(),
          new NameLogo(),
        ],
      ),
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
