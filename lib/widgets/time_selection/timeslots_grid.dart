import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/widgets/time_selection/time_selection_button.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class TimeslotsGrid extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> timeslots;
  final IconData icon;
  final String label;
  const TimeslotsGrid({super.key, required this.timeslots, required this.icon, required this.label});

  @override
  ConsumerState<TimeslotsGrid> createState() => _TimeslotsGridState();
}

class _TimeslotsGridState extends ConsumerState<TimeslotsGrid> {



  @override
  Widget build(BuildContext context) {
    final selectedTimeslots = ref.watch(bookingDateProvider).tempTimeslots;
    final bookingDateNotifier = ref.read(bookingDateProvider.notifier);

    return Column(
      children: [

        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(widget.icon, color: Colors.black45, size: 22,),
            SizedBox(width: 7,),
            Text(widget.label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black45),)
          ],
        ),),

        GridView.builder(
          itemCount: widget.timeslots.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            Map<String, dynamic> timeslot = widget.timeslots[index];
            print(timeslot);
            final isChecked = selectedTimeslots.contains(timeslot);

            return TimeSelectionSimpleButton(
                label: timeslot['start'],
                isBooked: timeslot['isAvailable']!,
              isChecked: isChecked,
              onTap: () {

                  bookingDateNotifier.updateTempTimeslots(timeslot, !isChecked);


              }
              );
          },
        ),
      ],
    );
  }
}
