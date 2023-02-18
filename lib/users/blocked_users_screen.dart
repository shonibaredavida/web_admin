import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/widgets/nav_appbar.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  QuerySnapshot? blockedUsersSnapshot;
  getBlockedUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('status', isEqualTo: "not approved")
        .get()
        .then((notApprovedUsersSnapshot) {
      if (notApprovedUsersSnapshot.docs.isNotEmpty) {
        if (dev) printo("there are Blocked User data");
        setState(() {
          blockedUsersSnapshot = notApprovedUsersSnapshot;
        });
      } else {
        if (dev) printo("there is NO Verified User data");
        return Center(
            child: text("No Record of Blocked Users",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    });
  }

  void blockUser(userID) {
    Map<String, dynamic> userDataMap = {"status": "approved"};
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .update(userDataMap)
        .whenComplete(() {
      if (dev) printo('User activated successfully');
      showReusableSnackBar("Users has been activated successfully!!!", context);
    }).then((value) => Navigator.pop(context));
  }

  showDialogBox(userDocumentID) {
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
            content: text("Do you want to activate this User's Account ?",
                letterSpacing: 2,
                fontSize: 16,
                color: Colors.black,
                textAlign: TextAlign.center),
            actions: [
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin chose NOT to activate user');
                    Navigator.pop(context);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  title: "No"),
              elevatedButton(
                  onPressed: () {
                    if (dev) printo('Admin Chose to activate user');
                    blockUser(userDocumentID);
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
    getBlockedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget blockedUserDesign() {
      if (blockedUsersSnapshot != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: blockedUsersSnapshot!.docs.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index == 0
                    ? text(
                        "${blockedUsersSnapshot!.docs.length} Blocked Users",
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
                              image: NetworkImage(blockedUsersSnapshot!
                                  .docs[index]
                                  .get("photoUrl")),
                            ),
                          ),
                        ),
                      ),
                      text(blockedUsersSnapshot!.docs[index].get("name"),
                          fontSize: 16, color: Colors.black),
                      text(blockedUsersSnapshot!.docs[index].get("email"),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      GestureDetector(
                        onTap: () {
                          showDialogBox(blockedUsersSnapshot!.docs[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 18),
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
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      } else {
        if (dev) printo('No Record of Blocked Users');
        return Center(
            child: text("No Record of Blocked Users",
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.w900,
                color: Colors.black));
      }
    }

    return Scaffold(
      appBar: const NavAppBar(
        title: "Blocked Users Accounts",
      ),
      body: Center(
        child: sizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: blockedUserDesign(),
        ),
      ),
    );
  }
}
