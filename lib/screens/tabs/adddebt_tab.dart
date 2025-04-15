import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/tabs/utang_tab.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:pautang_tracker/widgets/toast_widget.dart';

class AdddebtTab extends StatefulWidget {
  String id;
  AdddebtTab({super.key, required this.id});

  @override
  State<AdddebtTab> createState() => _AdddebtTabState();
}

class _AdddebtTabState extends State<AdddebtTab> {
  final searchController = TextEditingController();
  String nameSearched = '';

  final List<String> items = [
    'Installment Utang',
    'One Time Utang',
  ];
  String? selectedItem = 'Installment Utang';

  final interestRate = TextEditingController();

  String? _selectedFrequency = 'Monthly';

  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        id: widget.id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Add Debt',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Regular', fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      nameSearched = value;
                    });
                  },
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintText: 'Search borrower',
                      hintStyle: TextStyle(fontFamily: 'Regular', fontSize: 18),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                  controller: searchController,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextWidget(
                        text: 'John Doe',
                        fontSize: 18,
                        fontFamily: 'Bold',
                      ),
                      trailing: Icon(
                        index == 0
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
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
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => UtangTab(
                              id: widget.id,
                            )),
                    (route) => false,
                  );
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
