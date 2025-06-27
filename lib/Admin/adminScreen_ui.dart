import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Adminscreen extends StatelessWidget {
  static const String routName = "Adminscreen";
  const Adminscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 7.5.h,
        backgroundColor: Color(0xff0c76f0),
        title: Text(
          "Admin",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
    );
  }
}
