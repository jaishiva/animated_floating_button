import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final title;

  const MyHomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: AnimatedFloatingButton(),
    );
  }
}

class AnimatedFloatingButton extends StatefulWidget {
  const AnimatedFloatingButton({
    Key key,
  }) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Transform.translate(
        offset: Offset.fromDirection(pi + pi / 2, 100 * _animation.value),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[900],
          ),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Transform.translate(
        offset: Offset.fromDirection(pi + pi / 4, 100 * _animation.value),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow[700],
          ),
          child: IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Transform.translate(
        offset: Offset.fromDirection(pi, 100 * _animation.value),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange[700],
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[400],
        ),
        child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if (_animationController.status != AnimationStatus.dismissed) {
              _animationController.reverse();
              HapticFeedback.selectionClick();
            } else {
              _animationController.forward();
              HapticFeedback.selectionClick();
            }
          },
        ),
      ),
    ]);
  }
}
