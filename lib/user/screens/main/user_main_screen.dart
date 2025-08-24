import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/controller/home_screen_controller.dart';
import 'package:room_booking_app/user/screens/main/room_list_screen.dart';
import 'package:room_booking_app/user/screens/main/user_home_screen.dart';
import 'package:room_booking_app/user/screens/main/user_profile_screen.dart';

class UserMainScreen extends ConsumerStatefulWidget {
  const UserMainScreen({super.key});

  @override
  ConsumerState<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends ConsumerState<UserMainScreen> {
  final List screens = [UserHomeScreen(), UserBookingScreen(), UserProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationScreenProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          onTap: (newValue){
               ref.read(navigationScreenProvider.notifier).update((state) => state = newValue);
          },
          currentIndex: selectedIndex,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.person_2_sharp), label: "Profile")
      ]),
      body: screens[selectedIndex],
    );
  }
}
