import 'package:flutter/material.dart';
import 'package:clock/clock.dart';
import 'dart:math';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  State createState() => new IntroState();
}

class IntroState extends State<IntroScreen> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new Column(
          children: <Widget>[new Text("text1")],
        )),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new Column(
        children: <Widget>[new Text("text2")],
      ),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new Column(
        children: <Widget>[
          new Text("text3"),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 115, 233),
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 26, 115, 233),
        elevation: 0.0,
        centerTitle: true,
        title: new Text("Intro"),
      ),
      bottomNavigationBar: new BottomAppBar(
        elevation: 0.0,
        color: Color.fromARGB(255, 26, 115, 233),
        child: Padding(
          padding: const EdgeInsets.only(left: 75.0, right: 75.0, bottom: 10.0),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.white,
            child: new Text("Start"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClockScreen()),
              );
            },
          ),
        ),
      ),
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
