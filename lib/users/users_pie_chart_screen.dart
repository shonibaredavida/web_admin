import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class UsersPieChartScreen extends StatefulWidget {
  const UsersPieChartScreen({super.key});

  @override
  State<UsersPieChartScreen> createState() => _UsersPieChartScreenState();
}

class _UsersPieChartScreenState extends State<UsersPieChartScreen> {
  double totalNumberOfVerifiedUsers = 0;
  double totalNumberOfBlockedUsers = 0;

  getTotalNumberOfVerifiedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('status', isEqualTo: "approved")
        .get()
        .then((verifiedUsersSnapshot) {
      setState(() {
        totalNumberOfVerifiedUsers =
            verifiedUsersSnapshot.docs.length.toDouble();
      });
    });
  }

  getTotalNumberOfBlockedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('status', isEqualTo: "not approved")
        .get()
        .then((blockedUsersSnapshot) {
      setState(() {
        totalNumberOfBlockedUsers = blockedUsersSnapshot.docs.length.toDouble();
      });
    });
  }

  @override
  void initState() {
    getTotalNumberOfVerifiedUsers();
    getTotalNumberOfBlockedUsers();
    super.initState();
  }

  @override
  // ignore: unnecessary_const
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Verified Users": totalNumberOfVerifiedUsers,
      "Blocked Users": totalNumberOfBlockedUsers,
    };

    final colorList = <Color>[
      Colors.greenAccent,
      Colors.deepPurpleAccent,
    ];
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: const NavAppBar(
        title: "Users Pie CHart",
      ),
      body: Center(
          child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.disc,
        baseChartColor: Colors.grey[300]!,
        colorList: colorList,
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: true,
          chartValueStyle: TextStyle(
            fontSize: 22,
          ),
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
      )),
    );
  }
}
