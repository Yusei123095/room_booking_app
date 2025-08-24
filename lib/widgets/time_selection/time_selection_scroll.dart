// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:room_booking_app/user/controller/booking_date_controller.dart';
// import 'package:room_booking_app/widgets/time_selection/time_selection_button.dart';
// import 'package:room_booking_app/widgets/time_selection/time_utils.dart';
//
// class TimeSelectionScroll extends ConsumerStatefulWidget {
//   final String room_id;
//   const TimeSelectionScroll({super.key, required this.room_id});
//
//   @override
//   ConsumerState<TimeSelectionScroll> createState() => _TimeSelectionScrollState();
// }
//
// class _TimeSelectionScrollState extends ConsumerState<TimeSelectionScroll> {
//
//   late Future<QuerySnapshot<Map<String, dynamic>>> _future;
//   late Future<QuerySnapshot<Map<String, dynamic>>> _bookings;
//
//   @override
//   void initState(){
//     super.initState();
//     final selectedDate = DateFormat('yyyy-MM-dd').format(ref.read(bookingDateProvider).selectedDate!);
//     _future = FirebaseFirestore.instance.collection("timeslots").orderBy("number").get();
//     _bookings = FirebaseFirestore.instance.collection("books").where("room", isEqualTo: widget.room_id).where("date", isEqualTo: selectedDate).get();
//
//   }
//
//   Future<List<Map<String, dynamic>>> setRoomStatus() async{
//     final selectedDate = DateFormat('yyyy-MM-dd').format(ref.read(bookingDateProvider).selectedDate!);
//     QuerySnapshot<Map<String, dynamic>> timeslots = await FirebaseFirestore.instance.collection("timeslots").orderBy("number").get();
//     QuerySnapshot<Map<String, dynamic>> booking = await FirebaseFirestore.instance.collection("books").where("room", isEqualTo: widget.room_id).where("date", isEqualTo: selectedDate).get();
//
//     List<Map<String, dynamic>> timeslotsList = [];
//     for(var doc in timeslots.docs){
//       Map<String, dynamic> map = doc.data();
//
//       map['isAvailable'] = (checkPassedTime(ref.watch(bookingDateProvider).selectedDate!, map['start_hour'], map['start_min']));
//       print(map['isAvailable']);
//       timeslotsList.add(map);
//
//
//     }
//
//
//
//     List<int> bookedTimeslots = [];
//     for(var doc in booking.docs){
//       Map<String, dynamic> map = doc.data();
//       bookedTimeslots.addAll(List<int>.from(map['timeslots']));
//     }
//     print("object");
//
//     for(var bookedSlot in bookedTimeslots){
//       timeslotsList[bookedSlot-1]['isAvailable'] = false;
//     }
//
//
//     return timeslotsList;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final bookingDateNotifier = ref.read(bookingDateProvider.notifier);
//     final bookingDateTimeState = ref.watch(bookingDateProvider);
//     return FutureBuilder(future: setRoomStatus(), builder: (context, snapshot){
//       if(snapshot.connectionState == ConnectionState.waiting){
//         return CircularProgressIndicator();
//       }
//
//       if(snapshot.hasError || !snapshot.hasData){
//         return Text("No data");
//       }
//
//       final data = snapshot.data!;
//       return Container(
//           height: size.height*0.4,
//           child: SingleChildScrollView(
//         child: Column(
//           children: List.generate(data.length, (index){
//             final timeslot = data[index];
//             bool isChecked = !bookingDateTimeState.timeslots.contains(data[index]['number']);
//             return TimeSelectionWideButton(
//                 timeDuration: "${timeslot['start']} - ${timeslot['end']}",
//                 timeslotStatus: "Available",
//                 isAvailable: isChecked,
//                 onTap: (){
//                   bookingDateNotifier.setTimeslots(timeslot['number'], isChecked);
//
//
//                 });
//           }),
//         ),
//       ));
//
//
//     });
//   }
// }
