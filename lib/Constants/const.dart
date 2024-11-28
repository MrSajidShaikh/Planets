import 'package:flutter/material.dart';

const headerStyle = TextStyle(
  fontFamily: 'Proportional',
  letterSpacing: 1.2,
  fontWeight: FontWeight.w900,
);
const subHeaderStyle = TextStyle(
  fontFamily: 'Proportional',
  fontWeight: FontWeight.w500,
);
const pBodyeStyle = TextStyle(
    fontFamily: 'Montserrat',
    letterSpacing: 1.2,
    color: Colors.white);

extension NavigatorExten on BuildContext {
  pushNav({required Widget screen}) {
    return Navigator.push(
        this, MaterialPageRoute(builder: (context) => screen));
  }

  popNav() {
    return Navigator.of(this).pop();
  }
}

