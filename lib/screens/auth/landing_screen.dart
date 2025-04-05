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
              opacity: 0.75,
              image: AssetImage(
                'assets/images/portrait.png',
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75, right: 30),
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
                text: 'Utang Tracker App',
                fontSize: 38,
                fontFamily: 'Bold',
                color: Colors.white,
              ),
              TextWidget(
                text: 'Utang? Noted. Bayad? Monitored.',
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
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
