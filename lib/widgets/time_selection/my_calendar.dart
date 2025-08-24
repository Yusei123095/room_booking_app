import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends ConsumerWidget {
  const MyCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime today = DateTime.now();
    DateTime _lastDay = today.add(Duration(days: 180));
    final bookingDateState = ref.watch(bookingDateProvider);
    final bookingDateNotifier = ref.read(bookingDateProvider.notifier);


    return TableCalendar(
      focusedDay: bookingDateState.tempFocusedDate!,
      firstDay: today,
      lastDay: _lastDay,
      selectedDayPredicate: (day) {

        return isSameDay(bookingDateState.tempSelectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay){
        bookingDateNotifier.setTempSelectedDate(selectedDay);
      },
      onPageChanged: (focusedDay) {
        bookingDateNotifier.setTempFocusedDate(focusedDay);
      },
      calendarStyle: CalendarStyle(

        disabledTextStyle: TextStyle(color: Color(0xFFAEAEAE), fontSize: 18, fontWeight: FontWeight.w500),
        outsideTextStyle: TextStyle(color: Color(0xFFAEAEAE), fontSize: 18, fontWeight: FontWeight.w500),
        defaultTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        weekendTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        selectedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        selectedDecoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        todayTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
         // Make "today" not appear selected if needed
        ),
      ),
    );
  }
}
