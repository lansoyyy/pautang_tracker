import 'package:flutter/material.dart';
import 'package:pautang_tracker/screens/home_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/utils/const.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75, right: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  icon,
                  height: 25,
                  color: primary,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/illustration.png',
                height: 400,
                width: 400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 325,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    30,
                  ),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: TextWidget(
                      text: 'Login to manage your loans and payments.',
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Bold',
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextFieldWidget(
                        label: 'Username',
                        controller: username,
                        showEye: true,
                        isObscure: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ButtonWidget(
                      width: 350,
                      color: Colors.white,
                      textColor: primary,
                      label: 'Login',
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) {
                            return false;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
