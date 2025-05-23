import 'package:flutter/material.dart';
import 'package:pautang_tracker/screens/auth/login_screen.dart';
import 'package:pautang_tracker/utils/const.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage(
                'assets/images/portrait.png',
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75, right: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    icon,
                    height: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                ),
              ),
              TextWidget(
                text: 'Track your pautang, hassle-free.',
                fontSize: 38,
                fontFamily: 'Bold',
                color: Colors.white,
              ),
              TextWidget(
                maxLines: 5,
                text:
                    'Manage borrowers, record payments, and never forget who owes you again. Simple. Organized. Tuloy-tuloy ang singilan.',
                fontSize: 16,
                fontFamily: 'Regular',
                color: Colors.white,
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  width: 350,
                  label: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) {
                        return false;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
