import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/view_debt_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

class NotifTab extends StatelessWidget {
  String id;
  NotifTab({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        id: id,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Notifications',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Utang')
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return DateTime.now().isAfter(DateFormat("MMMM dd, yyyy")
                        .parse(data.docs[index]['dueDate']))
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ViewDebtScreen(
                                      data: data.docs[index],
                                      id: data.docs[index].id,
                                    )),
                          );
                        },
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text:
                                  "${data.docs[index]['borrowerData']['name']}'s loan is overdue",
                              fontSize: 18,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Due date: ${data.docs[index]['dueDate']}',
                              fontSize: 12,
                              fontFamily: 'Regular',
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      )
                    : SizedBox();
              },
            );
          }),
    );
  }
}
