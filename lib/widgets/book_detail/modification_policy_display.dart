import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/utils/time_utils.dart';

class ModificationPolicyDisplay extends StatelessWidget {
  final bool overDue;
  final DateTime due;
  const ModificationPolicyDisplay({super.key, required this.overDue, required this.due});

  @override
  Widget build(BuildContext context) {
    DateTime beforeDue = due.subtract(Duration(minutes: 1));
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modification Policy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    color: overDue ? Colors.grey[300] : Colors.green,
                  ),
                ),
                SizedBox(width: 15),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      Text(
                        "Modification & Cancellation free",
                        style: TextStyle(
                          fontSize: 18,
                          color: overDue  ? Colors.black : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("Until ${convertDateTimeFormat(beforeDue)}", style: TextStyle(color: Colors.grey, fontSize: 16),)
                    ],
                  ),
              ],
            ),
            SizedBox(height: 1,),
            

            Row(

              children: [
                Container(
                  width: 10,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: overDue ? Colors.red : Colors.grey[200],
                  ),
                ),
                SizedBox(width: 15),

               Expanded(child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No modification or cancellations allowed",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 18,
                              color: overDue ? Colors.red: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("Since ${convertDateTimeFormat(due)}", style: TextStyle(color: Colors.grey, fontSize: 16),)
                        ],
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
