import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/tabs/editdebt_tab.dart';
import 'package:pautang_tracker/screens/view_debt_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

class OverdueLoanTab extends StatefulWidget {
  String id;
  OverdueLoanTab({super.key, required this.id});

  @override
  State<OverdueLoanTab> createState() => _OverdueLoanTabState();
}

class _OverdueLoanTabState extends State<OverdueLoanTab> {
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
      drawer: DrawerWidget(
        id: widget.id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Overdue Loan',
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
            Container(
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
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Utang')
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
                      return DateFormat("MMMM d, yyyy")
                              .parse(data.docs[index]['lastPaid'])
                              .isAfter(DateFormat("MMMM d, yyyy")
                                  .parse(data.docs[index]['dueDate']))
                          ? Slidable(
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
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Utang')
                                                          .doc(data
                                                              .docs[index].id)
                                                          .delete();
                                                      Navigator.of(context)
                                                          .pop();
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
                                            builder: (context) =>
                                                ViewDebtScreen(
                                                  data: data.docs[index],
                                                )),
                                      );
                                    },
                                    leading: Icon(
                                      Icons.account_circle,
                                      size: 50,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextWidget(
                                          text: data.docs[index]['name'],
                                          fontSize: 18,
                                          fontFamily: 'Bold',
                                        ),
                                        TextWidget(
                                          text:
                                              'Due Date: ${data.docs[index]['dueDate']}',
                                          fontSize: 12,
                                          fontFamily: 'Regular',
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextWidget(
                                          text:
                                              'P${data.docs[index]['amount']}',
                                          fontSize: 24,
                                          fontFamily: 'Bold',
                                          color: Colors.red,
                                        ),
                                        TextWidget(
                                          text: 'Payment',
                                          fontSize: 12,
                                          fontFamily: 'Regular',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            )
                          : SizedBox();
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
