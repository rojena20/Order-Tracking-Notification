import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../Modules/end_child_module.dart';

class Userscreen extends StatefulWidget {
  static const String routName = "Userscreen";

  Userscreen({super.key});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  bool isLoading = false;
  bool hasOrdered = false;
  int statusIndex = 0;
  bool isStatusLoaded = false;

  final List<Map<String, dynamic>> orderSteps = [
    {
      'title': 'Pending',
      'message': "We've received your order.",
      'asset': 'assets/images/pending.png',
    },
    {
      'title': 'Confirmed',
      'message': "Your order has been confirmed.",
      'asset': 'assets/images/confirmed.png',
    },
    {
      'title': 'Shipped',
      'message': "Your order is on the way.",
      'asset': 'assets/images/shipped.png',
    },
    {
      'title': 'Delivered',
      'message': "Your order has been delivered successfully.",
      'asset': 'assets/images/delivered.png',
    },
  ];

  void handleNotification(RemoteMessage message) async {
    final body = message.notification?.body;

    if (body != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (body.contains("✔ Pending") && body.contains("⭕ Confirmed")) {
        setState(() => statusIndex = 0);
        prefs.setInt('statusIndex', 0);
      } else if (body.contains("✔ Confirmed") && body.contains("⭕ Shipped")) {
        setState(() => statusIndex = 1);
        prefs.setInt('statusIndex', 1);
      } else if (body.contains("✔ Shipped") && body.contains("⭕ Delivered")) {
        setState(() => statusIndex = 2);
        prefs.setInt('statusIndex', 2);
      } else if (body.contains("✔ Delivered")) {
        setState(() => statusIndex = 3);
        prefs.setInt('statusIndex', 3);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadStatus();
    FirebaseMessaging.onMessage.listen(handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }

  Future<void> loadStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ordered = prefs.getBool('hasOrdered') ?? false;
    final status = prefs.getInt('statusIndex') ?? 0;

    setState(() {
      hasOrdered = ordered;
      statusIndex = status;
      isStatusLoaded = true;
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
          "User",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21.sp,
          ),
        ),
      ),
      body: isStatusLoaded
          ? (hasOrdered ? buildTrackingView() : buildOrderView())
          : Center(child: Text('Loading...')),
    );
  }

  Widget buildOrderView() {
    return Column(
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
                    style: TextStyle(color: Color(0xff002f68), fontSize: 18.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() => isLoading = true);
                    await Future.delayed(const Duration(seconds: 1));
                    await FirebaseMessaging.instance.subscribeToTopic(
                      "order_1090",
                    );

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('hasOrdered', true);
                    prefs.setInt('statusIndex', 0);

                    setState(() {
                      hasOrdered = true;
                      isLoading = false;
                      statusIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0c76f0),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.5.h,
                      horizontal: 12.w,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xff0c76f0), width: 0.5.w),
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
    );
  }

  Widget buildTrackingView() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(left: 2.5.w, top: 3.h, bottom: 3.w),
          child: Text(
            "Track your order",
            style: TextStyle(
              color: const Color(0xff002f68),
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        ...List.generate(orderSteps.length, (index) {
          return SizedBox(
            height: 15.h,
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: index == 0,
              isLast: index == orderSteps.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 5.w,
                color: index <= statusIndex
                    ? const Color(0xff0c76f0)
                    : Colors.grey,
                padding: EdgeInsets.all(1.w),
              ),
              endChild: EndChildModule(
                asset: orderSteps[index]['asset'],
                assetHeight: (index == 3 || index == 4) ? 9.h : 8.h,
                title: orderSteps[index]['title'],
                message: orderSteps[index]['message'],
              ),
              beforeLineStyle: LineStyle(
                color: index <= statusIndex
                    ? const Color(0xff0c76f0)
                    : Colors.grey,
              ),
            ),
          );
        }),
      ],
    );
  }
}
