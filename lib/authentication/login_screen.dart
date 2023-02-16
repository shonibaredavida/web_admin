import 'package:flutter/material.dart';
import 'package:web_admin/global/global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultBackgroundColor,
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
                      onChanged: (value) {},
                      hintText: "Email",
                      icon: Icons.mail),
                  sizedBox(
                    height: 15,
                  ),
                  textField(
                      onChanged: (value) {},
                      hintText: "Password",
                      obscureText: true,
                      icon: Icons.password),
                  sizedBox(
                    height: 40,
                  ),
                  elevatedButton(
                      onPressed: () {},
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
}
