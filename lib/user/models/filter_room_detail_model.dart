import 'package:cloud_firestore/cloud_firestore.dart';

class FilterRoomDetailState{
  final String nameFilter;
  final String capacityFilter;
  final String locationFilter;
  final List<String> amenitiesFilter;
  final bool isFiltered;

  FilterRoomDetailState({
    this.nameFilter = "",
    this.capacityFilter = "",
    this.locationFilter = "",
    List<String>? amenitiesFilter,
    this.isFiltered = false,
  }) : amenitiesFilter = amenitiesFilter ?? [];

  FilterRoomDetailState copyWith({
    String? nameFilter,
    String? capacityFilter,
    String? locationFilter,
    List<String>? amenitiesFilter,
    bool? isFiltered,

  }){
    return FilterRoomDetailState(
      nameFilter: nameFilter ?? this.nameFilter,
      capacityFilter: capacityFilter ?? this.capacityFilter,
      locationFilter: locationFilter ?? this.locationFilter,
      amenitiesFilter: amenitiesFilter ?? List.from(this.amenitiesFilter as Iterable),
      isFiltered: isFiltered ?? this.isFiltered,
    );
  }

}