import 'package:flutter/material.dart';

class BookingDateTimeState {
  final DateTime? tempFocusedDate;
  final DateTime? tempSelectedDate;
  final DateTime? selectedDate;
  final List<int> tempTimeslots;
  final List<int> timeslots;
  final Map<int, Map<String, dynamic>?> timeslotDetails;

  BookingDateTimeState({
    this.tempFocusedDate,
    this.tempSelectedDate,
    this.selectedDate,
    List<int>? tempTimeslots,
    List<int>? timeslots,
    Map<int, Map<String, dynamic>?>? timeslotDetails
  }) : tempTimeslots = tempTimeslots ?? [],
        timeslots = timeslots ?? [],
        timeslotDetails = timeslotDetails ?? {};

  BookingDateTimeState copyWith({
    DateTime? tempFocusedDate,
    DateTime? tempSelectedDate,
    int? timeslot,
    bool? add,
    bool? resetTimeslots,
    List<int>? initialTempTimeslots,
    bool? updateDateTime,
    Map<int, Map<String, dynamic>?>? timeslotDetails
  }) {

    List<int> updatedSlots = List<int>.from(tempTimeslots);

    if (add == true && timeslot != null) {
      if(tempTimeslots.isEmpty){
        updatedSlots = [timeslot];

      }else{
        if(tempTimeslots.isNotEmpty && (timeslot == tempTimeslots[0] - 1 || timeslot == tempTimeslots[tempTimeslots.length -1] + 1)) {
          updatedSlots.add(timeslot);

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


        // if eliminated element is side of the list -> remove only the item
      }else if(index == 0 || index == tempTimeslots.length - 1){
        updatedSlots.remove(timeslot);


        // eliminated item is at non-side index -> remove all items from the item index to nearest side
      }else if(tempTimeslots.length > 2 && index > 0 && index < tempTimeslots.length -1){
        if(tempTimeslots.length /2 < index + 1){

          updatedSlots.removeRange(index, tempTimeslots.length);
        }else {
          updatedSlots.removeRange(0, index+1);

        }
      }
    }
    if(resetTimeslots == true){
      updatedSlots = [];
    }

    if(initialTempTimeslots != null){
      updatedSlots = initialTempTimeslots;
    }
    updatedSlots.sort();

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
