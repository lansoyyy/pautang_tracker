import 'package:flutter/material.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:pautang_tracker/widgets/toast_widget.dart';

class AddBorrowerScreen extends StatefulWidget {
  const AddBorrowerScreen({super.key});

  @override
  State<AddBorrowerScreen> createState() => _AddBorrowerScreenState();
}

class _AddBorrowerScreenState extends State<AddBorrowerScreen> {
  final name = TextEditingController();
  final address = TextEditingController();
  final number = TextEditingController();
  String? selectedGender = 'Male';
  final notes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Icon(
                  Icons.account_circle,
                  size: 150,
                  color: primary,
                ),
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                borderColor: Colors.black,
                label: "Borrower's Name",
                controller: name,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gender",
                  style: TextStyle(fontFamily: 'Medium'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 175,
                    child: RadioListTile<String>(
                      title: const Text("Male"),
                      value: "Male",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 175,
                    child: RadioListTile<String>(
                      title: const Text("Female"),
                      value: "Female",
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                borderColor: Colors.black,
                label: "Borrower's Contact Number",
                controller: number,
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                borderColor: Colors.black,
                label: "Borrower's Address",
                inputType: TextInputType.streetAddress,
                controller: address,
              ),
              const SizedBox(height: 20),

              // Gender Selection

              // Notes Field
              TextFieldWidget(
                maxLine: 3,
                borderColor: Colors.black,
                label: "Notes",
                controller: notes,
                inputType: TextInputType.multiline,
              ),

              const SizedBox(height: 50),
              Center(
                child: ButtonWidget(
                  label: 'Save',
                  onPressed: () {
                    Navigator.of(context).pop();
                    showToast('Borrower saved successfully!');
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
