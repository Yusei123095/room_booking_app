import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentBookingDisplay extends StatelessWidget {
  final Map<String, dynamic> room;
  const RecentBookingDisplay({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      decoration: BoxDecoration(
        
      ),

      width: size.width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
      child: Image.asset(
      "assets/images/modern-equipped-computer-lab.jpg",
        fit: BoxFit.cover,
        width: double.infinity,
        height: size.width*0.35,
      ),),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(room['room_name'] ?? "No Name", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),))
      ],
    ),);
  }
}
