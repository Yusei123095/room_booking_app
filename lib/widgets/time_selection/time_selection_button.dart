import 'package:flutter/material.dart';

class TimeSelectionSimpleButton extends StatefulWidget {
  final String label;
  //final bool isPassed;
  final bool isBooked;
  final bool isChecked;
  final Function onTap;

  const TimeSelectionSimpleButton({
    super.key,
    required this.label,
    //required this.isPassed,
    required this.isBooked,
    required this.isChecked,
    required this.onTap,
  });

  @override
  State<TimeSelectionSimpleButton> createState() => _TimeSelectionButtonState();
}

class _TimeSelectionButtonState extends State<TimeSelectionSimpleButton> {
  Color? setButtonColor() {
    if (widget.isBooked) {
      return Colors.red[100];
    } else if (widget.isChecked) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color? setTextColor() {
     if (widget.isBooked) {
      return Colors.red[600];
    } else if (widget.isChecked) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: setButtonColor(),
        side: BorderSide(
          color: Colors.black12
        ),
        elevation: 0
      ),
      onPressed: () {
        setState(() {
            widget.onTap();
        });
      },
      child: Center(
        child: Text(
          widget.label,
          style: TextStyle(
            color: setTextColor(),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class TimeSelectionWideButton extends StatelessWidget {
  final String timeDuration;
  final String timeslotStatus;
  final bool isAvailable;
  final Function onTap;

  const TimeSelectionWideButton({
    super.key,
    required this.timeDuration,
    required this.timeslotStatus,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (isAvailable) {
            onTap();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              timeDuration,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(timeslotStatus,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
