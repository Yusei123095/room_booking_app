import 'package:flutter/material.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class ComingBookCard extends StatelessWidget {
  final Map<String, dynamic> room;
  final Map<String, dynamic> book;
  final bool isSelected;
  const ComingBookCard({super.key, required this.room, required this.book, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  child: Image.asset(
                    "assets/images/modern-equipped-computer-lab.jpg",
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),

                  borderRadius: BorderRadius.circular(15),
                ),
                SizedBox(width: 8),
                Text(
                  room['room_name'] ?? "No data",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  size: 30,
                  color: Colors.black54,
                ),
                SizedBox(width: 10),
                Text(
                  "${convertDateFormat(book["date"]!.toDate() ?? DateTime.now())} : ${book['duration']}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 30,
                  color: Colors.black54,
                ),
                SizedBox(width: 10),
                Text(
                  "Floor3, West part",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
