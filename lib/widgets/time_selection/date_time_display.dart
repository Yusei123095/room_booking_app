import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeColumnDisplay extends StatelessWidget {
  final String date;
  final String time;
  final Widget? availabilityDisplay;
  const DateTimeColumnDisplay({super.key, required this.date, required this.time, this.availabilityDisplay});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 30,
              color: Colors.black45,
            ),
            SizedBox(width: 10),
            Text(
              "Date: $date",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.black45,
                    size: 30,
                  ),
                  SizedBox(width: 10),

                  Text(
                    "Time: $time",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            availabilityDisplay ?? SizedBox(),
          ],
        ),
      ],
    );
  }
}
