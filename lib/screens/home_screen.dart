import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pautang_tracker/screens/tabs/adddebt_tab.dart';
import 'package:pautang_tracker/screens/tabs/notif_tab.dart';
import 'package:pautang_tracker/screens/view_debt_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  String id;
  HomeScreen({super.key, required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getSummaryData();
  }

  int borrowers = 0;
  int overdueLoans = 0;
  int loansDueToday = 0;
  bool hasLoaded = false;
  double totalLoanJanuary = 0;
  double totalPaymentJanuary = 0;

  double totalLoanFebruary = 0;
  double totalPaymentFebruary = 0;

  double totalLoanMarch = 0;
  double totalPaymentMarch = 0;

  double totalLoanApril = 0;
  double totalPaymentApril = 0;

  double totalLoanMay = 0;
  double totalPaymentMay = 0;

  double totalLoanJune = 0;
  double totalPaymentJune = 0;

  double totalLoanJuly = 0;
  double totalPaymentJuly = 0;

  double totalLoanAugust = 0;
  double totalPaymentAugust = 0;

  double totalLoanSeptember = 0;
  double totalPaymentSeptember = 0;

  double totalLoanOctober = 0;
  double totalPaymentOctober = 0;

  double totalLoanNovember = 0;
  double totalPaymentNovember = 0;

  double totalLoanDecember = 0;
  double totalPaymentDecember = 0;

  getSummaryData() {
    FirebaseFirestore.instance
        .collection('Borrower')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        borrowers = querySnapshot.docs.length;
      });
      // querySnapshot.docs.forEach((doc) {
      //     print(doc["first_name"]);
      // });
    });
    FirebaseFirestore.instance
        .collection('Utang')
        .get()
        .then((QuerySnapshot data) {
      for (var doc in data.docs) {
        print(DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month);
        setState(() {
          if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month == 1) {
            totalPaymentJanuary += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              2) {
            totalPaymentFebruary += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              3) {
            totalPaymentMarch += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              4) {
            totalPaymentApril += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              5) {
            totalPaymentMay += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              6) {
            totalPaymentJune += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              7) {
            totalPaymentJuly += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              8) {
            totalPaymentAugust += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              9) {
            totalPaymentSeptember += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              10) {
            totalPaymentOctober += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              11) {
            totalPaymentNovember += double.parse(doc['paidAmount'].toString());
          } else if (DateFormat("MMMM dd, yyyy").parse(doc['lastPaid']).month ==
              12) {
            totalPaymentDecember += double.parse(doc['paidAmount'].toString());
          }
        });

        setState(() {
          if (doc['dateTime'].toDate().month == 1) {
            totalLoanJanuary += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 2) {
            totalLoanFebruary += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 3) {
            totalLoanMarch += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 4) {
            totalLoanApril += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 5) {
            totalLoanMay += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 6) {
            totalLoanJune += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 7) {
            totalLoanJuly += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 8) {
            totalLoanAugust += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 9) {
            totalLoanSeptember += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 10) {
            totalLoanOctober += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 11) {
            totalLoanNovember += double.parse(doc['amount'].toString());
          } else if (doc['dateTime'].toDate().month == 12) {
            totalLoanDecember += double.parse(doc['amount'].toString());
          }
        });

        // totalLoan += double.parse(doc['amount'].toString());

        if (DateTime.now()
            .isAfter(DateFormat("MMMM dd, yyyy").parse(doc['dueDate']))) {
          setState(() {
            overdueLoans++;
          });
        }

        if (DateFormat("MMMM dd, yyyy").format(DateTime.now()) ==
            DateFormat('MMMM dd, yyyy')
                .format(DateFormat("MMMM dd, yyyy").parse(doc['dueDate']))) {
          setState(() {
            loansDueToday++;
          });
        }
      }
    });

    setState(() {
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(1, totalLoanJanuary),
      SalesData(2, totalLoanFebruary),
      SalesData(3, totalLoanMarch),
      SalesData(4, totalLoanApril),
      SalesData(5, totalLoanMay),
      SalesData(6, totalLoanJune),
      SalesData(7, totalLoanJuly),
      SalesData(8, totalLoanAugust),
      SalesData(9, totalLoanSeptember),
      SalesData(10, totalLoanOctober),
      SalesData(11, totalLoanNovember),
      SalesData(12, totalLoanDecember),
    ];
    final List<SalesData> chartData1 = [
      SalesData(1, totalPaymentJanuary),
      SalesData(2, totalPaymentFebruary),
      SalesData(3, totalPaymentMarch),
      SalesData(4, totalPaymentApril),
      SalesData(5, totalPaymentMay),
      SalesData(6, totalPaymentJune),
      SalesData(7, totalPaymentJuly),
      SalesData(8, totalPaymentAugust),
      SalesData(9, totalPaymentSeptember),
      SalesData(10, totalPaymentOctober),
      SalesData(11, totalPaymentNovember),
      SalesData(12, totalPaymentDecember),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerWidget(
        id: widget.id,
      ),
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
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Dashboard',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => NotifTab(
                          id: widget.id,
                        )),
                (route) => false,
              );
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: hasLoaded
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                        color: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SfCartesianChart(
                            title: ChartTitle(
                              text: 'Loan and Payments Comparison',
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bold'),
                            ),
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            primaryXAxis: NumericAxis(
                              title: AxisTitle(text: 'Month'),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorGridLines: MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(text: 'Number'),
                              labelFormat: '{value}',
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0),
                            ),
                            series: <CartesianSeries>[
                              // Renders line chart
                              LineSeries<SalesData, int>(
                                  name: 'Total Loan',
                                  dataSource: chartData,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales),
                              LineSeries<SalesData, int>(
                                  name: 'Total Payment',
                                  dataSource: chartData1,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales)
                            ])),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: 'Summary',
                      fontSize: 18,
                      fontFamily: 'Medium',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            width: 175,
                            height: 125,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/borrow.png',
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: borrowers.toString(),
                                          fontSize: 38,
                                          fontFamily: 'Bold',
                                        ),
                                        TextWidget(
                                          text: 'Borrowers',
                                          fontSize: 12,
                                          fontFamily: 'Regular',
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            width: 175,
                            height: 125,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      color: primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/deadline.png',
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: overdueLoans.toString(),
                                          fontSize: 38,
                                          fontFamily: 'Bold',
                                        ),
                                        TextWidget(
                                          text: 'Overdue\nLoans',
                                          fontSize: 12,
                                          fontFamily: 'Regular',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 125,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/loan.png',
                                    height: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: loansDueToday.toString(),
                                    fontSize: 38,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: 'Loans Due Today',
                                    fontSize: 12,
                                    fontFamily: 'Regular',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: 'Calendar',
                      fontSize: 18,
                      fontFamily: 'Medium',
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SfCalendar(
                        backgroundColor: Colors.white,
                        view: CalendarView.month,
                        onTap: (calendarTapDetails) {
                          double loansToday = 0;
                          double loansThisMonth = 0;
                          double paymentsToday = 0;
                          double paymentsThisMonth = 0;
                          FirebaseFirestore.instance
                              .collection('Utang')
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            for (var doc in querySnapshot.docs) {
                              if (doc['dateTime'].toDate().month ==
                                  calendarTapDetails.date!.month) {
                                setState(() {
                                  loansThisMonth +=
                                      double.parse(doc['amount'].toString());
                                });
                              }
                              if (doc['dateTime'].toDate().month ==
                                      calendarTapDetails.date!.month &&
                                  doc['dateTime'].toDate().day ==
                                      calendarTapDetails.date!.day) {
                                setState(() {
                                  loansToday +=
                                      double.parse(doc['amount'].toString());
                                });
                              }
                            }
                          }).whenComplete(
                            () {
                              FirebaseFirestore.instance
                                  .collection('Payment History')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                for (var doc in querySnapshot.docs) {
                                  if (doc['dateTime'].toDate().month ==
                                      calendarTapDetails.date!.month) {
                                    setState(() {
                                      paymentsThisMonth += double.parse(
                                          doc['amount'].toString());
                                    });
                                  }
                                  if (doc['dateTime'].toDate().month ==
                                          calendarTapDetails.date!.month &&
                                      doc['dateTime'].toDate().day ==
                                          calendarTapDetails.date!.day) {
                                    setState(() {
                                      paymentsToday += double.parse(
                                          doc['amount'].toString());
                                    });
                                  }
                                }
                              }).whenComplete(
                                () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: SizedBox(
                                          width: 500,
                                          height: 500,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      text: DateFormat.yMMMd()
                                                          .format(
                                                              calendarTapDetails
                                                                  .date!),
                                                      fontSize: 18,
                                                      fontFamily: 'Medium',
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        )),
                                                  ],
                                                ),
                                                Divider(),
                                                TextWidget(
                                                  text: 'Loan',
                                                  fontSize: 18,
                                                  fontFamily: 'Bold',
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      text: 'This Day',
                                                      fontSize: 14,
                                                      fontFamily: 'Regular',
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          'P${loansToday.toStringAsFixed(0)}',
                                                      fontSize: 18,
                                                      fontFamily: 'Medium',
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      text: 'This Month',
                                                      fontSize: 14,
                                                      fontFamily: 'Regular',
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          'P${loansThisMonth.toStringAsFixed(0)}',
                                                      fontSize: 18,
                                                      fontFamily: 'Medium',
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                TextWidget(
                                                  text: 'Payments',
                                                  fontSize: 18,
                                                  fontFamily: 'Bold',
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      text: 'This Day',
                                                      fontSize: 14,
                                                      fontFamily: 'Regular',
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          'P${paymentsToday.toStringAsFixed(0)}',
                                                      fontSize: 18,
                                                      fontFamily: 'Medium',
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      text: 'This Month',
                                                      fontSize: 14,
                                                      fontFamily: 'Regular',
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          'P${paymentsThisMonth.toStringAsFixed(0)}',
                                                      fontSize: 18,
                                                      fontFamily: 'Medium',
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                TextWidget(
                                                  text: 'Due this day',
                                                  fontSize: 18,
                                                  fontFamily: 'Bold',
                                                ),
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('Utang')
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (snapshot.hasError) {
                                                        print(snapshot.error);
                                                        return const Center(
                                                            child:
                                                                Text('Error'));
                                                      }
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 50),
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      final data =
                                                          snapshot.requireData;
                                                      return Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    data.docs
                                                                        .length;
                                                                i++)
                                                              DateFormat.yMMMd().format(DateFormat(
                                                                              "MMMM dd, yyyy")
                                                                          .parse(data.docs[i]
                                                                              [
                                                                              'dueDate'])) ==
                                                                      DateFormat
                                                                              .yMMMd()
                                                                          .format(calendarTapDetails
                                                                              .date!)
                                                                  ? Builder(builder:
                                                                      (context) {
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          ListTile(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              Navigator.of(context).push(
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => ViewDebtScreen(
                                                                                          data: data.docs[i],
                                                                                          id: data.docs[i].id,
                                                                                        )),
                                                                              );
                                                                            },
                                                                            leading:
                                                                                Icon(
                                                                              Icons.account_circle,
                                                                              size: 50,
                                                                            ),
                                                                            title:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                TextWidget(
                                                                                  text: data.docs[i]['borrowerData']['name'],
                                                                                  fontSize: 18,
                                                                                  fontFamily: 'Bold',
                                                                                ),
                                                                                TextWidget(
                                                                                  text: data.docs[i]['borrowerData']['address'],
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Regular',
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            trailing:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                TextWidget(
                                                                                  text: 'P${data.docs[i]['payment']}',
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
                                                                          ),
                                                                          Divider(),
                                                                        ],
                                                                      );
                                                                    })
                                                                  : SizedBox()
                                                          ],
                                                        ),
                                                      ));
                                                    }),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
