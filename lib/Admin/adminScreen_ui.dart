import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Adminscreen extends StatefulWidget {
  static const String routName = "Adminscreen";

  const Adminscreen({super.key});

  @override
  State<Adminscreen> createState() => _AdminscreenState();
}

class _AdminscreenState extends State<Adminscreen> {
  String orderStatus = "Pending";
  String nextButtonText = "Confirm";
  int progressIndex = 0;
  bool isLoading = false;

  final List<String> progressSteps = [
    "✔ Pending ➝ ✔ Confirmed ➝ ⭕ Shipped ➝ ⭕ Delivered",
    "✔ Pending ➝ ✔ Confirmed ➝ ✔ Shipped ➝ ⭕ Delivered",
    "✔ Pending ➝ ✔ Confirmed ➝ ✔ Shipped ➝ ✔ Delivered",
  ];

  Future<void> sendFCMNotification(String progressText) async {
    try {
      final serviceAccount = await rootBundle.loadString(
        'assets/FCM_auth/serviceAccountKey.json',
      );

      final accountCredentials = ServiceAccountCredentials.fromJson(
        serviceAccount,
      );

      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = await clientViaServiceAccount(accountCredentials, scopes);

      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/order-tracking-notificat-574c6/messages:send',
      );

      await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "message": {
            "topic": "order_1090",
            "notification": {
              "title": "ElNahdy Pharmacy - Order #1090",
              "body": progressText,
            },
            "data": {"statusIndex": "$progressIndex"},
          },
        }),
      );

      client.close();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong in notification: $e"),
          backgroundColor: Color(0xFFB9433E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.8.w),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        ),
      );
    }
  }

  void updateOrderStatus() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      progressIndex++;
    });

    await sendFCMNotification(progressSteps[progressIndex - 1]);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('progressIndex', progressIndex);

    setState(() {
      if (progressIndex == 1) {
        orderStatus = "Confirmed";
        nextButtonText = "Ship";
      } else if (progressIndex == 2) {
        orderStatus = "Shipped";
        nextButtonText = "Deliver";
      } else if (progressIndex >= 3) {
        orderStatus = "Delivered";
        nextButtonText = "";
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadOrderStatus();
  }

  Future<void> loadOrderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedIndex = prefs.getInt('progressIndex') ?? 0;
    setState(() {
      progressIndex = savedIndex;

      if (progressIndex == 0) {
        orderStatus = "Pending";
        nextButtonText = "Confirm";
      } else if (progressIndex == 1) {
        orderStatus = "Confirmed";
        nextButtonText = "Ship";
      } else if (progressIndex == 2) {
        orderStatus = "Shipped";
        nextButtonText = "Deliver";
      } else if (progressIndex >= 3) {
        orderStatus = "Delivered";
        nextButtonText = "";
      }
    });
  }

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
                        orderStatus,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: orderStatus == "Delivered"
                              ? Colors.green
                              : const Color(0xffc6b405),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (orderStatus == "Delivered") {
                            // Reset
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('progressIndex');
                            setState(() {
                              progressIndex = 0;
                              orderStatus = "Pending";
                              nextButtonText = "Confirm";
                            });
                          } else {
                            // Update order status as usual
                            updateOrderStatus();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orderStatus == "Delivered"
                              ? Color(0xfffa563a)
                              : const Color(0xff0c76f0),
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
                                orderStatus == "Delivered"
                                    ? "Reset Order"
                                    : nextButtonText,
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
