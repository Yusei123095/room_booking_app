import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/home_screen_controller.dart';
import 'package:room_booking_app/user/screens/main/book_detail_screen.dart';
import 'package:room_booking_app/user/screens/main/coming_booking_list_screen.dart';
import 'package:room_booking_app/user/screens/main/room_detail/room_detail_screen.dart';
import 'package:room_booking_app/user/service/auth_service.dart';
import 'package:room_booking_app/widgets/home/booking_display.dart';
import 'package:room_booking_app/widgets/home/home_appbar.dart';
import 'package:room_booking_app/widgets/home/loading_booking_display.dart';
import 'package:room_booking_app/widgets/home/recent_booking_display.dart';
import 'package:room_booking_app/widgets/home/search_detail_input.dart';

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends ConsumerState<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final recentBookings = ref.watch(recentBookingsProvider);
    final nextBooking = ref.watch(nextBookingProvider);
    AuthService auth = AuthService();
    User? user = auth.getCurrentUser();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              HomeAppbar(),

              SizedBox(height: 30),

              SearchDetailInput(onSearch: () {}),

              // Display next booking coming earliest
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Next Booking",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ComingBookingListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              nextBooking.when(
                data: (data) {
                  final bookId = data.id;
                  final book_info = data.data();
                  if (book_info.isEmpty) {
                    return SizedBox();
                  }
                  return FutureBuilder(
                    future:
                        FirebaseFirestore.instance
                            .collection("rooms")
                            .doc(data['room'])
                            .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingBookingDisplay();
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return Text("Also no data");
                      }
                      final room_data = snapshot.data!.data() ?? {};
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookDetailScreen(bookInfo: book_info, bookId: bookId, room: room_data)));
                        },
                        child: BookingDisplay(book: book_info, room: room_data, bookId: bookId,),
                      );
                    },
                  );
                },
                error: (err, _) => Text("No data"),
                loading:
                    () => SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: CircularProgressIndicator(),
                    ),
              ),

              // Display room information recently booked by the user
              SizedBox(height: 15),
              Text(
                "Recent Bookings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              recentBookings.when(
                data: (data) {
                  final bookings = data.toList();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(bookings.length, (index) {
                        final bookings_data = bookings[index];
                        return StreamBuilder(
                          stream:
                              FirebaseFirestore.instance
                                  .collection("rooms")
                                  .doc(bookings_data)
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("no data");
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return Text("Also no data");
                            }
                            final room_data = snapshot.data!;
                            return Padding(
                              padding: EdgeInsets.only(right: 40),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (_) => RoomDetail(room: room_data),
                                    ),
                                  );
                                },
                                child: RecentBookingDisplay(
                                  room: room_data.data()!,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  );
                },
                error: (error, _) => Text("No data"),
                loading: () => Text("No one"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
