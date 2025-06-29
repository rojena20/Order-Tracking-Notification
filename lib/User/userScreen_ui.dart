import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../Modules/end_child_module.dart';

class Userscreen extends StatelessWidget {
  static const String routName = "Userscreen";
  bool isLoading = false;

  Userscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 7.5.h,
        backgroundColor: Color(0xff0c76f0),
        title: Text(
          "User",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 2.5.w, top: 3.h),
            child: Text(
              "Our product",
              style: TextStyle(
                color: Color(0xff002f68),
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 3.h),
              padding: EdgeInsets.symmetric(vertical: 1.h),
              height: 44.h,
              width: 90.w,
              decoration: BoxDecoration(color: Color(0xffe5ecfe)),
              child: Column(
                children: [
                  Expanded(child: Image.asset("assets/images/vitamen D3.jpg")),
                  Container(
                    margin: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
                    child: Text(
                      "Health Aid Vitamin D3 1000iu \n120 tabs",
                      style: TextStyle(
                        color: Color(0xff002f68),
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0c76f0),
                      padding: EdgeInsets.symmetric(
                        vertical: 0.5.h,
                        horizontal: 12.w,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff0c76f0),
                          width: 0.5.w,
                        ),
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 3.h,
                            width: 6.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3.5.sp,
                            ),
                          )
                        : Text(
                            "Order Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
