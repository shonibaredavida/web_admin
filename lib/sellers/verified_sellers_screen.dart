import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class VerifiedSellersScreen extends StatefulWidget {
  const VerifiedSellersScreen({super.key});

  @override
  State<VerifiedSellersScreen> createState() => _VerifiedSellersScreenState();
}

class _VerifiedSellersScreenState extends State<VerifiedSellersScreen> {
  QuerySnapshot? approvedSellersSnapshot;
  getVerifiedSellers() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .where('status', isEqualTo: "approved")
        .get()
        .then((verifiedSellersSnapshot) {
      if (verifiedSellersSnapshot.docs.isNotEmpty) {
        if (dev) printo("there are Verified User data");
        setState(() {
          approvedSellersSnapshot = verifiedSellersSnapshot;
        });
      } else {
        if (dev) printo("there is NO Verified User data");
      }
    });
  }

  void blockVerifiedUser(sellerID) {
    Map<String, dynamic> sellerDataMap = {"status": "not approved"};
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerID)
        .update(sellerDataMap)
        .whenComplete(() {
      if (dev) printo('User blocked successfully');
      showReusableSnackBar("Sellers has been blocked successfully!!!", context);
    }).then((value) => Navigator.pop(context));
  }

  showDialogBox(sellerDocumentID) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: text("Block Account",
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            content: text("Do you want to block this account ?",
                letterSpacing: 2,
                fontSize: 16,
                color: Colors.black,
                textAlign: TextAlign.center),
            actions: [
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin chose NOT to block seller');
                    Navigator.pop(context);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  title: "No"),
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin Chose to block seller');
                    blockVerifiedUser(sellerDocumentID);
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
    getVerifiedSellers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget verifiedUserDesign() {
      if (approvedSellersSnapshot != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: approvedSellersSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index == 0
                    ? text(
                        "${approvedSellersSnapshot!.docs.length} Verified Sellers",
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
                              image: NetworkImage(approvedSellersSnapshot!
                                  .docs[index]
                                  .get("photoUrl")),
                            ),
                          ),
                        ),
                      ),
                      text(approvedSellersSnapshot!.docs[index].get("name"),
                          fontSize: 16, color: Colors.black),
                      text(approvedSellersSnapshot!.docs[index].get("email"),
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
                                  approvedSellersSnapshot!.docs[index].id);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/block.png",
                                    width: 45,
                                  ),
                                  sizedBox(width: 10),
                                  text(" Block now", color: Colors.redAccent),
                                ],
                              ),
                            ),
                          ),
                          sizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              showReusableSnackBar(
                                  "${"Total Earnings = ".toUpperCase()}N ${approvedSellersSnapshot!.docs[index].get("earnings").toString()}",
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
                                      "N ${approvedSellersSnapshot!.docs[index].get("earnings").toString()}",
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
        if (dev) printo('No Record of Verified Sellers');
        return Center(
            child: text("No Record of Verified Sellers",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    }

    return Scaffold(
      appBar: const NavAppBar(
        title: "Verfied Sellers Accounts",
      ),
      body: Center(
        child: sizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: verifiedUserDesign(),
        ),
      ),
    );
  }
}
