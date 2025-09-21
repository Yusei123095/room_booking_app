import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/utils/time_utils.dart';

// StreamProvider for occupied timeslots (dynamic data)
final occupiedTimeslotsProvider = StreamProvider.family<List<int>, ({String? roomId, String? bookId})>
((ref, arg) {
    final selectedDate = ref.watch(bookingDateProvider.select((u) => u.tempSelectedDate))!;
    final endOfSelectedDate = selectedDate.add(const Duration(days: 1));

    return FirebaseFirestore.instance
        .collection("books")
        .where("room", isEqualTo: arg.roomId ?? "")
        .where("date", isGreaterThanOrEqualTo: selectedDate)
        .where("date", isLessThan: endOfSelectedDate)
        .snapshots() // This is the key change!
        .map((snapshot) {
      final occupiedSlits = <int>[];
      for (var doc in snapshot.docs) {
        if(doc.id != arg.bookId){occupiedSlits.addAll(List<int>.from(doc.data()['timeslots']));}
      }
      return occupiedSlits;
    });
  },
);

final timeslotsProvider = FutureProvider.family<
  List<Map<String, dynamic>>,
  ({String? roomId, String? bookId})
>((ref, arg) async {
  final selectedDate =
      ref.watch(bookingDateProvider.select((u) => u.tempSelectedDate))!;
  final occupiedSlots = ref.watch(occupiedTimeslotsProvider((roomId: arg.roomId, bookId: arg.bookId)));
  final occupiedList = occupiedSlots.value ?? [];
  Map<int, Map<String, dynamic>> timeslotDetails = {};

  final allTimeSlots =
      await FirebaseFirestore.instance
          .collection("timeslots")
          .orderBy("number", descending: false)
          .get();



  final timeslotsWithAvailability =
      allTimeSlots.docs.map((timeslot) {
        final timeslotData = timeslot.data();
        timeslotDetails[timeslotData["number"]] = timeslotData;


        final isAvailable =
            occupiedList.contains(timeslotData['number']) ||
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


