// time_utils.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

bool checkPassedTime(DateTime selectedDate ,int hour, int min){
  int currentHour = DateTime.now().hour;
  int currentMinute = DateTime.now().minute;

  String selectedDay = DateFormat('yyyy-MM-dd').format(selectedDate);
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());


  return selectedDay == today ? (currentHour * 60 + currentMinute) > (hour * 60 + min) : false;
}

String convertDateFormat(DateTime date){
  String today = DateFormat('MMM dd, yyyy').format(DateTime.now());
  String selectedDate = DateFormat('MMM dd, yyyy').format(date);

  return selectedDate == today ? "Today" : selectedDate;
}

String convertDateTimeFormat(DateTime dateTime){
  return DateFormat('MMM dd, yyyy, hh:mm').format(dateTime);
}

