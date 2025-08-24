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

  const SelectTimeslotsScreen({super.key, this.room_id});

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
      bookingDateTimeNotifier.setTempFocusedDate(
        bookingDateTimeState.selectedDate!,
      );
      bookingDateTimeNotifier.setTempSelectedDate(
        bookingDateTimeState.selectedDate!,
      );

      bookingDateTimeNotifier.setTempTimeslots();
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
    return {"morning": morning, "afternoon": afternoon, "evening" :evening};
  }

  bool isSettable = false;

  @override
  Widget build(BuildContext context) {
    final timeslots = ref.watch(timeslotsProvider(widget.room_id));
    final isAvailable = ref.watch(
      roomAvailabilityProvider((isTemp: true, roomId: widget.room_id)),
    );
    final bookingDateTimeState = ref.watch(bookingDateProvider);
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
                                  print("Hellp");
                                  return UnselectedText();
                                } else if (!data) {
                                  print("object");
                                  return UnavailableText();
                                } else {
                                  print("No");
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
                                if(isSettable){
                                  ref
                                      .read(bookingDateProvider.notifier)
                                      .setDateTimeslots();
                                  Navigator.of(context).pop();
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
        print(error);
        return Scaffold();},
      loading: () => Scaffold(backgroundColor: Colors.white),
    );
  }
}
