import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/user/controller/filter_room_detail_controller.dart';
import 'package:room_booking_app/user/controller/room_availability_controller.dart';
import 'package:room_booking_app/user/screens/main/filter/filter_search_screen.dart';
import 'package:room_booking_app/user/screens/main/filter/select_timeslots_screen.dart';
import 'package:room_booking_app/user/screens/main/room_detail/room_detail_screen.dart';
import 'package:room_booking_app/widgets/room_detail/availability_display.dart';
import 'package:room_booking_app/widgets/room_detail/curated_item.dart';
import 'package:room_booking_app/widgets/time_selection/my_button.dart';

class UserBookingScreen extends ConsumerStatefulWidget {
  const UserBookingScreen({super.key});

  @override
  ConsumerState<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends ConsumerState<UserBookingScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookingDateTimeState = ref.watch(bookingDateProvider);
    final startEndTime = ref
        .watch(bookingDateProvider.notifier)
        .getStartEndTime(false);

    final roomFilterNotifier = ref.read(filterRoomDetailProvider.notifier);
    final filteredRooms = ref.watch(roomsStreamProvider);

    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Row(
          children: [
          Text("Room Booking", style: TextStyle(fontSize: 23)),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Find your perfect space",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        SizedBox(height: 5),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,

            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          width: size.width * 0.9,
          child: TextField(
            onChanged: (value) {
              roomFilterNotifier.setNameFilter(value.toLowerCase());
            },
            controller: searchController,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              isCollapsed: true,
              hintText: "Search Rooms...",
              hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
              border: InputBorder.none,

              prefixIcon: Icon(Icons.search_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FilterSearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.filter_alt),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MyButton(
                label: "Date",
                detail: DateFormat(
                  "yyyy-MM-dd",
                ).format(bookingDateTimeState.selectedDate!),
                icon: Icons.calendar_today_rounded,

                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SelectTimeslotsScreen(),
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 15),
            Expanded(
              child: MyButton(
                label: "Time",
                detail: startEndTime,
                icon: Icons.access_time_filled,

                onTap: () {},
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Divider(),
        ),

        Expanded(
          child: filteredRooms.when(
            data:
                (data) =>
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(
                      data.docs.length,
                          (index) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                        RoomDetail(
                                          room: data.docs[index],
                                        ),
                                  ),
                                );
                              },

                              onLongPress: () {},
                              child: CuratedItem(
                                room_info: data.docs[index].data(),
                                availabilityDisplay: ref.watch(
                                  roomAvailabilityProvider(
                                      (isTemp: false, roomId: data.docs[index]
                                          .id)))
                                      .when(
                                    data: (data) {
                                      if (data == null) {
                                        return UnselectedTimeDisplay();
                                      } else if (data) {
                                        return AvailableDisplay();
                                      } else {
                                        return UnAvailableDisplay();
                                      }
                                    },
                                    error:
                                        (error, _) =>
                                        CircularProgressIndicator(),
                                    loading:
                                        () => WaitingAvailabilityDisplay(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ),
                  ),
                  error: (error, _) => Text(error.toString()),
                  loading:
                      () =>
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                ),
          ),
          ],
        ),
      ),
    ),);
  }
}
