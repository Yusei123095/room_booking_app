import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

IconData convertStringToIcon(String? icon_desc){
  switch (icon_desc){
    case "Wifi":
      return Icons.wifi_outlined;
    case "Coffee":
      return Icons.coffee_outlined;
    case "Projector":
      return Icons.monitor_outlined;
    case "Refreshment":
      return Icons.accessibility_outlined;
    case "Whiteboard":
      return Icons.developer_board_outlined;
    default:
      return Icons.accessibility;

  }

}