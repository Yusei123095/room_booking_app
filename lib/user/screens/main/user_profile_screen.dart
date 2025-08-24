import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _sizeController = TextEditingController();
  TextEditingController _amenityController = TextEditingController();
  
  String _defineCapacity(int capacity){
    if(capacity > 0 && capacity < 7){
      return "Small (<=6)";
    }else if (capacity >= 7 && capacity < 13){
      return "Medium (7-12)";
    }else{
      return "Large (13+)";
    }
  }

  final CollectionReference rooms = FirebaseFirestore.instance.collection(
    "rooms",
  );

  List<String> _createNameOption(String value) {
    var name = value.toLowerCase();
    var times = <int>[];

    for (int i = name.length; i >= 1; i--) {
      times.add(i);
    }
    var nameList = <String>[];
    for (int time in times) {
      for (int i = name.length; i >= 0; i--) {

        if (i + time <= name.length) {

          final getName = name.substring(i, i + time);
          nameList.add(getName);
          name = value.toLowerCase();
        }
      }
    }
    return nameList;
  }

  Future<void> uploadRoom(String name, String size, String location) async {
    String fixedName = name.trim();
    List<String> nameList = _createNameOption(fixedName);

    await rooms.add({
      "room_name": name,
      "room_name_array": nameList,
      "room_size": 20,
      "room_location": "Floor 3",
      "room_desc": "hello",
      "room_amenities": ["Wifi", "Coffee", "Projector"],
      "room_capacity": _defineCapacity(11)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          TextField(controller: _nameController),

          SizedBox(height: 20),

          TextField(controller: _locationController),

          SizedBox(height: 20),

          TextField(controller: _sizeController),

          SizedBox(height: 20),

          TextField(controller: _amenityController),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              uploadRoom(_nameController.text, "size", "location");
            },
            child: Container(child: Text("Press")),
          ),
        ],
      ),
    );
  }
}
