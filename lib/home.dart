import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'User/userScreen_ui.dart';

class HomeScreen extends StatelessWidget {
  static const String routName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.5.h,
        backgroundColor: Color(0xff0c76f0),
        title: Text(
          "iSUPPLY Order Tracking",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 2.5.w, top: 3.h),
              child: Text(
                "Select a type:",
                style: TextStyle(
                  color: Color(0xff002f68),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Userscreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.25.w, 0.0); // from right
                          const end = Offset.zero;
                          return SlideTransition(
                            position: animation.drive(
                              Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: Curves.ease)),
                            ),
                            child: child,
                          );
                        },
                  ),
                );
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3.h),
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  height: 41.h,
                  width: 80.w,
                  decoration: BoxDecoration(color: Color(0xffe5ecfe)),
                  child: Column(
                    children: [
                      Expanded(child: Image.asset("assets/images/user.jpg")),
                      Container(
                        margin: EdgeInsets.only(top: 0.5.h),
                        child: Text(
                          "User",
                          style: TextStyle(
                            color: Color(0xff002f68),
                            fontWeight: FontWeight.bold,
                            fontSize: 19.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3.h),
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  height: 41.h,
                  width: 80.w,
                  decoration: BoxDecoration(color: Color(0xffe5ecfe)),
                  child: Column(
                    children: [
                      Expanded(child: Image.asset("assets/images/admin.jpg")),
                      Container(
                        margin: EdgeInsets.only(top: 0.5.h),
                        child: Text(
                          "Admin",
                          style: TextStyle(
                            color: Color(0xff002f68),
                            fontWeight: FontWeight.bold,
                            fontSize: 19.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
