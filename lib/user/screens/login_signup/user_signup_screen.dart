import 'package:flutter/material.dart';
import 'package:room_booking_app/user/screens/login_signup/user_login_screen.dart';
import 'package:room_booking_app/user/service/auth_service.dart';
import 'package:room_booking_app/widgets/login_signup/my_register_textfield.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  AuthService _auth = AuthService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  void _signup() async {
    String? result = await _auth.signup(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if(result == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => UserLoginScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.auto_stories_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              SizedBox(height: 15),
              Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                "Join us to start booking rooms",
                style: TextStyle(fontSize: 21, color: Colors.grey),
              ),
              SizedBox(height: 30),

              // Input Name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Full name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 30),
                child: MyRegisterTextfield(
                  icon: Icons.person_2_outlined,
                  text: "Enter you full name",
                  textcontroller: _nameController,
                ),
              ),

              // Input Email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 30),
                child: MyRegisterTextfield(
                  icon: Icons.person_2_outlined,
                  text: "Enter you email address",
                  textcontroller: _emailController,
                ),
              ),

              //Input Password
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 30),
                child: MyPasswordTextfield(
                  text: "Create a password",
                  passwordController: _passwordController,
                ),
              ),

              //Input Password Confirmation
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 30),
                child: MyPasswordTextfield(
                  text: "Confirm your password",
                  passwordController: _passwordConfirmController,
                ),
              ),

              InkWell(
                onTap: () {
                  _signup();
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create an account ",
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                      Icon(Icons.person_add, color: Colors.white),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserLoginScreen()),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
