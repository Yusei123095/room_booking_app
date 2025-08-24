import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final VoidCallback onTap;

  const MyButton({
    super.key,
    required this.label,
    required this.icon,
    required this.detail,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){onTap();},
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                Icon(icon, size: 17,),
                SizedBox(width: 3,),
                Text(label, style: TextStyle(fontSize: 17, color: Colors.black54),)
              ],
            ),
            Text(detail, style: TextStyle(color: Colors.black, fontSize: 18),)
          ],
        ),
      ),
    );
  }
}


