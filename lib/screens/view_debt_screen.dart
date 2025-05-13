import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/services/add_history.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:pautang_tracker/widgets/textfield_widget.dart';
import 'package:pautang_tracker/widgets/toast_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ViewDebtScreen extends StatefulWidget {
  String? id;
  dynamic data;

  ViewDebtScreen({super.key, this.id, this.data});

  @override
  State<ViewDebtScreen> createState() => _ViewDebtScreenState();
}

class _ViewDebtScreenState extends State<ViewDebtScreen> {
  final interestRate = TextEditingController(text: '5');

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
          if (widget.data['typeOfUtang'] == 'One Time Loan') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text(
                        'Mark as Paid',
                        style: TextStyle(
                            fontFamily: 'Bold', fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                        'Are you sure you want to mark this loan as paid?',
                        style: TextStyle(fontFamily: 'Regular'),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Utang')
                                .doc(widget.data.id)
                                .delete();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontFamily: 'Regular',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ));
          } else {
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
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Utang')
                            .doc(widget.data.id)
                            .update({
                          'lastPaid': DateFormat('MMMM dd, yyyy')
                              .format(DateTime.now()),
                          'paidAmount':
                              FieldValue.increment(int.parse(payment.text)),
                          'dueDate': DateFormat('MMMM dd, yyyy').format(
                              DateFormat("MMMM dd, yyyy")
                                  .parse(widget.data['dueDate'])
                                  .add(Duration(days: 30)))
                        });
                        addPaymentHistory(
                            widget.data.id,
                            int.parse(payment.text),
                            DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                            widget.data['borrowerData']);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showToast('Payment recorded succesfully!');
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
          }
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
            onPressed: () async {
              await launchUrlString(
                  'tel:${widget.data['borrowerData']['contactNumber']}');
            },
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
                        text: widget.data['borrowerData']['name'],
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
                          text: widget.data['borrowerData']['gender'],
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
                          text: widget.data['borrowerData']['address'],
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
              widget.data['typeOfUtang'] == 'Installment Loan'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text:
                              'Payment this ${widget.data['paymentTerms'] == 'Daily' ? 'day' : '${widget.data['paymentTerms']!.split('l')[0]}'}',
                          fontSize: 16,
                          fontFamily: 'Medium',
                        ),
                        TextWidget(
                          text: 'P${widget.data['payment']}',
                          fontSize: 32,
                          fontFamily: 'Bold',
                          color: primary,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Total payment',
                          fontSize: 16,
                          fontFamily: 'Medium',
                        ),
                        TextWidget(
                          text: 'P${widget.data['amount']}',
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
              Visibility(
                visible: widget.data['typeOfUtang'] != 'One Time Loan',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget.data['typeOfUtang'] == 'One Time Loan'
                              ? 'P${widget.data['amount']}'
                              : 'P${((widget.data['payment'] * widget.data['duration'])).toStringAsFixed(0)}',
                          fontSize: 28,
                          fontFamily: 'Bold',
                          color: Colors.green,
                        ),
                        TextWidget(
                          text: 'Total Loan',
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
                          text:
                              'P${widget.data['paidAmount'].toStringAsFixed(0)}',
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
                          text:
                              'P${(widget.data['typeOfUtang'] == 'One Time Loan' ? widget.data['amount'] - widget.data['paidAmount'] : ((widget.data['payment'] * widget.data['duration'])) - widget.data['paidAmount']).toStringAsFixed(0)}',
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
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFieldWidget(
                      enabled: false,
                      label: 'Type of Utang',
                      controller: TextEditingController(
                          text: widget.data['typeOfUtang']),
                      borderColor: Colors.black,
                      inputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextFieldWidget(
                      enabled: false,
                      isInterest: true,
                      label: widget.data['typeOfUtang'] == 'Installment Loan'
                          ? ' ${widget.data['paymentTerms']} interest (%)'
                          : 'Interest (%)',
                      controller: TextEditingController(
                          text: widget.data['interest'].toString()),
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
                visible: widget.data['typeOfUtang'] == 'Installment Loan',
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
                              groupValue: widget.data['paymentTerms'],
                              onChanged: (String? value) {},
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              TextFieldWidget(
                enabled: false,
                borderColor: Colors.black,
                label: 'Due date',
                controller: TextEditingController(text: widget.data['dueDate']),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              Visibility(
                visible: widget.data['typeOfUtang'] != 'One Time Loan',
                child: TextWidget(
                  text: 'Payment History',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.data['typeOfUtang'] != 'One Time Loan',
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Payment History')
                        .where('loanId', isEqualTo: widget.data.id)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }

                      final data = snapshot.requireData;
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: data.docs.length,
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
                                    text: data.docs[index]['borrowerData']
                                        ['name'],
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: 'Date: ${data.docs[index]['date']}',
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
                                    text: 'P${data.docs[index]['amount']}',
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
                      );
                    }),
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
