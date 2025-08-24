import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableDisplay extends StatelessWidget {
  const AvailableDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "Available",
        style: TextStyle(
          color: Colors.green[800],
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}

class UnAvailableDisplay extends StatelessWidget {
  const UnAvailableDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "Unavailable",
        style: TextStyle(
          color: Colors.red[800],
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}

class UnselectedTimeDisplay extends StatelessWidget {
  const UnselectedTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "Unselected",
        style: TextStyle(
          color: Colors.yellow[800],
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}

class AvailableText extends StatelessWidget {
  const AvailableText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_calendar_rounded,
          size: 25,
          color: Colors.greenAccent[700],
        ),
        SizedBox(width: 5),
        Text(
          "Available",
          style: TextStyle(
            color: Colors.greenAccent[700],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class UnavailableText extends StatelessWidget {
  const UnavailableText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_calendar_rounded,
          size: 25,
          color: Colors.red[600],
        ),
        SizedBox(width: 5),
        Text(
          "Unavailable",
          style: TextStyle(
            color: Colors.red[600],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class UnselectedText extends StatelessWidget {
  const UnselectedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_calendar_rounded,
          size: 25,
          color: Colors.yellow[800],
        ),
        SizedBox(width: 5),
        Text(
          "Unselected",
          style: TextStyle(
            color: Colors.yellow[800],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}




class WaitingAvailabilityDisplay extends StatelessWidget {
  const WaitingAvailabilityDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(15),
      ),
    );;
  }
}





