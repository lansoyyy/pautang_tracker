import 'package:flutter/material.dart';
import 'package:pautang_tracker/utils/colors.dart';
import 'package:pautang_tracker/widgets/drawer_widget.dart';
import 'package:pautang_tracker/widgets/text_widget.dart';

class UtangTab extends StatelessWidget {
  const UtangTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primary,
        title: TextWidget(
          text: 'Debts',
          fontSize: 18,
          fontFamily: 'Bold',
          color: Colors.white,
        ),
        centerTitle: true,
      ),
    );
  }
}
