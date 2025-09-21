import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/user/controller/room_availability_controller.dart';
import 'package:room_booking_app/user/controller/timeslots_availability_controller.dart';
import 'package:room_booking_app/widgets/room_detail/availability_display.dart';
import 'package:room_booking_app/widgets/time_selection/my_calendar.dart';

import 'package:room_booking_app/utils/time_utils.dart';
import 'package:room_booking_app/widgets/time_selection/timeslots_grid.dart';

class SelectTimeslotsScreen extends ConsumerStatefulWidget {
  final String? room_id;
  final Map<String, dynamic>? selectedDetail;

  const SelectTimeslotsScreen({super.key, this.room_id, this.selectedDetail});

  @override
  ConsumerState<SelectTimeslotsScreen> createState() =>
      _SelectTimeslotsScreenState();
}

class _SelectTimeslotsScreenState extends ConsumerState<SelectTimeslotsScreen> {
  @override
  void initState() {
    super.initState();
    final bookingDateTimeState = ref.read(bookingDateProvider);
    final bookingDateTimeNotifier = ref.read(bookingDateProvider.notifier);

    // set temporary selected and focused date based on the selected date

    Future.microtask(() {
      DateTime setDate =
          widget.selectedDetail == null
              ? bookingDateTimeState.selectedDate!
              : widget.selectedDetail!["date"].toDate() ?? DateTime.now();

      List<int> setTimeslots =
          widget.selectedDetail == null
              ? bookingDateTimeState.timeslots
              : List<int>.from(widget.selectedDetail!["timeslots"] ?? []);

      bookingDateTimeNotifier.setTempFocusedDate(setDate);
      bookingDateTimeNotifier.setTempSelectedDate(setDate);

      bookingDateTimeNotifier.setTempTimeslots(setTimeslots);
    });
  }

  Map<String, List<Map<String, dynamic>>> getListTimeZone(
    List<Map<String, dynamic>> timeslots,
  ) {
    // list for each time zone timeslots
    List<Map<String, dynamic>> morning = [];

    List<Map<String, dynamic>> afternoon = [];

    List<Map<String, dynamic>> evening = [];
    for (var timeslot in timeslots) {
      if (timeslot["time_zone"] == "Morning") {
        morning.add(timeslot);
      } else if (timeslot["time_zone"] == "Afternoon") {
        afternoon.add(timeslot);
      } else {
        evening.add(timeslot);
      }
    }
    return {"morning": morning, "afternoon": afternoon, "evening": evening};
  }

  bool isSettable = false;

  @override
  Widget build(BuildContext context) {
    final bookId =
        widget.selectedDetail != null ? widget.selectedDetail!["bookId"] : null;
    final timeslots = ref.watch(
      timeslotsProvider((roomId: widget.room_id, bookId: bookId)),
    );
    final isAvailable = ref.watch(
      roomAvailabilityProvider((
        isTemp: true,
        roomId: widget.room_id,
        bookId: bookId,
      )),
    );
    final bookingDateTimeState = ref.watch(bookingDateProvider);
    final bookingStateNotifier = ref.read(bookingDateProvider.notifier);
    print(bookingDateTimeState.tempTimeslots);

    return timeslots.when(
      data: (data) {
        final timeslotsByTimeZone = getListTimeZone(data);
        final morning = timeslotsByTimeZone["morning"] ?? [];
        final afternoon = timeslotsByTimeZone["afternoon"] ?? [];
        final evening = timeslotsByTimeZone["evening"] ?? [];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.white,
            title: Align(
              alignment: Alignment(-0.2, 0),
              child: Text(
                "Select Times",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                MyCalendar(),
                Text(
                  "Select Timeslots",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TimeslotsGrid(
                          timeslots: morning,
                          label: "Morning",
                          icon: Icons.wb_sunny,
                        ),

                        TimeslotsGrid(
                          timeslots: afternoon,
                          icon: Icons.sunny_snowing,
                          label: "Afternoon",
                        ),

                        TimeslotsGrid(
                          timeslots: evening,
                          icon: Icons.bedtime,
                          label: "Evening",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    "Selected Date & Time",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    "${convertDateFormat(bookingDateTimeState.tempSelectedDate!)}・${ref.read(bookingDateProvider.notifier).getStartEndTime(true)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isAvailable.when(
                              data: (data) {
                                setState(() {
                                  isSettable = false;
                                });
                                // shows text and icon based on the time slot availability
                                if (data == null) {
                                  return UnselectedText();
                                } else if (!data) {
                                  return UnavailableText();
                                } else {
                                  setState(() {
                                    isSettable = true;
                                  });
                                  return AvailableText();
                                }
                              },
                              error: (error, _) {
                                print("Error: $error");
                                return CircularProgressIndicator();
                              },
                              loading: () => CircularProgressIndicator(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15, top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (isSettable) {
                                  if (widget.selectedDetail == null) {
                                    bookingStateNotifier.setDateTimeslots();
                                    Navigator.of(context).pop();
                                  } else {
                                    bookingStateNotifier.modifyBookingTime(
                                      widget.selectedDetail!["bookId"] ?? "",
                                    );
                                    int count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ >= 2; // pops 2 pages
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Set Date & Time",
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isSettable ? Colors.black : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, _) {
        return Scaffold();
      },
      loading: () => Scaffold(backgroundColor: Colors.white),
    );
  }
}
