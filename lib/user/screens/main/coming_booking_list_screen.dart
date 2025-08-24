import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/home_screen_controller.dart';
import 'package:room_booking_app/user/screens/main/book_detail_screen.dart';
import 'package:room_booking_app/widgets/book_detail/coming_book_card.dart';
import 'package:room_booking_app/widgets/home/booking_display.dart';

class ComingBookingListScreen extends ConsumerStatefulWidget {
  const ComingBookingListScreen({super.key});

  @override
  ConsumerState<ComingBookingListScreen> createState() =>
      _ComingBookingListScreenState();
}

class _ComingBookingListScreenState
    extends ConsumerState<ComingBookingListScreen> {
  List<String> selectedBooks = [];

  @override
  Widget build(BuildContext context) {
    final comingBookingProvider = ref.watch(currentBookingsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Coming Bookings"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: comingBookingProvider.when(
            data: (data) {
              final comingBookings = data.docs;
              return Column(
                children: List.generate((comingBookings.length), (index) {
                  final comingBooking = comingBookings[index].data();
                  final comingBookId = comingBookings[index].id;
                  return ref
                      .watch(findRoomProvider(comingBooking['room']))
                      .when(
                        data:
                            (data) => Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (_) => BookDetailScreen(
                                            room: data.data() ?? {},
                                            bookInfo: comingBooking,
                                            bookId: comingBookId,
                                          ),
                                    ),
                                  );
                                },
                                child: BookingDisplay(
                                  room: data.data() ?? {},
                                  book: comingBooking,
                                  bookId: comingBookId,
                                ),
                              ),
                            ),
                        error: (err, _) => CircularProgressIndicator(),
                        loading: () => CircularProgressIndicator(),
                      );
                }),
              );
            },
            error: (err, _) => CircularProgressIndicator(),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
