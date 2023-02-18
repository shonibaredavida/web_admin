import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';
import 'package:web_admin/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: sizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  Image.asset("images/admin.png"),
                  sizedBox(
                    height: 15,
                  ),
                  textField(
                      onChanged: (value) {
                        email = value;
                      },
                      hintText: "Email",
                      icon: Icons.mail),
                  sizedBox(
                    height: 15,
                  ),
                  textField(
                      onChanged: (value) {
                        password = value;
                      },
                      hintText: "Password",
                      obscureText: true,
                      icon: Icons.password),
                  sizedBox(
                    height: 40,
                  ),
                  elevatedButton(
                      onPressed: () {
                        showReusableSnackBar(
                            "checking Credential, Please Wait", context);
                        adminValidation();
                      },
                      title: "Login",
                      textColor: Colors.white,
                      letterSpacing: 2,
                      fontSize: 16)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void adminValidation() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      if (dev) printo("Logging Admin in via firebase");
      //validate and log admin in
      User? currentAdmin;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        currentAdmin = value.user;
      }).catchError((error) {
        showReusableSnackBar("Error Occured: ${error.toString()}", context);
      });
      if (dev) printo(currentAdmin!.uid);
      //check if admin data exisit in firestore
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          showReusableSnackBar(
              "No record found, You are not an Admin", context);
        }
      });
    } else {
      if (dev) printo("No Admin email or password inputed");
      showReusableSnackBar("Email & Password is Required", context);
    }
  }
}
