import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class BookingDisplay extends StatelessWidget {
  final Map<String, dynamic> room;
  final Map<String, dynamic> book;
  final String bookId;

  const BookingDisplay({
    super.key,
    required this.room,
    required this.book,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  room['room_location'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Booking ID: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.copy, size: 25, color: Colors.black,),
                  SizedBox(width: 5,),
                  Text(
                    bookId,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
