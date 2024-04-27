import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../authintication/screens/onboarding/onboarding_screen.dart';
import '../authintication/styles/app_colors.dart';
import '../authintication/utils/constants.dart';
import '../global/global.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    // setTimer();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = ColorTween(
      begin: AppColors.blue,
      end: AppColors.lightblue,
      // begin: Colors.red,
      // end: Colors.pink,
    ).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    animateColor();
    setTimer();
  }

  void animateColor() {
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setTimer() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
          (route) => false);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    setStatusBarColor(AppColors.blue);
    return Scaffold(
      // backgroundColor: const Color(0xFF353132),
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.50,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "My Guide ",
                    softWrap: true,
                    style: GoogleFonts.philosopher(
                      fontSize: 65.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 2),
                      Text('Travel with Passion',
                          style: GoogleFonts.lobster(
                            color: Colors.cyan,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
            ),
            const CircularProgressIndicator(
              color: Colors.cyan,
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
