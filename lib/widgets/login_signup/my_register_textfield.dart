import 'package:flutter/material.dart';

class MyRegisterTextfield extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextEditingController textcontroller;

  const MyRegisterTextfield({
    super.key,
    required this.icon,
    required this.text,
    required this.textcontroller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: TextStyle(fontSize: 18),
        controller: textcontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          isCollapsed: true,
          prefixIcon: Icon(icon, color: Colors.black54),
          hintText: text,
          hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class MyPasswordTextfield extends StatefulWidget {
  final String text;
  final TextEditingController passwordController;
  const MyPasswordTextfield({super.key,required this.text, required this.passwordController});

  @override
  State<MyPasswordTextfield> createState() => _MyPasswordTextfieldState();
}

class _MyPasswordTextfieldState extends State<MyPasswordTextfield> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: TextStyle(fontSize: 18),
        controller: widget.passwordController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          isCollapsed: true,
          prefixIcon: Icon(Icons.lock_outline, color: Colors.black54),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
            icon: Icon(
              isHidden
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black54,
            ),
          ),
          hintText: widget.text,
          hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
          border: InputBorder.none,
        ),
        obscureText: isHidden,
      ),
    );
  }
}
