import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProhibitionList extends StatelessWidget {
  final List<String> prohibitions;
  const ProhibitionList({super.key, required this.prohibitions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!)
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children:
          [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: 5),
                Text(
                  "Strictly Prohibited",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ...List.generate(prohibitions.length, (index) => Padding(padding: EdgeInsets.only(top: 8), child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.dangerous,
                  color: Colors.redAccent,

                  size: 30,
                ),
                SizedBox(width: 5),
                Text(
                  prohibitions[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),))
            ,
          ],
        ),
      ),
    );
  }
}
