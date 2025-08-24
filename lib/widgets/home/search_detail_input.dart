import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/user/controller/filter_room_detail_controller.dart';
import 'package:room_booking_app/user/controller/home_screen_controller.dart';
import 'package:room_booking_app/user/screens/main/filter/select_timeslots_screen.dart';
import 'package:room_booking_app/widgets/time_selection/my_button.dart';

class SearchDetailInput extends ConsumerWidget {
  final Function onSearch;

  const SearchDetailInput({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    final bookingDateTimeState = ref.watch(bookingDateProvider);
    final bookingDateTimeNotifier = ref.read(bookingDateProvider.notifier);
    return Container(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[100],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search Rooms...",
                hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
                isCollapsed: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close),
                ),
                prefixIcon: Icon(Icons.calendar_month, color: Colors.black45),
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
                  detail: bookingDateTimeNotifier.getStartEndTime(false),
                  icon: Icons.access_time_filled,

                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ref
                    .read(filterRoomDetailProvider.notifier)
                    .setNameFilter(controller.text);
                ref
                    .read(navigationScreenProvider.notifier)
                    .update((state) => state = 1);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search a Room",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 23),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
