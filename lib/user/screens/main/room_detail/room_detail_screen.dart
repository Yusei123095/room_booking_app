import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:room_booking_app/user/controller/booking_date_controller.dart';
import 'package:room_booking_app/user/controller/room_availability_controller.dart';
import 'package:room_booking_app/user/screens/main/filter/select_timeslots_screen.dart';
import 'package:room_booking_app/user/screens/main/room_detail/room_detail_appbar.dart';
import 'package:room_booking_app/user/service/auth_service.dart';
import 'package:room_booking_app/utils/icon_util.dart';
import 'package:room_booking_app/widgets/room_detail/availability_display.dart';
import 'package:room_booking_app/widgets/book_detail/booking_confirmation_modal.dart';
import 'package:room_booking_app/widgets/room_detail/prohibition_list.dart';
import 'package:room_booking_app/widgets/time_selection/date_time_display.dart';

class RoomDetail extends ConsumerStatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> room;

  const RoomDetail({super.key, required this.room});

  @override
  ConsumerState<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends ConsumerState<RoomDetail> {
  AuthService _auth = AuthService();
  late User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final bookingStatusNotifier = ref.watch(bookingDateProvider.notifier);

    final bookingStatus = ref.watch(bookingDateProvider);

    final isRoomAvailable = ref.watch(
      roomAvailabilityProvider((isTemp: false, roomId: widget.room.id, bookId: null)),
    );

    final room_info = widget.room.data()!;

    Size size = MediaQuery.of(context).size;

    bool bookable = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          RoomDetailAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room_info['room_name'],
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.pinkAccent,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    room_info['room_location'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$5.00',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "per slot",
                        style: TextStyle(fontSize: 20, color: Colors.black45),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Room Features",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    runSpacing: 5,
                    children: List.generate(
                      room_info['room_amenities'].length,
                      (index) => Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              convertStringToIcon(
                                room_info['room_amenities'][index],
                              ),
                              size: 25,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${room_info['room_amenities'][index]}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Room Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "A quiet, soundproof space with high-speed internet, HD webcam, and professional lighting. Perfect for meetings, interviews, and online events.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Room Capacity / Size",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 30,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${room_info['room_capacity']}",
                        style: TextStyle(fontSize: 18, color: Colors.black45),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.crop_square_sharp,
                        size: 30,
                        color: Colors.black38,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${room_info['room_size']} sq ft",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Important Restrictions",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  ProhibitionList(prohibitions:List<String>.from(room_info["prohibitions"]) ),
                  SizedBox(height: 20),
                  Text(
                    "Booking Status",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onLongPress: () {},
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (_) => SelectTimeslotsScreen(
                                room_id: widget.room.id,
                              ),
                        ),
                      );
                    },
                    child: DateTimeColumnDisplay(
                      date:
                          "${DateFormat("MMM dd, yyyy").format(bookingStatus.selectedDate!)}",
                      time:
                          "${bookingStatusNotifier.getStartEndTime(false)}",
                      availabilityDisplay: isRoomAvailable.when(
                        data: (data) {
                          setState(() {
                            bookable = false;
                          });
                          if (data == null) {
                            // timeslots are not selected
                            return UnselectedTimeDisplay();
                          } else if (!data) {
                            // selected timeslots are unavailable

                            return UnAvailableDisplay();
                          } else {
                            //otherwise; the timeslots are available
                            setState(() {
                              bookable = true;
                            });
                            return AvailableDisplay();
                          }
                        },
                        error: (err, _) => WaitingAvailabilityDisplay(),
                        loading: () => WaitingAvailabilityDisplay(),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton:
          bookable
              ? SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.05,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder:
                          (context) => BookingConfirmationModal(
                            date: DateFormat(
                              "MMM dd, yyyy",
                            ).format(bookingStatus.selectedDate!),
                            startEndTime: bookingStatusNotifier.getStartEndTime(
                              false,
                            ),
                            duration: bookingStatus.timeslots.length * 0.5,
                            onTap: () {
                              try {
                                ref
                                    .read(bookingDateProvider.notifier)
                                    .bookRoom(widget.room.id, user!.uid);
                              } catch (e) {
                                print(e);
                              } finally {
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ >= 2; // pops 2 pages
                                });
                              }
                            },
                          ),
                    );
                  },
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      0,
                    ), // Change the shape here
                  ),
                  elevation: 0,
                  label: Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
