import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/user/controller/room_availability_controller.dart';
import 'package:room_booking_app/widgets/room_detail/availability_display.dart';

class CuratedItem extends StatelessWidget {
  final Map<String, dynamic> room_info;
  final Widget? availabilityDisplay;

  const CuratedItem({super.key, required this.room_info, this.availabilityDisplay});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      //padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),

      width: size.width * 0.9,
      child: Wrap(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image(
                  image: AssetImage(
                    "assets/images/modern-equipped-computer-lab.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
                width: size.width * 0.9,
                height: size.height * 0.16,
              ),

              if(availabilityDisplay != null)
                Positioned(
                  right: 5,
                  top: 5,
                  child: availabilityDisplay!
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room_info['room_name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                ),

                SizedBox(height: 7),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 25,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 3),
                        Text(
                          room_info['room_capacity'].toString(),
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 25,
                          color: Colors.black54,
                        ),
                        Text(
                          "${room_info['room_location']}",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    room_info['room_amenities'] != null
                        ? room_info['room_amenities'].length <= 3
                            ? room_info['room_amenities'].length
                            : 4
                        : 0,
                    (index) => Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 5,
                        ),
                        child: Text(
                          index <= 2
                              ? room_info['room_amenities'][index]
                              : "+${room_info['room_amenities'].length - 3} ",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CuratedItemDemo extends StatelessWidget {
  const CuratedItemDemo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            width: size.width * 0.9,
            height: size.height * 0.16,
          ),

          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black12),
                  height: 20,
                  width: size.width * 0.3,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 20,
                      width: size.width * 0.25,
                    ),
                    SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 20,
                      width: size.width * 0.25,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 20,
                      width: size.width * 0.15,
                    ),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 20,
                      width: size.width * 0.15,
                    ),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      height: 20,
                      width: size.width * 0.15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
