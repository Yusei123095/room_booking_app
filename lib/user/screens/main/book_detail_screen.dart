import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_booking_app/utils/icon_util.dart';
import 'package:room_booking_app/widgets/book_detail/booking_info_row.dart';
import 'package:room_booking_app/widgets/book_detail/modification_policy_display.dart';
import 'package:room_booking_app/widgets/room_detail/prohibition_list.dart';
import 'package:room_booking_app/widgets/time_selection/date_time_display.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> room;
  final Map<String, dynamic> bookInfo;
  final String bookId;

  const BookDetailScreen({
    super.key,
    required this.bookInfo,
    required this.bookId,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    DateTime due = bookInfo['date'].toDate().subtract(Duration(hours: 3));
    print(due);
    bool isOverDue = due.difference(DateTime.now()).isNegative;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Booking Content Detail"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        "Booking Information",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      BookingInfoRow(
                        leadingWidget: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[100]!.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              "#",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        label: "Booking ID",
                        content: bookId,
                      ),

                      SizedBox(height: 20),
                      BookingInfoRow(
                        leadingWidget: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[200]!.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.calendar_today,
                              size: 28,
                              color: Colors.amber[700],
                            ),
                          ),
                        ),
                        label: "Date & Time",
                        content: convertDateFormat(bookInfo['date'].toDate()),
                        subContent: bookInfo['duration'] ?? "No Data",
                      ),

                      SizedBox(height: 20),
                      BookingInfoRow(
                        leadingWidget: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple[100]!.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        label: "Guest Name",
                        content: "Yusei Kinoshita",
                      ),
                      SizedBox(height: 20),

                      BookingInfoRow(
                        leadingWidget: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green[100]!.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.people,
                              size: 28,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        label: "Capacity Size",
                        content: room['room_capacity'] ?? "No Data",
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room Detail",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/modern-equipped-computer-lab.jpg",
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  room['room_name'] ?? "No Data",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 25,
                                      color: Colors.grey[400],
                                    ),

                                    Text(
                                      room['room_location'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          room['room_amenities'].length,

                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 5,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  convertStringToIcon(
                                    room['room_amenities'][index],
                                  ),
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                Text(
                                  room['room_amenities'][index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8),

              Divider(),

              Text(
                "Important Restrictions",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              ProhibitionList(
                prohibitions: List<String>.from(room['prohibitions']),
              ),
              SizedBox(height: 10),

              ModificationPolicyDisplay(overDue: isOverDue, due: due),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_calendar_rounded,
                            size: 30,
                            color: Colors.blue[700],
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Modify",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red[100]!.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.close, size: 30, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Modify",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
