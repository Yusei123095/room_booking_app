import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmenityCheckBox extends StatefulWidget {
  final String label;
  final bool isChecked;
  final Function(bool) onClick;
  const AmenityCheckBox({super.key, required this.label, required this.isChecked, required this.onClick});

  @override
  State<AmenityCheckBox> createState() => _AmenityCheckBoxState();
}

class _AmenityCheckBoxState extends State<AmenityCheckBox> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(value: widget.isChecked, onChanged: (value){
            if(value != null){
              widget.onClick(value);
            }
          }),
          Text(widget.label, style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}
