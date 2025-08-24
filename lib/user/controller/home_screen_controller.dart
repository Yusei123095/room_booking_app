import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:room_booking_app/user/service/auth_service.dart';

final navigationScreenProvider = StateProvider((ref) {
  int selectedIndex = 0;
  return selectedIndex;
});

final recentBookingsProvider = StreamProvider((ref) {
  DateTime currentTime = DateTime.now();
  AuthService _auth = AuthService();
  User? currentUser = _auth.getCurrentUser();

  return FirebaseFirestore.instance
      .collection("books")
      .where("user", isEqualTo: currentUser!.uid)
      .where("date", isLessThan: currentTime)
      .orderBy("date", descending: false)
      .snapshots()
      .map((snapshot) {
    final allNames = snapshot.docs.map((doc) => doc["room"] as String);

    // removes duplicates inside the snapshot
    return allNames.toSet();
  });
});

final nextBookingProvider = StreamProvider<QueryDocumentSnapshot<Map<String, dynamic>>>((ref) {
  DateTime currentTime = DateTime.now();
  AuthService _auth = AuthService();
  User? currentUser = _auth.getCurrentUser();
  return FirebaseFirestore.instance
      .collection("books")
      .where("user", isEqualTo: currentUser!.uid)
      .where("date", isGreaterThanOrEqualTo: currentTime)
      .orderBy("date", descending: false)
      .limit(1)
      .snapshots()
      .map((snapshot) => snapshot.docs.first);
});

final currentBookingsProvider = StreamProvider((ref) {
  DateTime currentTime = DateTime.now();
  AuthService _auth = AuthService();
  User? currentUser = _auth.getCurrentUser();
  return FirebaseFirestore.instance
      .collection("books")
      .where("user", isEqualTo: currentUser!.uid)
      .where("date", isGreaterThanOrEqualTo: currentTime)
      .orderBy("date", descending: false)
      .snapshots();
});

final findRoomProvider = StreamProvider.family<
    DocumentSnapshot<Map<String, dynamic>>, String>((ref, roomId) {
      return FirebaseFirestore.instance.collection("rooms").doc(roomId).snapshots();
});