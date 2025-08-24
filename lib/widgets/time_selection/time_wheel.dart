import 'package:flutter/material.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class MyTime extends StatelessWidget {
  final String label;
  final int index;
  final TimeOfDay currentSelectedItem;
  final Function(TimeOfDay) onChanged;


  const MyTime({
    super.key,
    required this.label,
    required this.index,
    required this.currentSelectedItem,
    required this.onChanged,

  });

  TimeOfDay processIndexToTime(int index) {
    if (index % 2 == 0) {
      return TimeOfDay(
        hour: (index / 2).toInt(),
        minute: 0,
      ); //"${(index / 2).toInt()}:00";
    } else {
      return TimeOfDay(
        hour: (index / 2).toInt(),
        minute: 30,
      ); //"${(index / 2).toInt()}:30";
    }
  }

  int convertTimeToIndex(TimeOfDay time) {
    return time.minute == 30 ? 2 * time.hour + 1 : 2 * time.hour;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 18)),
          Container(
            height: 120,
            width: 100,
            child: ListWheelScrollView.useDelegate(
              controller: FixedExtentScrollController(initialItem: convertTimeToIndex(currentSelectedItem)),
              diameterRatio: 1.5,
              itemExtent: 40,
              magnification: 1.2,
              useMagnifier: true,
              onSelectedItemChanged: (value) {
                onChanged(processIndexToTime(value));
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 48,
                builder: (context, index) {
                  return Container(
                    child: Text(formatTimeOfDay(processIndexToTime(index))),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
