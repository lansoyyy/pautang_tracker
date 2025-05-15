import 'package:flutter/material.dart';
import 'package:pautang_tracker/screens/tabs/adddebt_tab.dart';
import 'package:pautang_tracker/screens/tabs/borrower_tab.dart';
import 'package:pautang_tracker/screens/tabs/notif_tab.dart';
import 'package:pautang_tracker/screens/tabs/overdueloan_tab.dart';
import 'package:pautang_tracker/screens/tabs/utang_tab.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

import '../screens/home_screen.dart';

class DrawerWidget extends StatelessWidget {
  String id;
  DrawerWidget({super.key, required this.id});

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
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            id: id,
                          )),
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
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => NotifTab(
                            id: id,
                          )),
                  (route) => false,
                );
              },
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
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => UtangTab(
                            id: id,
                          )),
                  (route) => false,
                );
              },
              title: TextWidget(
                text: 'All Loan',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.av_timer_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => OverdueLoanTab(
                            id: id,
                          )),
                  (route) => false,
                );
              },
              title: TextWidget(
                text: 'Overdue Loan',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AdddebtTab(
                            id: id,
                          )),
                  (route) => false,
                );
              },
              title: TextWidget(
                text: 'Add Loan',
                fontSize: 18,
                fontFamily: 'Medium',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.groups_2_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => BorrowerTab(
                            myId: id,
                            id: id,
                          )),
                  (route) => false,
                );
              },
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
                text: 'Licenses',
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
