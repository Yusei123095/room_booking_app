import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/src/framework.dart';
import 'package:room_booking_app/user/models/booking_date_time_model.dart';

final bookingDateProvider =
    StateNotifierProvider<BookingDateNotifier, BookingDateTimeState>((ref) {
      return BookingDateNotifier();
    });

class BookingDateNotifier extends StateNotifier<BookingDateTimeState> {
  BookingDateNotifier()
    : super(
        BookingDateTimeState(
          selectedDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          tempFocusedDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          tempSelectedDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        ),
      ) {}

  void setTempSelectedDate(DateTime date) {
    state = state.copyWith(tempSelectedDate: date);
  }

  void setTempFocusedDate(DateTime date) {
    state = state.copyWith(tempFocusedDate: date);
  }

  void setDateTimeslots() {
    state = state.copyWith(updateDateTime: true);
  }

  void setTempTimeslots(List<int> timeslots) {

    state = state.copyWith(initialTempTimeslots: timeslots);
  }

  void updateTempTimeslots(int timeslot, bool isAdded) {
    state = state.copyWith(timeslot: timeslot, add: isAdded);
  }

  void setTimeslotsDetails(Map<int, Map<String, dynamic>?>? timeslotDetails) {
    state = state.copyWith(timeslotDetails: timeslotDetails);
  }

  void resetTimeslots() {
    state = state.copyWith(resetTimeslots: true);
  }

  String getStartEndTime(bool isTemp) {
    final timeslots = isTemp ? state.tempTimeslots : state.timeslots;
    final timeslotsDetail = state.timeslotDetails;

    if (timeslots.isEmpty) {
      return "Non-selected";
    }
    final start = timeslotsDetail[timeslots[0]];
    final end = timeslotsDetail[timeslots[timeslots.length - 1]];
    return "${start!['start'] ?? "00:00"} - ${end!['end'] ?? "00:00"}";
  }

  DateTime getSelectedDate(bool isTemp) {
    DateTime date = isTemp ? state.tempSelectedDate! : state.selectedDate!;
    return date;
  }

  List<int> getTimeslots(bool isTemp) {
    return isTemp ? state.tempTimeslots : state.timeslots;
  }

  void bookRoom(String roomId, String user) async {
    DateTime selectedDate = state.selectedDate!;
    List<int> timeslots = state.timeslots;
    Map<String, dynamic> startTimeslot = state.timeslotDetails[timeslots[0]]!;
    Map<String, dynamic> endTimeslot = state.timeslotDetails[timeslots[timeslots.length - 1]]!;

    await FirebaseFirestore.instance.collection("books").add(({
      "room": roomId,
      "user": user,
      "date": DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTimeslot['start_hour'] ?? 0,
        startTimeslot['start_min'] ?? 0,
      ),
      "duration": "${startTimeslot['start'] ?? "00:00"} - ${endTimeslot['end'] ?? "00:00"}",
      "timeslots": timeslots,
    }));
  }

  void modifyBookingTime(String bookId) async {
    DateTime selectedDate = state.tempSelectedDate!;
    List<int> timeslots = state.tempTimeslots;
    Map<String, dynamic> startTimeslot = state.timeslotDetails[timeslots[0]]!;
    Map<String, dynamic> endTimeslot = state.timeslotDetails[timeslots[timeslots.length - 1]]!;
    await FirebaseFirestore.instance.collection("books").doc(bookId).update(({
      "date": DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTimeslot['start_hour'] ?? 0,
        startTimeslot['start_min'] ?? 0,
      ),
      "duration": "${startTimeslot['start'] ?? "00:00"} - ${endTimeslot['end'] ?? "00:00"}",
      "timeslots": timeslots,
    }));
  }
}
