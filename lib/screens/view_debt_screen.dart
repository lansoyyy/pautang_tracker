import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';

class ViewDebtScreen extends StatefulWidget {
  String? id;

  ViewDebtScreen({super.key, this.id});

  @override
  State<ViewDebtScreen> createState() => _ViewDebtScreenState();
}

class _ViewDebtScreenState extends State<ViewDebtScreen> {
  final List<String> items = [
    'Installment Utang',
  ];
  String? selectedItem = 'Installment Utang';

  final interestRate = TextEditingController(text: '5');

  final String _selectedFrequency = 'Monthly';

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  final payment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: TextWidget(
                  text: 'Payment',
                  fontSize: 18,
                ),
                content: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        label: 'Amount',
                        controller: payment,
                        inputType: TextInputType.number,
                        borderColor: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextWidget(
                        text:
                            "Note: Balance's for this payment will be deducted to next payment.",
                        fontSize: 11,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      text: 'Close',
                      fontSize: 16,
                      fontFamily: 'Medium',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      text: 'Save Payment',
                      fontSize: 16,
                      fontFamily: 'Medium',
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.paypal_outlined,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.phone,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 125,
                      ),
                      TextWidget(
                        text: 'John Doe',
                        fontSize: 22,
                        fontFamily: 'Bold',
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextWidget(
                          text: 'Male',
                          fontSize: 18,
                          fontFamily: 'Medium',
                        ),
                      ),
                      TextWidget(
                        text: 'Gender',
                        fontSize: 12,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextWidget(
                          text: 'Zone 03, Poblacion, Impasugong Bukidnon',
                          fontSize: 18,
                          fontFamily: 'Medium',
                        ),
                      ),
                      TextWidget(
                        text: 'Address',
                        fontSize: 12,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Payment this Month',
                    fontSize: 16,
                    fontFamily: 'Medium',
                  ),
                  TextWidget(
                    text: 'P10,000',
                    fontSize: 32,
                    fontFamily: 'Bold',
                    color: primary,
                    decoration: TextDecoration.underline,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'P25,000',
                        fontSize: 28,
                        fontFamily: 'Bold',
                        color: Colors.green,
                      ),
                      TextWidget(
                        text: 'Total Debt',
                        fontSize: 12,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'P5,000',
                        fontSize: 28,
                        fontFamily: 'Bold',
                        color: Colors.green,
                      ),
                      TextWidget(
                        text: 'Total Paid',
                        fontSize: 12,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'P20,000',
                        fontSize: 28,
                        fontFamily: 'Bold',
                        color: Colors.green,
                      ),
                      TextWidget(
                        text: 'Remaining Balance',
                        fontSize: 12,
                        fontFamily: 'Regular',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Type of Utang:',
                        fontSize: 14,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          value: selectedItem,
                          items: items.map((item) {
                            return DropdownMenuItem<String>(
                              enabled: false,
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(fontFamily: 'Medium'),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // Handle the change
                            print('Selected: $value');
                            setState(() {
                              selectedItem = value;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 150,
                    child: TextFieldWidget(
                      enabled: false,
                      isInterest: true,
                      label: selectedItem == 'Installment Utang'
                          ? ' $_selectedFrequency interest (%)'
                          : 'Interest (%)',
                      controller: interestRate,
                      borderColor: Colors.black,
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: selectedItem == 'Installment Utang',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Payment terms',
                      fontSize: 18,
                    ),
                    Wrap(
                      children: _frequencies.map((freq) {
                        return SizedBox(
                          width: 175,
                          child: ListTile(
                            title: Text(
                              freq,
                              style: TextStyle(fontFamily: 'Medium'),
                            ),
                            leading: Radio<String>(
                              value: freq,
                              groupValue: _selectedFrequency,
                              onChanged: (String? value) {},
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: TextFieldWidget(
                  enabled: false,
                  borderColor: Colors.black,
                  label: 'Due date',
                  controller: duedate,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              TextWidget(
                text: 'Payment History',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextWidget(
                            text: 'John Doe',
                            fontSize: 18,
                            fontFamily: 'Bold',
                          ),
                          TextWidget(
                            text: 'Date: January 25, 2025',
                            fontSize: 12,
                            fontFamily: 'Regular',
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextWidget(
                            text: 'P5,499',
                            fontSize: 24,
                            fontFamily: 'Bold',
                            color: Colors.green,
                          ),
                          TextWidget(
                            text: 'Payment',
                            fontSize: 12,
                            fontFamily: 'Regular',
                          ),
                        ],
                      ),
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

  final duedate = TextEditingController(
    text: DateFormat('MMMM dd, yyyy').format(
      DateTime.now().add(Duration(days: 30)),
    ),
  );
}
