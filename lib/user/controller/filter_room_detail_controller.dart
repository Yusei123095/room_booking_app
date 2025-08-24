import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:room_booking_app/user/models/filter_room_detail_model.dart';


final roomsStreamProvider = StreamProvider((ref){
  final filter = ref.watch(filterRoomDetailProvider);
  final filterNotifier = ref.read(filterRoomDetailProvider.notifier);

  Query<Map<String, dynamic>> rooms = FirebaseFirestore.instance.collection("rooms");


    if (filter.nameFilter != ""){
      rooms = rooms.where("room_name_array", arrayContains: filter.nameFilter);
    }

    if(filter.locationFilter != ""){
      rooms = rooms.where("room_location", isEqualTo: filter.locationFilter);
    }

    if(filter.capacityFilter != ""){
      rooms = rooms.where("room_capacity", isEqualTo: filter.capacityFilter);
    }

    if(filter.amenitiesFilter.isNotEmpty){
      filter.amenitiesFilter.forEach((amenity){
        rooms = rooms.where("room_amenities", arrayContains: amenity);
      });
    }

  return rooms.snapshots();

});

final filterRoomDetailProvider = StateNotifierProvider<FilterRoomDetailNotifier,FilterRoomDetailState>((ref){
  return FilterRoomDetailNotifier();
});

class FilterRoomDetailNotifier extends StateNotifier<FilterRoomDetailState>{
  FilterRoomDetailNotifier() : super(
    FilterRoomDetailState()
  ){}

  void setNameFilter(String nameFilter) {
    state = state.copyWith(nameFilter: nameFilter);
  }


  void setCapacityFilter(String capacityFilter){
    state = state.copyWith(capacityFilter: capacityFilter);
  }

  void setLocationFilter(String locationFilter){
    state = state.copyWith(locationFilter: locationFilter);
  }

  void setAmenitiesFilter(List<String> amenitiesFilter){
    state = state.copyWith(amenitiesFilter: amenitiesFilter);

  }

}