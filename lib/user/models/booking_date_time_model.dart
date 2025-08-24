import 'package:flutter/material.dart';

class BookingDateTimeState {
  final DateTime? tempFocusedDate;
  final DateTime? tempSelectedDate;
  final DateTime? selectedDate;
  final List<Map<String, dynamic>> tempTimeslots;
  final List<Map<String, dynamic>> timeslots;
  final Map<int, List<dynamic>?> timeslotDetails;

  BookingDateTimeState({
    this.tempFocusedDate,
    this.tempSelectedDate,
    this.selectedDate,
    List<Map<String, dynamic>>? tempTimeslots,
    List<Map<String, dynamic>>? timeslots,
    Map<int, List<dynamic>?>? timeslotDetails
  }) : tempTimeslots = tempTimeslots ?? [], timeslots = timeslots ?? [], timeslotDetails = timeslotDetails ?? {};

  BookingDateTimeState copyWith({
    DateTime? tempFocusedDate,
    DateTime? tempSelectedDate,
    Map<String, dynamic>? timeslot,
    bool? add,
    bool? resetTimeslots,
    bool? setTempTimeslot,
    bool? updateDateTime,
    Map<int, List<dynamic>?>? timeslotDetails
  }) {



    List<Map<String, dynamic>> updatedSlots = List<Map<String, dynamic>>.from(tempTimeslots);
    //Map<int, List<String>?>? updatedTimeslotDetails = Map<int, List<String>?>.from(timeslotDetails);

    if (add == true && timeslot != null) {
      if(tempTimeslots.isEmpty){
        updatedSlots = [timeslot];
        //updatedTimeslotDetails[timeslot] = timeslotDetail;
      }else{
        if(tempTimeslots.length >= 1 && (timeslot['number'] == tempTimeslots[0]['number'] - 1 || timeslot['number'] == tempTimeslots[tempTimeslots.length -1]['number'] + 1)) {
          updatedSlots.add(timeslot);
          //updatedTimeslotDetails[timeslot] = timeslotDetail;
        }else{
          updatedSlots = [timeslot];
        }
      }
    }

    if(add == false){
      int index = updatedSlots.indexOf(timeslot!);

      // if eliminated item is an only item of the list -> empty list
      if(updatedSlots.length <= 1){
        updatedSlots = [];
        //updatedTimeslotDetails.remove(timeslot);

        // if eliminated element is side of the list -> remove only the item
      }else if(index == 0 || index == tempTimeslots.length - 1){
        updatedSlots.remove(timeslot);
        //updatedTimeslotDetails.remove(timeslot);

        // eliminated item is at non-side index -> remove all items from the item index to nearest side
      }else if(tempTimeslots.length > 2 && index > 0 && index < tempTimeslots.length -1){
        if(tempTimeslots.length /2 < index + 1){
          // for(int i = 0; i <= index ; i++){
          //   updatedTimeslotDetails.remove(tempTimeslots[tempTimeslots.length - 1 - i]);
          // }
          updatedSlots.removeRange(index, tempTimeslots.length);
        }else {
          updatedSlots.removeRange(0, index+1);
          // for(int i = 0; i <= index; i++){
          //   updatedTimeslotDetails.remove(tempTimeslots[i]);
          // }
        }
      }
    }
    if(resetTimeslots == true){
      updatedSlots = [];
    }

    if(setTempTimeslot == true){
      updatedSlots = this.timeslots;
    }
    updatedSlots.sort((a, b) => a['number'].compareTo(b['number']));

    return BookingDateTimeState(
      tempFocusedDate: tempFocusedDate ?? this.tempFocusedDate,
      tempSelectedDate: tempSelectedDate ?? this.tempSelectedDate,
      selectedDate: updateDateTime != null && updateDateTime ? this.tempSelectedDate : this.selectedDate,
      tempTimeslots: updatedSlots,
      timeslots: updateDateTime != null && updateDateTime ? this.tempTimeslots : this.timeslots ,
      timeslotDetails: timeslotDetails ?? this.timeslotDetails
    );
  }

}
