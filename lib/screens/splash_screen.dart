import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pautang_tracker/screens/auth/landing_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 275,
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: LinearProgressIndicator(
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
