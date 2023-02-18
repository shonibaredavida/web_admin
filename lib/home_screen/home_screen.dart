import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String liveDate;
  late String liveTime;
  String formatCurrentLiveTime(DateTime time) {
    //  print(DateFormat("hh:mm:ss a").format(time).toString());
    return DateFormat("hh:mm:ss a").format(time).toString();
  }

  String formatCurrentLiveDate(DateTime time) {
    //  print(DateFormat("dd MMMM, yyyy").format(time));
    return DateFormat("dd MMMM, yyyy").format(time);
  }

  getCurrentLiveTimeDate() {
    liveDate = formatCurrentLiveDate(DateTime.now());
    liveTime = formatCurrentLiveTime(DateTime.now());

    setState(() {
      liveDate;
      liveTime;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTimeDate();
    });

    getCurrentLiveTimeDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: const NavAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: text(
                "     $liveTime\n$liveDate",
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            //verified users & blocked users
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: null,
                    child: Image.asset(
                      "images/verified_users.png",
                      width: 200,
                    )),
                const SizedBox(
                  width: 200,
                ),
                GestureDetector(
                    onTap: null,
                    child: Image.asset(
                      "images/blocked_users.png",
                      width: 200,
                    )),
              ],
            ),
            const SizedBox(
              height: 100,
            ), //activated users & blocked sellers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: null,
                    child: Image.asset(
                      "images/verified_seller.png",
                      width: 200,
                    )),
                const SizedBox(
                  width: 200,
                ),
                GestureDetector(
                    onTap: null,
                    child: Image.asset(
                      "images/blocked_seller.png",
                      width: 200,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
