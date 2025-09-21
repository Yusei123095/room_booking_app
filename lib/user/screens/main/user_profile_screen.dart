import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_booking_app/user/service/auth_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                child: Icon(Icons.person, color: Colors.white, size: 60),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15,),


              SizedBox(height: 15,),

              FutureBuilder(future: _auth.getCurrentUserInfo(), builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }

                final data = snapshot.data!.data() ?? {};
                return Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name", style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600),),

                          Text(data["name"] ?? "No Data", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ID", style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600),),

                          Text(_auth.getCurrentUser()!.uid, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email Address", style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600),),

                          Text(data["email"] ?? "No Data", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                  ]),
                );
              }),

              SizedBox(height: 20,),
              Row(children: [

              ],)


            ],
          ),
        ),
      ),
    );
  }
}
