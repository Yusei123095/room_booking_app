import 'package:flutter/material.dart';

class FilterSelection extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function(String) onPress;
  final List<String> items;

  const FilterSelection({
    super.key,
    required this.label,
    required this.icon,
    required this.onPress,
    required this.items
  });

  @override
  State<FilterSelection> createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {


  // late String selectedItem;
  // @override
  // void initState(){
  //   super.initState();
  //   selectedItem = widget.label;
  // }
  @override
  Widget build(BuildContext context) {

    return DropdownButtonHideUnderline(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        isExpanded: true,
        value: widget.label,
        items: widget.items.map((value){
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(), onChanged: (newValue){

        if(newValue != null){
          widget.onPress(newValue);
        }
      },
        selectedItemBuilder: (BuildContext context){
        return widget.items.map((String item){
          return Row(


            children: [
          Expanded(child: Align(
          alignment: Alignment.centerLeft,
            child: Icon(widget.icon, size: 25, color: Colors.black45,),
          )),

          Expanded(
          child: Text(widget.label, style: TextStyle(fontSize: 18)),
          ),
            ]);
        }).toList();
      },
      ),
    ));

  }
}
