import 'package:flutter/material.dart';
import 'package:room_booking_app/user/screens/main/user_main_screen.dart';
import 'package:room_booking_app/user/screens/login_signup/user_signup_screen.dart';
import 'package:room_booking_app/user/service/auth_service.dart';
import 'package:room_booking_app/widgets/login_signup/my_register_textfield.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService auth = AuthService();

  void _login() async{
    String? result = await auth.login(email: _emailController.text, password: _passwordController.text);

    if(result == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => UserMainScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
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
                child: Icon(Icons.auto_stories, color: Colors.white, size: 50),
              ),

              SizedBox(height: 15),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                "Sign in to your account to continue",
                style: TextStyle(fontSize: 21, color: Colors.grey),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30, top: 5),
                child: MyRegisterTextfield(
                  icon: Icons.email_outlined,
                  text: "Enter your email address",
                   textcontroller:  _emailController
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 5),
              MyPasswordTextfield(
                text: "Enter your password",
                passwordController: _passwordController,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  _login();
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
                        "Sign in ",
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                      Icon(Icons.login, color: Colors.white),
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
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => UserSignupScreen()),
                      );
                    },
                    child: Text(
                      "Sing up",
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
