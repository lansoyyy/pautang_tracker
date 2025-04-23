import 'package:flutter/material.dart';
import 'package:pautang_tracker/screens/tabs/adddebt_tab.dart';
import 'package:pautang_tracker/screens/tabs/borrower_tab.dart';
import 'package:pautang_tracker/screens/tabs/notif_tab.dart';
import 'package:pautang_tracker/screens/tabs/utang_tab.dart';
import 'package:pautang_tracker/screens/view_debt_screen.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  String id;
  HomeScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(1, 0),
      SalesData(2, 28),
      SalesData(3, 34),
      SalesData(4, 32),
      SalesData(5, 40),
      SalesData(6, 35),
      SalesData(7, 41),
      SalesData(8, 35),
      SalesData(9, 25),
      SalesData(10, 17),
      SalesData(11, 38),
      SalesData(12, 41)
    ];
    final List<SalesData> chartData1 = [
      SalesData(1, 0),
      SalesData(2, 12),
      SalesData(3, 4),
      SalesData(4, 51),
      SalesData(5, 6),
      SalesData(6, 26),
      SalesData(7, 31),
      SalesData(8, 6),
      SalesData(9, 15),
      SalesData(10, 17),
      SalesData(11, 27),
      SalesData(12, 35)
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerWidget(
        id: id,
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
                      id: id,
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
                          id: id,
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
      body: Padding(
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
                        text: 'Debt and Payments Comparison',
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
                            name: 'Total Debt',
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales),
                        LineSeries<SalesData, int>(
                            name: 'Total Payment',
                            dataSource: chartData1,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales)
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => BorrowerTab(
                                  id: id,
                                )),
                      );
                    },
                    child: Card(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: '108',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UtangTab(
                                  id: id,
                                )),
                      );
                    },
                    child: Card(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: '12',
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
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => UtangTab(
                              id: id,
                            )),
                  );
                },
                child: Card(
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
                                text: '28',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text:
                                            '${calendarTapDetails.date!.day}/${calendarTapDetails.date!.month}/${calendarTapDetails.date!.year}',
                                        fontSize: 18,
                                        fontFamily: 'Medium',
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                  Divider(),
                                  TextWidget(
                                    text: 'Debt',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: 'Today',
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                      ),
                                      TextWidget(
                                        text: 'P199,000',
                                        fontSize: 18,
                                        fontFamily: 'Medium',
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: 'This Month',
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                      ),
                                      TextWidget(
                                        text: 'P699,000',
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: 'Today',
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                      ),
                                      TextWidget(
                                        text: 'P29,000',
                                        fontSize: 18,
                                        fontFamily: 'Medium',
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text: 'This Month',
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                      ),
                                      TextWidget(
                                        text: '79,000',
                                        fontSize: 18,
                                        fontFamily: 'Medium',
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  TextWidget(
                                    text: 'Due Today',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                  ),
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        for (int i = 0; i < 100; i++)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewDebtScreen()),
                                                  );
                                                },
                                                leading: Icon(
                                                  Icons.account_circle,
                                                  size: 50,
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextWidget(
                                                      text: 'John Doe',
                                                      fontSize: 18,
                                                      fontFamily: 'Bold',
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          'Zone 03, Poblacion Impasugong Bukidnon',
                                                      fontSize: 12,
                                                      fontFamily: 'Regular',
                                                    ),
                                                  ],
                                                ),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
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
                                              ),
                                              Divider(),
                                            ],
                                          ),
                                      ],
                                    ),
                                  )),
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
                ),
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
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
