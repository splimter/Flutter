import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnim;
  AnimationController catControl;

  Animation<double> boxAnim;
  AnimationController boxControl;

  initState() {
    super.initState();

    catControl = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    catAnim = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catControl, curve: Curves.easeIn));


    boxControl = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnim = Tween(begin: pi * 0.6, end: pi * 0.65)
        .animate(CurvedAnimation(parent: boxControl, curve: Curves.easeInOut));

    boxAnim.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        boxControl.reverse();
      else if (status == AnimationStatus.dismissed)
        boxControl.forward();
    });
    boxControl.forward();
  }

  onTap() {
    boxControl.stop();
    if (catControl.status == AnimationStatus.completed) {
      boxControl.forward();
      catControl.reverse();
    } else if (catControl.status == AnimationStatus.dismissed){
      boxControl.stop();
      catControl.forward();
    }

  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnim,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnim.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnim,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnim.value,
          );
        },
      ),
      left: 3.0,
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnim,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnim.value,
          );
        },
      ),
      right: 3.0,
    );
  }
}
