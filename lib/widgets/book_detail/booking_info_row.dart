import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingInfoRow extends StatelessWidget {
  final Widget leadingWidget;
  final String label;
  final String content;
  final String? subContent;

  const BookingInfoRow({
    super.key,
    required this.leadingWidget,
    required this.label,
    required this.content,
    this.subContent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      leadingWidget,
      SizedBox(width: 30,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),),
          Text(content, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          if(subContent != null) Text(subContent!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),)
        ],
      )
    ]);
  }
}
