import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/filter_room_detail_controller.dart';
import 'package:room_booking_app/widgets/filter/amenity_check_box.dart';
import 'package:room_booking_app/widgets/filter/filter_selection.dart';

class FilterSearchScreen extends ConsumerStatefulWidget {
  const FilterSearchScreen({super.key});

  @override
  ConsumerState<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends ConsumerState<FilterSearchScreen> {
  final filters = FirebaseFirestore.instance
      .collection("config")
      .doc('filters');


  bool expandSizeDropdown = false;
  bool expandLocationDropdown = false;

  List<String> createFloorsArray(int numFloors) {
    List<String> floors = [];
    floors.add("All Floors");
    for (int i = 1; i <= numFloors; i++) {
      floors.add("Floor $i");
    }

    return floors;
  }

  List<String> createSizesArray(List<dynamic> sizeList) {
    List<String> sizes = ["All Sizes"];
    sizeList.forEach((size) => sizes.add(size));

    return sizes;
  }

  late Future<DocumentSnapshot> _filtersFuture;


  late String currentFloorFilter;
  late String currentCapacityFilter;
  late List<String> currentAmenitiesFilter;



  List<bool> createAmenitiesBoolList(
    List<dynamic> allAmenities,
    List<String> selectedAmenities,
  ) {
    List<bool> boolList = [];
    allAmenities.forEach((items) => boolList.add(false));
    selectedAmenities.forEach(
      (amenity) => boolList[allAmenities.indexOf(amenity)] = true,
    );

    return boolList;
  }

  @override
  void initState() {
    super.initState();

    _filtersFuture =
        FirebaseFirestore.instance.collection("config").doc("filters").get();

    final roomFilters = ref.read(filterRoomDetailProvider);

    currentFloorFilter = roomFilters.locationFilter;
    currentCapacityFilter = roomFilters.capacityFilter;
    currentAmenitiesFilter = [...roomFilters.amenitiesFilter];
    
  }

  bool isFilterUpdated(String newCapacity, String newLocation, List<String> newAmenities){
    final roomFilters = ref.read(filterRoomDetailProvider);

    return roomFilters.capacityFilter != newCapacity || roomFilters.locationFilter != newLocation || !(Set.from(roomFilters.amenitiesFilter).containsAll(newAmenities) && Set.from(newAmenities).containsAll(roomFilters.amenitiesFilter));
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final roomFiltersNotifier = ref.read(filterRoomDetailProvider.notifier);

    return FutureBuilder<DocumentSnapshot>(
      future: _filtersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(backgroundColor: Colors.white);
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Text('Failed to load filters');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final floors = createFloorsArray(data['floors']);
        final sizes = createSizesArray(data['size']);
        final amenities = data['amenities'] as List<dynamic>;



        return Scaffold(
          floatingActionButton:
          isFilterUpdated(currentCapacityFilter, currentFloorFilter, currentAmenitiesFilter ) ?
          FloatingActionButton(onPressed: () {
            roomFiltersNotifier.setCapacityFilter(currentCapacityFilter);
            roomFiltersNotifier.setLocationFilter(currentFloorFilter);
            roomFiltersNotifier.setAmenitiesFilter(currentAmenitiesFilter);
            Navigator.of(context).pop();


          }): null ,
          appBar: AppBar(
            title: Text("Filters", style: TextStyle(fontSize: 28)),
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capacity",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  width: double.infinity,
                  child: FilterSelection(
                    label:
                    currentCapacityFilter.isEmpty
                            ? "All Sizes"
                            : currentCapacityFilter,
                    icon: Icons.people_outline,
                    onPress: (selectedFloor) {
                      setState(() {
                        if (selectedFloor != "All Sizes") {
                          currentCapacityFilter = selectedFloor;
                        } else {
                          currentCapacityFilter = "";
                        }
                      });
                    },
                    items: sizes,
                  ),
                ),

                SizedBox(height: 3),

                SizedBox(height: 15),

                Text(
                  "Location",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  width: double.infinity,
                  child: FilterSelection(
                    label:
                        currentFloorFilter.isEmpty
                            ? "All Floors"
                            : currentFloorFilter,
                    icon: Icons.people_outline,
                    onPress: (selectedFloor) {
                      setState(() {
                        if (selectedFloor != "All Floors") {
                          currentFloorFilter = selectedFloor;
                        } else {
                          currentFloorFilter = "";
                        }
                      });
                    },
                    items: floors,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),

                Text(
                  "Amenity",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: amenities.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    childAspectRatio: 4,
                  ),
                  itemBuilder: (context, index) {
                    return AmenityCheckBox(
                      label: amenities[index],
                      isChecked: currentAmenitiesFilter.contains(amenities[index]),
                      onClick:
                          (value) => setState(() {
                            if(value){
                              currentAmenitiesFilter.add(amenities[index]);
                            }else{
                              currentAmenitiesFilter.remove(amenities[index]);
                            }
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
