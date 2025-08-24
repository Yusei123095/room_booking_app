import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/utils/time_utils.dart';

final timeslotsProvider = FutureProvider.family<
  List<Map<String, dynamic>>,
  String?
>((ref, roomId) async {
  final selectedDate =
      ref.watch(bookingDateProvider.select((u) => u.tempSelectedDate))!;
  final endOfSelectedDate = selectedDate.add(const Duration(days: 1));
  Map<int, List<dynamic>> timeslotDetails = {};

  final allTimeSlots =
      await FirebaseFirestore.instance
          .collection("timeslots")
          .orderBy("number", descending: false)
          .get();

  final snapshot =
      await FirebaseFirestore.instance
          .collection("books")
          .where("room", isEqualTo: roomId ?? "")
          .where("date", isGreaterThanOrEqualTo: selectedDate)
          .where("date", isLessThan: endOfSelectedDate)
          .get();

  List<int> occupiedSlits = [];

  for (var doc in snapshot.docs) {
    occupiedSlits.addAll(List<int>.from(doc.data()['timeslots']));
  }
  final timeslotsWithAvailability =
      allTimeSlots.docs.map((timeslot) {
        final timeslotData = timeslot.data();
        final isAvailable =
            occupiedSlits.contains(timeslotData['number']) ||
            checkPassedTime(
              selectedDate,
              timeslotData['start_hour'],
              timeslotData['start_min'],
            );

        return {
          ...timeslotData,
          'isAvailable': isAvailable,
        }; // Create a new map
      }).toList();



  ref.read(bookingDateProvider.notifier).setTimeslotsDetails(timeslotDetails);
  return timeslotsWithAvailability;
});


