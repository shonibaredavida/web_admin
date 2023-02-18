import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/authentication/login_screen.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/home_screen/home_screen.dart';

class NavAppBar extends StatefulWidget with PreferredSizeWidget {
  const NavAppBar({
    super.key,
    this.preferredSizedWidget,
  });
  final PreferredSizeWidget? preferredSizedWidget;
  @override
  State<NavAppBar> createState() => _NavAppBarState();

  @override
  //  implement preferredSize
  Size get preferredSize => preferredSizedWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _NavAppBarState extends State<NavAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.red,
                Colors.black,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              // stops: [0.0, 1.0],  #check
              tileMode: TileMode.clamp),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: text("Home", color: Colors.white),
              ),
            ),
            text(" | ", color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: text("Users Pie Chart", color: Colors.white),
              ),
            ),
            text(" | ", color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: text("Sellers PieChart", color: Colors.white),
              ),
            ),
            text(" | ", color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())));
                },
                child: text("Logout", color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
