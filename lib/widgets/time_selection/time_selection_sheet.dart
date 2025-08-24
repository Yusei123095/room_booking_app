// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:room_booking_app/user/controller/booking_date_controller.dart';
// import 'package:room_booking_app/widgets/time_selection/time_wheel.dart';
//
// class TimeSelectionSheet extends ConsumerWidget {
//   const TimeSelectionSheet({super.key});
//
//
//   bool checkTimeValidation(TimeOfDay start, TimeOfDay end){
//     int startAmount = start.hour * 60 + start.minute;
//     int endAmount = end.hour * 60 + end.minute;
//     return startAmount < endAmount;
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     TimeOfDay _temporaryStartTime = ref.watch(startTimeProvider);
//     TimeOfDay _temporaryEndTime = ref.watch(endTimeProvider);
//
//     return AlertDialog(
//       elevation: 8,
//       backgroundColor: Colors.white,
//       content: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Wrap(
//           spacing: 30,
//
//           children: [
//             MyTime(
//               label: "Start Time",
//               index: 48,
//               currentSelectedItem: ref.watch(startTimeProvider),
//               onChanged: (time) {
//                 _temporaryStartTime = time;
//               },
//
//             ),
//
//             MyTime(
//               label: "End Time",
//               index: 48,
//               currentSelectedItem: ref.watch(endTimeProvider),
//               onChanged: (time) {
//                 _temporaryEndTime = time;
//               },
//
//             ),
//
//             Align(
//               alignment: Alignment.centerRight,
//               child: InkWell(
//                 onTap: (){
//                   if(checkTimeValidation(_temporaryStartTime, _temporaryEndTime)){
//                     ref
//                         .read(startTimeProvider.notifier)
//                         .state =
//                         _temporaryStartTime;
//                     ref
//                         .read(endTimeProvider.notifier)
//                         .state =
//                         _temporaryEndTime;
//                     Navigator.of(context).pop();
//                   }else{
//                     // inform the time is invalid
//                   }
//                 },
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//
//                 ),
//                 child: Text(
//                   "Confirm",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),)
//           ],
//         ),
//       ),
//     );
//   }
// }
