import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EndChildModule extends StatelessWidget {
  final String asset;
  final double assetHeight;
  final String title;
  final String message;

  EndChildModule({
    super.key,
    required this.asset,
    required this.assetHeight,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: assetHeight,
          margin: EdgeInsets.only(left: 4.w),
          child: Image.asset(asset),
        ),
        SizedBox(width: 2.w),
        SizedBox(
          width: 60.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff002f68),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.8.h),
              Text(
                message,
                style: TextStyle(color: Color(0xFF636564), fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}