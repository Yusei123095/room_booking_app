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

  void setTempTimeslots() {
    state = state.copyWith(setTempTimeslot: true);
  }

  void updateTempTimeslots(Map<String, dynamic> timeslot, bool isAdded) {
    state = state.copyWith(timeslot: timeslot, add: isAdded);
  }

  void setTimeslotsDetails(Map<int, List<dynamic>?>? timeslotDetails) {
    state = state.copyWith(timeslotDetails: timeslotDetails);
  }

  void resetTimeslots() {
    state = state.copyWith(resetTimeslots: true);
  }

  String getStartEndTime(bool isTemp) {
    final timeslots = isTemp ? state.tempTimeslots : state.timeslots;
    Map<int, List<dynamic>?> timeslotDetails = state.timeslotDetails;

    if (timeslots.isEmpty) {
      return "Non-selected";
    }
    return "${timeslots[0]['start'] ?? "00:00"} - ${timeslots[timeslots.length - 1]['end'] ?? "00:00"}";
  }

  DateTime getSelectedDate(bool isTemp) {
    DateTime date = isTemp ? state.tempSelectedDate! : state.selectedDate!;
    return date;
  }

  List<Map<String, dynamic>> getTimeslots(bool isTemp) {
    return isTemp ? state.tempTimeslots : state.timeslots;
  }

  void bookRoom(String roomId, String user) async {
    DateTime selectedDate = state.selectedDate!;
    List<Map<String, dynamic>> timeslots = state.timeslots;
    Map<String, dynamic> startTimeslot = state.timeslots[0];

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
      "duration": "${timeslots[0]['start'] ?? "00:00"} - ${timeslots[timeslots.length - 1]['end'] ?? "00:00"}",
      "timeslots": state.timeslots.map((timeslot) => timeslot['number']),
    }));
  }
}
