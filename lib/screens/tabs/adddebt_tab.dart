import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/tabs/utang_tab.dart';
import 'package:pautang_tracker/services/add_utang.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/utils/const.dart';
import 'package:pautang_tracker/widgets/button_widget.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:pautang_tracker/widgets/toast_widget.dart';

class AdddebtTab extends StatefulWidget {
  final String id;

  const AdddebtTab({super.key, required this.id});

  @override
  State<AdddebtTab> createState() => _AdddebtTabState();
}

class _AdddebtTabState extends State<AdddebtTab> {
  final searchController = TextEditingController();
  final interestRate = TextEditingController();
  final amount = TextEditingController();
  final duedate = TextEditingController(
    text: DateFormat('MMMM dd, yyyy')
        .format(DateTime.now().add(Duration(days: 30))),
  );

  final List<String> items = ['Installment Loan', 'One Time Loan'];
  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  String? selectedItem = 'Installment Loan';
  String? selectedFrequency = 'Monthly';
  String nameSearched = '';
  String borrowerId = '';
  String borrowerName = '';

  dynamic borrowerData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(id: widget.id),
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Add Debt',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBorrowerSearch(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAmountInput(),
                  amount.text != ''
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextWidget(
                              text: 'Total Amount (with interest)',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: interestRate.text == ''
                                  ? ''
                                  : 'P${calculateFlatInterest(double.parse(amount.text), double.parse(interestRate.text)).toString()}',
                              fontSize: 32,
                              color: Colors.green,
                              fontFamily: 'Bold',
                            ),
                          ],
                        )
                      : SizedBox()
                ],
              ),
              const SizedBox(height: 10),
              _buildDebtTypeAndInterest(),
              const SizedBox(height: 20),
              if (selectedItem == 'Installment Utang') _buildPaymentFrequency(),
              const SizedBox(height: 10),
              _buildDueDatePicker(),
              const SizedBox(height: 40),
              Visibility(
                visible: borrowerId != '',
                child: Center(
                  child: ButtonWidget(
                    label: 'Save',
                    onPressed: _saveDebt,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBorrowerSearch() {
    return Column(
      children: [
        TextFormField(
          controller: searchController,
          style: const TextStyle(color: Colors.black, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Search borrower',
            hintStyle: TextStyle(fontFamily: 'Regular', fontSize: 18),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
          ),
          onChanged: (value) => setState(() => nameSearched = value),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Borrower')
              .where('name',
                  isGreaterThanOrEqualTo:
                      toBeginningOfSentenceCase(nameSearched))
              .where('name',
                  isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Center(child: Text('Error loading borrowers'));
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(color: Colors.black)),
              );
            }

            final data = snapshot.requireData;
            return SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  final borrower = data.docs[index];
                  final isSelected = borrowerId == borrower.id;

                  return ListTile(
                    title: TextWidget(
                      text: borrower['name'],
                      fontSize: 18,
                      fontFamily: 'Bold',
                    ),
                    trailing: Icon(isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                    onTap: () {
                      setState(() {
                        borrowerId = borrower.id;
                        borrowerName = borrower['name'];
                        borrowerData = borrower.data();
                      });
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return SizedBox(
      width: 150,
      child: TextFieldWidget(
        label: 'Amount',
        controller: amount,
        borderColor: Colors.black,
        inputType: TextInputType.number,
      ),
    );
  }

  Widget _buildDebtTypeAndInterest() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'Type of Utang:', fontSize: 14),
            const SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: DropdownButtonFormField<String>(
                value: selectedItem,
                items: items
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (value) => setState(() => selectedItem = value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                ? '$selectedFrequency interest (%)'
                : 'Interest (%)',
            controller: interestRate,
            borderColor: Colors.black,
            inputType: TextInputType.number,
            onChanged: (p0) {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentFrequency() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: 'Payment terms', fontSize: 18),
        Wrap(
          spacing: 5,
          children: frequencies.map((freq) {
            return SizedBox(
              width: 175,
              child: ListTile(
                title: Text(freq, style: TextStyle(fontFamily: 'Medium')),
                leading: Radio<String>(
                  value: freq,
                  groupValue: selectedFrequency,
                  onChanged: (value) =>
                      setState(() => selectedFrequency = value),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDueDatePicker() {
    return GestureDetector(
      onTap: _selectDate,
      child: TextFieldWidget(
        enabled: false,
        borderColor: Colors.black,
        label: 'Due date',
        controller: duedate,
      ),
    );
  }

  void _saveDebt() {
    final int principal = int.tryParse(amount.text) ?? 0;
    final double rate = double.tryParse(interestRate.text) ?? 0.0;

    addUtang(
        borrowerId,
        borrowerName,
        selectedItem ?? '',
        rate.toInt(),
        selectedFrequency ?? '',
        duedate.text,
        widget.id,
        calculateFlatInterest(
          principal.toDouble(),
          rate,
        ), // Use calculated final amount
        borrowerData);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => UtangTab(
                id: widget.id,
              )),
      (route) => false,
    );

    showToast('Utang saved successfully with interest!');
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 30)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        duedate.text = DateFormat('MMMM dd, yyyy').format(picked);
      });
    }
  }
}
