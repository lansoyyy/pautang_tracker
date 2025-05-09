import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:pautang_tracker/widgets/toast_widget.dart';

class EditDebtTab extends StatefulWidget {
  dynamic data;

  EditDebtTab({super.key, required this.data});

  @override
  State<EditDebtTab> createState() => _EditDebtTabState();
}

class _EditDebtTabState extends State<EditDebtTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data.id != '') {
      setState(() {
        selectedItem = widget.data['typeOfUtang'];
        duedate.text = widget.data['dueDate'];
        interestRate.text = widget.data['interest'].toString();
      });
    }
  }

  final searchController = TextEditingController();
  String nameSearched = '';

  final List<String> items = [
    'Installment Loan',
    'One Time Loan',
  ];
  String? selectedItem = 'Installment Utang';

  final interestRate = TextEditingController();

  String? _selectedFrequency = 'Monthly';

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

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
              ListTile(
                title: TextWidget(
                  text: 'Borrower: ${widget.data['name']}',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
                trailing: Icon(
                  Icons.check_box,
                ),
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
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(fontFamily: 'Medium'),
                              ),
                            );
                          }).toList(),
                          onChanged: null,
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
                      isInterest: true,
                      enabled: false,
                      label: '${widget.data['paymentTerms']} Interest (%)',
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
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedFrequency = value;
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: TextFieldWidget(
                  enabled: false,
                  borderColor: Colors.black,
                  label: 'Due date',
                  controller: duedate,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ButtonWidget(
                label: 'Save',
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Utang')
                      .doc(widget.data.id)
                      .update({'dueDate': duedate.text});
                  Navigator.of(context).pop();
                  showToast('Utang saved succesfully!');
                },
              ),
              SizedBox(
                height: 20,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 30)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        duedate.text =
            DateFormat('MMMM dd, yyyy').format(picked); // format here
      });
    }
  }
}
