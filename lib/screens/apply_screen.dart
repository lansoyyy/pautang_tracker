import 'package:flutter/material.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final String supportNumber = '09639530422'; // Replace with your actual number
  final String emailRecipient =
      'olanalans12345@gmail.com'; // Replace with your actual email

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot make phone call')),
      );
    }
  }

  Future<void> _sendEmail(String name, String contact, String address) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'olanalans12345@gmail.com',
      queryParameters: {
        'subject': 'New Account Application',
        'body': 'Name: $name\nContact: $contact\nAddress: $address',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // You can show a dialog or snackbar to inform the user
      print('Could not launch email app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Account Application',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextWidget(
              text: 'No Account yet?',
              fontSize: 24,
              fontFamily: 'Regular',
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            TextWidget(
              maxLines: 20,
              text:
                  'To create an account, please fill out the form below with your complete details. '
                  'Once you click "Apply Now", your information will be sent to our support team. '
                  'We will review your application and contact you as soon as possible.\n\n'
                  'If you have any questions, feel free to tap the "Contact Us" button to speak directly with our team.',
              fontSize: 14,
              fontFamily: 'Regular',
              color: Colors.black87,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            TextFieldWidget(
              borderColor: Colors.black,
              label: 'Name',
              controller: nameController,
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              inputType: TextInputType.number,
              borderColor: Colors.black,
              label: 'Contact Number',
              controller: contactController,
            ),
            const SizedBox(height: 15),
            TextFieldWidget(
              borderColor: Colors.black,
              label: 'Address',
              controller: addressController,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                final name = nameController.text;
                final contact = contactController.text;
                final address = addressController.text;

                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'olanalans12345@gmail.com',
                  queryParameters: {
                    'subject': 'New Account Application (Pautang Tracker)',
                    'body': 'Name: $name\nContact: $contact\nAddress: $address',
                  },
                );

                launchUrlString(emailUri.toString());

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                minimumSize: Size.fromHeight(60), // Height of the button
              ),
              icon: Icon(
                Icons.email,
                color: Colors.white,
                size: 28,
              ),
              label: TextWidget(
                text: 'Apply Now',
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _makePhoneCall(supportNumber),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size.fromHeight(60), // Height of the button
              ),
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 28,
              ),
              label: TextWidget(
                text: 'Contact Us',
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
