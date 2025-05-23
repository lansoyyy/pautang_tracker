import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/tabs/adddebt_tab.dart';
import 'package:pautang_tracker/screens/tabs/editdebt_tab.dart';
import 'package:pautang_tracker/screens/view_debt_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

class UtangTab extends StatefulWidget {
  String id;
  UtangTab({super.key, required this.id});

  @override
  State<UtangTab> createState() => _UtangTabState();
}

class _UtangTabState extends State<UtangTab> {
  final searchController = TextEditingController();
  String nameSearched = '';

  final List<String> items = [
    'All Loan',
    'One Time Loan',
    'Installment Loan',
  ];
  String? selectedItem = 'All Loan';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => AdddebtTab(
                      id: widget.id,
                    )),
            (route) => false,
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: DrawerWidget(
        id: widget.id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Loans',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                TextWidget(
                  text: formattedDate,
                  fontSize: 18,
                  fontFamily: 'Medium',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 310,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Regular',
                          fontSize: 14),
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
                          hintStyle:
                              TextStyle(fontFamily: 'Regular', fontSize: 18),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )),
                      controller: searchController,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: selectedItem == 'All Loan'
                    ? FirebaseFirestore.instance
                        .collection('Utang')
                        .where('dueDate', isEqualTo: formattedDate)
                        .where('name',
                            isGreaterThanOrEqualTo:
                                toBeginningOfSentenceCase(nameSearched))
                        .where('name',
                            isLessThan:
                                '${toBeginningOfSentenceCase(nameSearched)}z')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Utang')
                        .where('dueDate', isEqualTo: formattedDate)
                        .where('typeOfUtang', isEqualTo: selectedItem)
                        .where('name',
                            isGreaterThanOrEqualTo:
                                toBeginningOfSentenceCase(nameSearched))
                        .where('name',
                            isLessThan:
                                '${toBeginningOfSentenceCase(nameSearched)}z')
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
                  return Expanded(
                      child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => EditDebtTab(
                                            data: data.docs[index],
                                          )),
                                );
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Delete Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'Bold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this Record?',
                                            style: TextStyle(
                                                fontFamily: 'Regular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Utang')
                                                    .doc(data.docs[index].id)
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ViewDebtScreen(
                                            data: data.docs[index],
                                          )),
                                );
                              },
                              leading: Icon(
                                Icons.account_circle,
                                size: 50,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextWidget(
                                    text: data.docs[index]['name'],
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: data.docs[index]['paidAmount'] >=
                                            data.docs[index]['amount']
                                        ? 'This loan is completed!'
                                        : 'Due Date: ${data.docs[index]['dueDate']}',
                                    fontSize: 12,
                                    fontFamily: 'Regular',
                                    color: data.docs[index]['paidAmount'] >=
                                            data.docs[index]['amount']
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextWidget(
                                    text: data.docs[index]['paidAmount'] >=
                                            data.docs[index]['amount']
                                        ? '0'
                                        : 'P${data.docs[index]['amount']}',
                                    fontSize: 24,
                                    fontFamily: 'Bold',
                                    color: data.docs[index]['paidAmount'] >=
                                            data.docs[index]['amount']
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                  TextWidget(
                                    text: data.docs[index]['paidAmount'] >=
                                            data.docs[index]['amount']
                                        ? 'No payment'
                                        : 'Payment',
                                    fontSize: 12,
                                    fontFamily: 'Regular',
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ));
                })
          ],
        ),
      ),
    );
  }

  String formattedDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        formattedDate =
            DateFormat('MMMM dd, yyyy').format(picked); // format here
      });
    }
  }
}
