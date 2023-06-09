import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/common.dart';
import 'LoginPage.dart';
// import '../UI/common.dart';

class LRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirstScreen();

    throw UnimplementedError();
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BluePainter(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo(context),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: buttonWhite("Login",
                      () => {Navigator.of(context).pushReplacementNamed('/login')})),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  child: buttonWhite("Register",
                      () => Navigator.of(context).pushNamed('/register'))),
            )
          ],
        ),
      ),
    ));
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.62);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.48, height * 0.56, width * 0.52, height * 0.63);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(
        width * 0.6, height * 0.69, width * 1.3, height * 0.51);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height * 3);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Color.fromRGBO(13, 53, 69, 0.99);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
