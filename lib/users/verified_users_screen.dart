import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class VerifiedUsersScreen extends StatefulWidget {
  const VerifiedUsersScreen({super.key});

  @override
  State<VerifiedUsersScreen> createState() => _VerifiedUsersScreenState();
}

class _VerifiedUsersScreenState extends State<VerifiedUsersScreen> {
  QuerySnapshot? approvedUsersSnapshot;
  getVerifiedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('status', isEqualTo: "approved")
        .get()
        .then((verifiedUsersSnapshot) {
      if (verifiedUsersSnapshot.docs.isNotEmpty) {
        if (dev) printo("there are Verified User data");
        setState(() {
          approvedUsersSnapshot = verifiedUsersSnapshot;
        });
      } else {
        if (dev) printo("there is NO Verified User data");
      }
    });
  }

  void blockVerifiedUser(userID) {
    Map<String, dynamic> userDataMap = {"status": "not approved"};
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .update(userDataMap)
        .whenComplete(() {
      if (dev) printo('User blocked successfully');
      showReusableSnackBar("Users has been blocked successfully!!!", context);
    }).then((value) => Navigator.pop(context));
  }

  showDialogBox(userDocumentID) {
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
                    if (dev) printo('Admin chose NOT to delete user');
                    Navigator.pop(context);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  title: "No"),
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin Chose to delete user');
                    blockVerifiedUser(userDocumentID);
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
    getVerifiedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget verifiedUserDesign() {
      if (approvedUsersSnapshot != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: approvedUsersSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index == 0
                    ? text(
                        "${approvedUsersSnapshot!.docs.length} Verified Users",
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
                              image: NetworkImage(approvedUsersSnapshot!
                                  .docs[index]
                                  .get("photoUrl")),
                            ),
                          ),
                        ),
                      ),
                      text(approvedUsersSnapshot!.docs[index].get("name"),
                          fontSize: 16, color: Colors.black),
                      text(approvedUsersSnapshot!.docs[index].get("email"),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      GestureDetector(
                        onTap: () {
                          showDialogBox(approvedUsersSnapshot!.docs[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 18),
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
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      } else {
        if (dev) printo('No Record of Verified Users');
        return Center(
            child: text("No Record of Verified Users",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    }

    return Scaffold(
      appBar: const NavAppBar(
        title: "Verfied Users Accounts",
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
