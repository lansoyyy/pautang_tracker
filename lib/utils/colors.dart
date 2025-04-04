import 'package:flutter/material.dart';

const primary = Color(0xff0466c8);
const secondary = Color(0Xff0353a4);
var darkPrimary = Color(0xff001845);
var black = const Color(0xff141414);
var white = const Color(0xffeff0f2);
var grey = const Color(0xff979dac);
TimeOfDay parseTime(String timeString) {
  List<String> parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}
