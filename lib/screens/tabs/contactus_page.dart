import 'package:flutter/material.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

import '../../../widgets/drawer_widget.dart';

class ContactusPage extends StatelessWidget {
  String id;

  ContactusPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        id: id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Contact Us',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/googlelogo.png',
                  height: 25,
                  color: grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextWidget(
                    text: 'algovision123@gmail.com', fontSize: 16, color: grey),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fblogo.png',
                  height: 25,
                  color: grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextWidget(
                    text: 'facebook.com/algovision', fontSize: 16, color: grey),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_phone_outlined,
                  color: grey,
                  size: 28,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextWidget(text: '+639639530422', fontSize: 16, color: grey),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.pin_drop_outlined,
                  color: grey,
                  size: 28,
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextWidget(
                      text: 'Province of Misamis Oriental, Philippines',
                      fontSize: 16,
                      color: grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
