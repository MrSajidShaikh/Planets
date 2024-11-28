import 'package:flutter/material.dart';
import 'package:planets/Constants/screen_size.dart';
import '../Constants/const.dart';
import '../Constants/earth_animation.dart';
import '../Constants/moving_earth.dart';
import 'homepage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: context.getWidth,
        height: context.getHeight,
        child: Stack(
          children: [
            MovingEarth(
              animatePosition: EarthAnimation(
                topAfter: -150,
                topBefore: -150,
                leftAfter: -650,
                leftBefore: -800,
                bottomAfter: -150,
                bottomBefore: -150,
              ),
              delayInMs: 1000,
              durationInMs: 2500,
              child: GestureDetector(
                  onDoubleTap: () {
                    context.pushNav(screen: const HomePage());
                  },
                  child: Image.asset("assets/earth_home.jpg")),
            ),
            Positioned(
                left: 25,
                bottom: 20,
                right: 25,
                child: RichText(
                  text: TextSpan(
                    style: headerStyle.copyWith(fontSize: 35),
                    children: [
                      const TextSpan(text: 'discover your '),
                      TextSpan(
                          text: 'home',
                          style: headerStyle.copyWith(color: Colors.blue)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
