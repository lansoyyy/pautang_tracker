import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
import 'package:pautang_tracker/screens/add_borrower_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BorrowerTab extends StatefulWidget {
  String id;
  String? myId;
  BorrowerTab({super.key, required this.id, required this.myId});

  @override
  State<BorrowerTab> createState() => _BorrowerTabState();
}

class _BorrowerTabState extends State<BorrowerTab> {
  final searchController = TextEditingController();
  String nameSearched = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        id: widget.id,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddBorrowerScreen(
                    id: '',
                    myId: widget.myId,
                  )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Borrowers',
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
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Borrower')
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
                        final borrower = data.docs[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddBorrowerScreen(
                                            id: borrower.id,
                                            data: borrower,
                                            myId: widget.myId,
                                          )));
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
                                                  Navigator.of(context).pop();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Borrower')
                                                      .doc(borrower.id)
                                                      .delete();
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
                                onTap: () {},
                                leading: Icon(
                                  Icons.account_circle,
                                  size: 50,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextWidget(
                                      text:
                                          '${borrower['name']} (${borrower['gender']})',
                                      fontSize: 18,
                                      fontFamily: 'Bold',
                                    ),
                                    TextWidget(
                                      text: 'Address: ${borrower['address']}',
                                      fontSize: 12,
                                      fontFamily: 'Regular',
                                    ),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () async {
                                    await launchUrlString(
                                        'tel:${borrower['contactNumber']}');
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                        size: 35,
                                      ),
                                      TextWidget(
                                        text: 'Call',
                                        fontSize: 12,
                                        fontFamily: 'Regular',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
