import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/functions/functions.dart';
import 'package:web_admin/global/global.dart';

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

  void adminValidation() {
    if (email.isNotEmpty && password.isNotEmpty) {
      if (dev) printo("Logging Admin in via firebase");
      //validate and log admin in
    } else {
      if (dev) printo("No Admin email or password inputed");
      showReusableSnackBar("Email & Password is Required", context);
    }
  }
}
