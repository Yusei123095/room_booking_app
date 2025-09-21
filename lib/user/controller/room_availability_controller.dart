import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/utils/time_utils.dart';

final roomAvailabilityProvider = FutureProvider.family<
  bool?,
  ({bool isTemp, String? roomId, String? bookId})
>((ref, arg) async {
  final bookingDateTimeState = ref.watch(bookingDateProvider);
  final bookingDateTimeNotifier = ref.watch(bookingDateProvider.notifier);
  final selectedDate = bookingDateTimeNotifier.getSelectedDate(arg.isTemp);
  final endSelectedDate = selectedDate.add(const Duration(days: 1));

  final selectedTimeslots = bookingDateTimeNotifier.getTimeslots(arg.isTemp);
  final timeslotsDetail = bookingDateTimeState.timeslotDetails;
  if (selectedTimeslots.isEmpty) {

    return null;
  }

  int startHour = timeslotsDetail[selectedTimeslots[0]]!['start_hour'];
  int startMin = timeslotsDetail[selectedTimeslots[0]]!['start_min'];

  if (checkPassedTime(selectedDate, startHour, startMin)) {
    return false;
  }

  if (arg.roomId == null) {
    return true;
  }

  final books =
      await FirebaseFirestore.instance
          .collection("books")
          .where("room", isEqualTo: arg.roomId)
          .where("date", isGreaterThanOrEqualTo: selectedDate)
          .where("date", isLessThan: endSelectedDate)
          .where("timeslots", arrayContainsAny: selectedTimeslots)
          .get();

  final filteredBooks = books.docs.where((book) => book.id != arg.bookId).toList();

  return filteredBooks.isEmpty;
});
