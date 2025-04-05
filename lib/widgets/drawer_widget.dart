import 'package:flutter/material.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

import '../screens/home_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 250,
      color: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 80,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              title: TextWidget(
                text: 'Dashboard',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_none_sharp,
                color: Colors.black,
              ),
              onTap: () {},
              title: TextWidget(
                text: 'Notifications',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                color: Colors.black,
              ),
              onTap: () {},
              title: TextWidget(
                text: 'All Debt',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ),
              onTap: () {},
              title: TextWidget(
                text: 'Add Debt',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.groups_2_outlined,
                color: Colors.black,
              ),
              onTap: () {},
              title: TextWidget(
                text: 'Borrowers',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationVersion: 'v1.0.0',
                  applicationName: 'Utang Tracker App',
                  applicationLegalese: 'by: Algo Vision',
                  applicationIcon: Image.asset(
                    'assets/images/icon.png',
                    height: 25,
                  ),
                );
              },
              title: TextWidget(
                text: 'About',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
          ],
        ),
      )),
    );
  }
}
