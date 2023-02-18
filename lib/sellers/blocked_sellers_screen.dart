import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class BlockedSellersScreen extends StatefulWidget {
  const BlockedSellersScreen({super.key});

  @override
  State<BlockedSellersScreen> createState() => _BlockedSellersScreenState();
}

class _BlockedSellersScreenState extends State<BlockedSellersScreen> {
  QuerySnapshot? blockedSellersSnapshot;
  getBlockedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where('status', isEqualTo: "not approved")
        .get()
        .then((notApprovedSellersSnapshot) {
      if (notApprovedSellersSnapshot.docs.isNotEmpty) {
        if (dev) printo("there are Blocked Seller data");
        setState(() {
          blockedSellersSnapshot = notApprovedSellersSnapshot;
        });
      } else {
        if (dev) printo("there is NO Verified Seller data");
        return Center(
            child: text("No Record of Blocked Sellers",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    });
  }

  void blockSeller(sellerID) {
    Map<String, dynamic> sellerDataMap = {"status": "approved"};
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerID)
        .update(sellerDataMap)
        .whenComplete(() {
      if (dev) printo('Seller activated successfully');
      showReusableSnackBar(
          "Sellers has been activated successfully!!!", context);
    }).then((value) => Navigator.pop(context));
  }

  showDialogBox(sellerDocumentID) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: text("Activate Account",
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            content: text("Do you want to activate this Seller's Account ?",
                letterSpacing: 2,
                fontSize: 16,
                color: Colors.black,
                textAlign: TextAlign.center),
            actions: [
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin chose NOT to activate seller');
                    Navigator.pop(context);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  title: "No"),
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin Chose to activate seller');
                    blockSeller(sellerDocumentID);
                    Navigator.pop(context);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  title: "Yes"),
            ],
          );
        });
  }

  @override
  void initState() {
    getBlockedSellers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget blockedSellerDesign() {
      if (blockedSellersSnapshot != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: blockedSellersSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index == 0
                    ? text(
                        "${blockedSellersSnapshot!.docs.length} Blocked Sellers",
                        color: Colors.black,
                        fontSize: 24,
                      )
                    : text(""),
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(blockedSellersSnapshot!
                                  .docs[index]
                                  .get("photoUrl")),
                            ),
                          ),
                        ),
                      ),
                      text(blockedSellersSnapshot!.docs[index].get("name"),
                          fontSize: 16, color: Colors.black),
                      text(blockedSellersSnapshot!.docs[index].get("email"),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Seller earnings button
                          // block Seller Button
                          GestureDetector(
                            onTap: () {
                              showDialogBox(
                                  blockedSellersSnapshot!.docs[index].id);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/activate.png",
                                    width: 45,
                                  ),
                                  sizedBox(width: 10),
                                  text(" Activate now", color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                          sizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              showReusableSnackBar(
                                  "${"Total Earnings = ".toUpperCase()}N ${blockedSellersSnapshot!.docs[index].get("earnings").toString()}",
                                  context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/earnings.png",
                                    width: 45,
                                  ),
                                  sizedBox(width: 10),
                                  text(
                                      "N ${blockedSellersSnapshot!.docs[index].get("earnings").toString()}",
                                      color: Colors.amber),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      } else {
        if (dev) printo('No Record of Blocked Sellers');
        return Center(
            child: text("No Record of Blocked Sellers",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    }

    return Scaffold(
      appBar: const NavAppBar(
        title: "Blocked Sellers Accounts",
      ),
      body: Center(
        child: sizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: blockedSellerDesign(),
        ),
      ),
    );
  }
}
