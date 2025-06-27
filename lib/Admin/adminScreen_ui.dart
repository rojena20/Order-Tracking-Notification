import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Adminscreen extends StatelessWidget {
  static const String routName = "Adminscreen";
  bool isLoading = false;

  Adminscreen({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 2.5.w, top: 3.h),
            child: Text(
              "Orders",
              style: TextStyle(
                color: Color(0xff002f68),
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            decoration: BoxDecoration(
              color: Color(0xffe5ecfe),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.5.w),
                    child: Image.asset("assets/images/vitamen D3.jpg"),
                  ),
                ),
                SizedBox(width: 2.5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#1090",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0xff002f68),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Health Aid Vitamin D3 1000iu 120 tabs",
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          color: Color(0xff63636a),
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xffc6b405),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0c76f0),
                          padding: EdgeInsets.symmetric(
                            vertical: 0.2.h,
                            horizontal: 5.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.5.w),
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
                                "Confirm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.5.sp,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
