import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_booking_app/user/screens/main/filter/select_timeslots_screen.dart';
import 'package:room_booking_app/user/screens/login_signup/user_login_screen.dart';
import 'package:room_booking_app/user/screens/main/user_main_screen.dart';
import 'package:room_booking_app/user/screens/main/room_detail/room_detail_screen.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ProviderScope(child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthStateHandler(),
    ));
  }
}

class AuthStateHandler extends StatefulWidget {
  const AuthStateHandler({super.key});

  @override
  State<AuthStateHandler> createState() => _AuthStateHandlerState();
}

class _AuthStateHandlerState extends State<AuthStateHandler> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _initialAuthState();
  }

  void _initialAuthState(){
    FirebaseAuth.instance.authStateChanges().listen((user) async{
      if(!mounted) return;
        setState(() {
          _user = user;
        });
      if(user != null){
        final userDoc = FirebaseFirestore.instance.collection('user').doc(user.uid).get();
        if(!mounted) return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return UserLoginScreen();
    }else{
      return UserMainScreen();
    }
  }
}

