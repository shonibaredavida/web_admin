import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class SellersPieChartScreen extends StatefulWidget {
  const SellersPieChartScreen({super.key});

  @override
  State<SellersPieChartScreen> createState() => _SellersPieChartScreenState();
}

class _SellersPieChartScreenState extends State<SellersPieChartScreen> {
  double totalNumberOfVerifiedSellers = 0;
  double totalNumberOfBlockedSellers = 0;

  getTotalNumberOfVerifiedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where('status', isEqualTo: "approved")
        .get()
        .then((verifiedSellersSnapshot) {
      setState(() {
        totalNumberOfVerifiedSellers =
            verifiedSellersSnapshot.docs.length.toDouble();
      });
    });
  }

  getTotalNumberOfBlockedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where('status', isEqualTo: "not approved")
        .get()
        .then((blockedSellersSnapshot) {
      setState(() {
        totalNumberOfBlockedSellers =
            blockedSellersSnapshot.docs.length.toDouble();
      });
    });
  }

  @override
  void initState() {
    getTotalNumberOfVerifiedSellers();
    getTotalNumberOfBlockedSellers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Verified Sellers": totalNumberOfVerifiedSellers,
      "Blocked Selllers": totalNumberOfBlockedSellers,
    };

    final colorList = <Color>[
      Colors.greenAccent,
      Colors.deepPurpleAccent,
    ];
    return Scaffold(
        backgroundColor: defaultBackgroundColor,
        appBar: const NavAppBar(
          title: "Sellers Pie CHart",
        ),
        body: PieChart(
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
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 0,
          ),
        ));
  }
}
